<?php
require_once("config.php");

// Mark this session as a guest
$_SESSION["role"] = "guest";
unset($_SESSION["user_id"]);

if (!isset($_SESSION["displayname"])) {
    $_SESSION["displayname"] = "Guest";
}

header("Location: welcome.php");
exit;
