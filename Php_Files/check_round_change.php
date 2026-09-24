<?php
require_once("config.php");

// Do NOT session_start() here — config.php already handles it

$tournamentId = intval($_GET["tournament_id"]);
$db = get_pdo_connection();

// Build a hash based on matchup state
$stmt = $db->prepare("
    SELECT 
        matchup_id,
        round_number,
        status,
        entryA_id,
        entryB_id,
        winner_entry_id,
        opens_at,
        closes_at
    FROM matchup
    WHERE tournament_id = ?
    ORDER BY matchup_id
");
$stmt->execute([$tournamentId]);
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Create a consistent snapshot hash
$hash = md5(json_encode($rows));

// Load previous hash
$lastHash = $_SESSION["matchup_hash_$tournamentId"] ?? null;

$response = ["changed" => false];

if ($hash !== $lastHash) {
    $response["changed"] = true;
}

// Save this run's hash
$_SESSION["matchup_hash_$tournamentId"] = $hash;

// Always return clean JSON
header("Content-Type: application/json");
echo json_encode($response);
exit;
