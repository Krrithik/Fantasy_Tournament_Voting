<?php
require_once("config.php");

// Mark this session as a guest
$_SESSION["role"] = "guest";
unset($_SESSION["user_id"]);

// (optional) set a display name so the UI can say "Guest"
if (!isset($_SESSION["displayname"])) {
    $_SESSION["displayname"] = "Guest";
}

header("Location: index.php");
exit;
