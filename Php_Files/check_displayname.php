<?php
require_once("config.php");

if (!isset($_GET['displayname'])) {
    echo "invalid";
    exit;
}

$db = get_pdo_connection();
$displayname = trim($_GET['displayname']);
$user_id = isset($_GET['user_id']) ? intval($_GET['user_id']) : 0;

// Query to check if name exists for another user
$stmt = $db->prepare("
    SELECT user_id 
    FROM users 
    WHERE LOWER(displayname) = LOWER(?)
      AND user_id != ?
");
$stmt->execute([$displayname, $user_id]);

echo ($stmt->rowCount() > 0) ? "taken" : "available";
?>
