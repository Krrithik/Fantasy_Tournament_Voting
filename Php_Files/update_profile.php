<?php
require_once("config.php");
require_once("auth.php");

ensure_logged_in();

if ($_SESSION["user_id"] === "guest") {
    header("Location: guest_denied.php");
    exit;
}

$db = get_pdo_connection();
$user_id = intval($_SESSION["user_id"]);

// --------------------------------------------------
// Fetch current values (so we don't overwrite fields)
// --------------------------------------------------
$stmt = $db->prepare("SELECT displayname, bio, profile_picture, password FROM users WHERE user_id = ?");
$stmt->execute([$user_id]);
$current = $stmt->fetch(PDO::FETCH_ASSOC);

// ==================================================
// 1. CHANGE PASSWORD LOGIC
// ==================================================
$current_pw = $_POST["current_password"] ?? "";
$new_pw     = $_POST["new_password"] ?? "";
$confirm_pw = $_POST["confirm_password"] ?? "";

// If ANY password field is filled → treat it as a password change attempt
if ($current_pw || $new_pw || $confirm_pw) {

    // Require all fields
    if (empty($current_pw) || empty($new_pw) || empty($confirm_pw)) {
        die("❌ All password fields must be filled. <a href='edit_profile.php'>Go Back</a>");
    }

    // Verify new passwords match
    if ($new_pw !== $confirm_pw) {
        die("❌ New passwords do not match. <a href='edit_profile.php'>Go Back</a>");
    }

    // Verify CURRENT password
    if (!password_verify($current_pw, $current["password"])) {
        die("❌ Current password is incorrect. <a href='edit_profile.php'>Go Back</a>");
    }

    // Hash & update new password
    $new_hash = password_hash($new_pw, PASSWORD_DEFAULT);

    $stmt = $db->prepare("UPDATE users SET password = ? WHERE user_id = ?");
    $stmt->execute([$new_hash, $user_id]);

    // Redirect with success message
    header("Location: edit_profile.php?success=password");
    exit;
}

// ==================================================
// 2. UPDATE DISPLAYNAME + BIO
// ==================================================
$new_displayname = trim($_POST["displayname"]);
$new_bio = isset($_POST["bio"]) ? trim($_POST["bio"]) : $current["bio"];

// Ensure displayname not already taken
$stmt = $db->prepare("
    SELECT user_id
    FROM users
    WHERE LOWER(displayname) = LOWER(?)
      AND user_id != ?
");
$stmt->execute([$new_displayname, $user_id]);

if ($stmt->rowCount() > 0) {
    die("That username is already taken. <a href='edit_profile.php'>Go Back</a>");
}

$stmt = $db->prepare("
    UPDATE users
    SET displayname = ?, bio = ?
    WHERE user_id = ?
");
$stmt->execute([$new_displayname, $new_bio, $user_id]);

$_SESSION["displayname"] = $new_displayname;

// ==================================================
// 3. HANDLE PROFILE PICTURE UPLOAD
// ==================================================
if (!empty($_FILES["profile_picture"]["name"])) {

    $dir = "uploads/profile_pics/";

    if (!is_dir($dir)) {
        mkdir($dir, 0777, true);
    }

    $filename = $user_id . "_" . time() . "_" . basename($_FILES["profile_picture"]["name"]);
    $target_path = $dir . $filename;

    if (!move_uploaded_file($_FILES["profile_picture"]["tmp_name"], $target_path)) {
        die("Upload failed — check folder permissions: $dir");
    }

    $stmt = $db->prepare("UPDATE users SET profile_picture = ? WHERE user_id = ?");
    $stmt->execute([$target_path, $user_id]);
}

header("Location: profile.php");
exit;
?>
