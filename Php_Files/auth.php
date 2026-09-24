<?php

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

function is_guest() {
    return (isset($_SESSION["role"]) && $_SESSION["role"] === "guest");
}

function ensure_logged_in() {
    // If not a real logged-in user, show the custom "denied" page
    if (!isset($_SESSION["user_id"]) || is_guest()) {
        // Optional: pass where they came from (e.g., stats) as a query param
        header("Location: guest_denied.php?from=statistics");
        exit;
    }
}

function ensure_admin() {
    if (!isset($_SESSION["role"]) || $_SESSION["role"] !== "admin") {
        die("Error: You do not have permission to access this page.");
    }
}

function deny_guests() {
    if (is_guest()) {
        header("Location: guest_denied.php");
        exit;
    }
}
