<?php

// Change this to your project name
define("PROJECT_NAME", "Fantasy-Tourney");

date_default_timezone_set('America/Los_Angeles');

error_reporting(E_ALL);
ini_set("log_errors", 1);
ini_set("display_errors", 1);
ini_set("error_log", "/home/stu/fantasytourney/php_errors.log");

// Start session
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

// Get PDO connection
function get_pdo_connection() {
    static $conn;

    if (!isset($conn)) {
        try {
            $options = [
                PDO::ATTR_PERSISTENT => true,
                PDO::ATTR_EMULATE_PREPARES => true
            ];

            $dbname = "fantasytourney";
            $username = "fantasytourney";
            $password = "Wef1,siwc";

            $conn = new PDO(
                "mysql:host=localhost;dbname=$dbname",
                $username,
                $password,
                $options
            );
        }
        catch (PDOException $pe) {
            echo "Error connecting: " . $pe->getMessage();
            die();
        }
    }

    return $conn;
}

function update_tournament_statuses() {
    $db = get_pdo_connection();

    /* -------------------------------
       1. Update tournament statuses
    --------------------------------*/
    $db->query("
        UPDATE tournament
        SET tourneystatus = 'Active'
        WHERE start_at <= NOW()
          AND (end_at IS NULL OR end_at > NOW())
          AND tourneystatus != 'Active'
    ");

    $db->query("
        UPDATE tournament
        SET tourneystatus = 'Completed'
        WHERE end_at IS NOT NULL
          AND end_at <= NOW()
          AND tourneystatus != 'Completed'
    ");

    /* -------------------------------
       2. Close matchups whose time expired
    --------------------------------*/
    $db->query("
        UPDATE matchup
        SET status = 'Completed'
        WHERE closes_at <= NOW()
          AND status = 'Active'
    ");

    /* -------------------------------
       3. Activate next matchups when their start time arrives
    --------------------------------*/
    $db->query("
        UPDATE matchup
        SET status = 'Active'
        WHERE opens_at <= NOW()
          AND status = 'Upcoming'
    ");

    /* -------------------------------
       4. Advance winners to next round
    --------------------------------*/
    advance_winners_to_next_round();
}


/* --------------------------------------------------------------
  Matchups transition strictly on DATETIME
-------------------------------------------------------------- */
function update_matchups_by_time() {
    $db = get_pdo_connection();

    // Get all tournaments
    $tournaments = $db->query("SELECT tournament_id FROM tournament")
                      ->fetchAll(PDO::FETCH_COLUMN);

    foreach ($tournaments as $tournamentId) {

        // Get all rounds for this tournament
        $rounds = $db->prepare("
            SELECT DISTINCT round_number 
            FROM matchup 
            WHERE tournament_id = ?
            ORDER BY round_number
        ");
        $rounds->execute([$tournamentId]);
        $roundList = $rounds->fetchAll(PDO::FETCH_COLUMN);

        foreach ($roundList as $roundNum) {

            // Get ALL matchups for this round
            $stmt = $db->prepare("
                SELECT matchup_id, status, opens_at, closes_at
                FROM matchup
                WHERE tournament_id = ?
                  AND round_number = ?
                ORDER BY matchup_id
            ");
            $stmt->execute([$tournamentId, $roundNum]);
            $matchups = $stmt->fetchAll(PDO::FETCH_ASSOC);

            if (!$matchups) continue;

            //  RULE: A round can only activate if the previous round is fully completed.
            if ($roundNum > 1) {
                $prevStmt = $db->prepare("
                    SELECT COUNT(*) 
                    FROM matchup
                    WHERE tournament_id = ?
                      AND round_number = ?
                      AND status != 'Completed'
                ");
                $prevStmt->execute([$tournamentId, $roundNum - 1]);
                $unfinishedPrev = $prevStmt->fetchColumn();

                if ($unfinishedPrev > 0) {
                    // Prevent this round from starting
                    continue;
                }
            }

            // PROCESS MATCHUPS NORMALLY
            foreach ($matchups as $m) {
                $id = $m["matchup_id"];

                // Activate
                if ($m["status"] === "Upcoming" && $m["opens_at"] <= date("Y-m-d H:i:s")) {
                    $activate = $db->prepare("UPDATE matchup SET status='Active' WHERE matchup_id=?");
                    $activate->execute([$id]);
                }

                // Complete
                if ($m["status"] === "Active" && $m["closes_at"] <= date("Y-m-d H:i:s")) {
                    $complete = $db->prepare("UPDATE matchup SET status='Completed' WHERE matchup_id=?");
                    $complete->execute([$id]);
                }
            }
        }
    }
}


/* --    PDO::ATTR_ERRMODE         => PDO::ERRMODE_EXCEPTION,------------------------------------------------------------
  Stable next-round advancement
   Only advances when:
   - All matchups in the round are Completed
   - All have winner_entry_id assigned (trigger already does that)
   - The number of winners matches number needed
-------------------------------------------------------------- */
function advance_winners_to_next_round() {
    $db = get_pdo_connection();
// NEW: Compute winner_entry_id for all completed matchups missing one
$winnerStmt = $db->prepare("
    SELECT 
        m.matchup_id,
        m.entryA_id, m.entryB_id,
        COALESCE((SELECT COUNT(*) FROM vote WHERE matchup_id = m.matchup_id AND entry_id = m.entryA_id), 0) AS votesA,
        COALESCE((SELECT COUNT(*) FROM vote WHERE matchup_id = m.matchup_id AND entry_id = m.entryB_id), 0) AS votesB
    FROM matchup m
    WHERE m.status = 'Completed'
      AND m.winner_entry_id IS NULL
      AND m.entryA_id IS NOT NULL
      AND m.entryB_id IS NOT NULL
");

$winnerStmt->execute();
$completedMatchups = $winnerStmt->fetchAll(PDO::FETCH_ASSOC);

// Update winners
$setWinner = $db->prepare("UPDATE matchup SET winner_entry_id = ? WHERE matchup_id = ?");

foreach ($completedMatchups as $m) {
    $winner = null;

    if ($m["votesA"] > $m["votesB"]) {
        $winner = $m["entryA_id"];
    }
    else if ($m["votesB"] > $m["votesA"]) {
        $winner = $m["entryB_id"];
    }
    else {
        // Tie → lowest entry_id (works like lowest seed)
        $winner = min($m["entryA_id"], $m["entryB_id"]);
    }

    $setWinner->execute([$winner, $m["matchup_id"]]);
}

    $tournaments = $db->query("
        SELECT tournament_id
        FROM tournament
    ")->fetchAll(PDO::FETCH_COLUMN);

    foreach ($tournaments as $tournamentId) {

        $maxRoundStmt = $db->prepare("
            SELECT MAX(round_number)
            FROM matchup
            WHERE tournament_id = ?
        ");
        $maxRoundStmt->execute([$tournamentId]);
        $maxRound = (int)$maxRoundStmt->fetchColumn();

        for ($round = 1; $round < $maxRound; $round++) {

            // Get matchups in this round
            $stmt = $db->prepare("
                SELECT matchup_id, winner_entry_id, status
                FROM matchup
                WHERE tournament_id = ?
                  AND round_number = ?
                ORDER BY matchup_id
            ");
            $stmt->execute([$tournamentId, $round]);
            $matchups = $stmt->fetchAll(PDO::FETCH_ASSOC);

            if (count($matchups) === 0) continue;

            // Require all winners + completed
            foreach ($matchups as $m) {
                if ($m["status"] !== "Completed" || $m["winner_entry_id"] === null) {
                    continue 2; 
                }
            }

            $nextRound = $round + 1;

            // Load next round
            $nextStmt = $db->prepare("
                SELECT matchup_id, entryA_id, entryB_id
                FROM matchup
                WHERE tournament_id = ?
                  AND round_number = ?
                ORDER BY matchup_id
            ");
            $nextStmt->execute([$tournamentId, $nextRound]);
            $nextRoundMatchups = $nextStmt->fetchAll(PDO::FETCH_ASSOC);

            if (count($nextRoundMatchups) === 0) continue;

            // Allow advancing when target matchups are empty
            // Block advancement ONLY if next round already has entries
            foreach ($nextRoundMatchups as $nr) {
                if ($nr["entryA_id"] !== null || $nr["entryB_id"] !== null) {
                    continue 2; 
                }
            }


            // winners needed
            $neededWinners = count($nextRoundMatchups) * 2;
            if (count($matchups) !== $neededWinners) continue;

            // assign winners
            $winnerIndex = 0;
            foreach ($nextRoundMatchups as $nr) {
                $winnerA = $matchups[$winnerIndex]["winner_entry_id"];
                $winnerB = $matchups[$winnerIndex + 1]["winner_entry_id"];
                $winnerIndex += 2;

                $update = $db->prepare("
                    UPDATE matchup
                    SET entryA_id = ?, entryB_id = ?
                    WHERE matchup_id = ?
                ");
                $update->execute([$winnerA, $winnerB, $nr["matchup_id"]]);
            }
        }
    }
}



?>
