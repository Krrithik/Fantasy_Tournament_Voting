<?php
require_once("config.php");
require_once("auth.php");

ensure_logged_in();

$db = get_pdo_connection();

if (!isset($_GET["id"])) {
    die("Invalid tournament ID.");
}

$tournamentId = intval($_GET["id"]);
$userId = $_SESSION["user_id"];

// 1. Check ownership
$check = $db->prepare("SELECT user_id FROM tournament WHERE tournament_id = ?");
$check->execute([$tournamentId]);
$row = $check->fetch(PDO::FETCH_ASSOC);

if (!$row) {
    die("Tournament not found.");
}

// Allow admins to delete any tournament
if ($_SESSION["role"] !== "admin" && $row["user_id"] != $userId) {
    die("You do not have permission to delete this tournament.");
}

// 2. Call stored procedure
try {
    $call = $db->prepare("CALL delete_tournament(?, ?, ?)");
    $call->execute([$tournamentId, $_SESSION['role'], $_SESSION['user_id']]);


    // Drain all results from the procedure
    do {
        $call->fetchAll();
    } while ($call->nextRowset());
    $call->closeCursor();

    header("Location: profile.php?deleted=1");
    exit;

} catch (PDOException $e) {
    echo "<h3>Error running delete_tournament procedure:</h3>";
    echo $e->getMessage();
}

