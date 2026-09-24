<?php
require_once("config.php");
require_once("auth.php");

ensure_logged_in();

$user_id = intval($_SESSION["user_id"]);

$db = get_pdo_connection();

// Set profile picture to NULL (default avatar will be used)
$stmt = $db->prepare("UPDATE users SET profile_picture = NULL WHERE user_id = ?");
$stmt->execute([$user_id]);

header("Location: edit_profile.php");
exit;
?>
