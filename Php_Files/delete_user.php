<?php
require_once("config.php");
require_once("auth.php");

// Only admins can delete users
if ($_SESSION["role"] !== "admin") {
    die("Unauthorized");
}

if (!isset($_GET["id"])) {
    die("No user ID");
}

$userId = intval($_GET["id"]);

$db = get_pdo_connection();

// Prevent admin deleting themselves accidentally
if ($userId == $_SESSION["user_id"]) {
    die("Admins cannot delete their own account.");
}

// FUTURE: Also delete user's tournaments? Or prevent if they own active ones?

$stmt = $db->prepare("DELETE FROM users WHERE user_id = ?");
$stmt->execute([$userId]);

header("Location: admin.php?user_deleted=1");
exit;
