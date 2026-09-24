<?php
require_once("config.php");

if (!isset($_SESSION["user_id"])) {
    header("Location: guest_denied.php");
    exit;
}

$db = get_pdo_connection();
$id = intval($_GET["id"]);

// Ensure the user owns this tournament
$check = $db->prepare("SELECT * FROM tournament WHERE tournament_id = ? AND user_id = ?");
$check->execute([$id, $_SESSION["user_id"]]);
$t = $check->fetch(PDO::FETCH_ASSOC);

if (!$t) {
    die("<h2 class='text-center text-danger mt-5'>You cannot end this tournament.</h2>");
}

$end = $db->prepare("UPDATE tournament SET tourneystatus = 'Completed' WHERE tournament_id = ?");
$end->execute([$id]);

header("Location: profile.php");
exit;
?>
