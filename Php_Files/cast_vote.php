<?php
require_once("config.php");
require_once("auth.php");

ensure_logged_in(); // Only logged-in users can vote

$userId = $_SESSION["user_id"] ?? null;
$entryId = $_POST["entry_id"] ?? null;
$matchupId = $_POST["matchup_id"] ?? null;

// Basic validation
if (!$userId || !$entryId || !$matchupId) {
    die("Missing data.");
}

$db = get_pdo_connection();

// Check if matchup is active and the entry is valid
$matchupCheck = $db->prepare("
    SELECT * FROM matchup 
    WHERE matchup_id = ? AND status = 'Active'
");
$matchupCheck->execute([$matchupId]);
$matchup = $matchupCheck->fetch(PDO::FETCH_ASSOC);

if (!$matchup) {
    die("Invalid or inactive matchup.");
}

// Check if entry_id belongs to this matchup
if ($entryId != $matchup["entryA_id"] && $entryId != $matchup["entryB_id"]) {
    die("Invalid entry for this matchup.");
}

// Check if user already voted on this matchup
$voteCheck = $db->prepare("
    SELECT COUNT(*) FROM vote 
    WHERE user_id = ? AND matchup_id = ?
");
$voteCheck->execute([$userId, $matchupId]);
$hasVoted = $voteCheck->fetchColumn();

if ($hasVoted) {
    die("You've already voted in this matchup.");
}

// Insert the vote
$insertVote = $db->prepare("
    INSERT INTO vote (user_id, matchup_id, entry_id, cast_at)
    VALUES (?, ?, ?, NOW())
");
$insertVote->execute([$userId, $matchupId, $entryId]);

// Redirect back to the same tournament
header("Location: round8.php?tournament_id=" . urlencode($matchup["tournament_id"]) . "&voted=1");
exit;
