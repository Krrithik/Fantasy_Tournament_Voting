<?php
require_once("config.php");
require_once("auth.php");
require_once("./index.html");

ensure_logged_in();

if ($_SESSION["user_id"] === "guest") {
    header("Location: guest_denied.php");
    exit;
}

$db = get_pdo_connection();
$user_id = $_SESSION["user_id"];

// Success message (optional)
$success = $_GET["success"] ?? "";

$stmt = $db->prepare("
    SELECT displayname, bio, profile_picture
    FROM users
    WHERE user_id = ?
");
$stmt->execute([$user_id]);
$user = $stmt->fetch(PDO::FETCH_ASSOC);
?>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>
<?php require_once("navbar.php"); ?>

<div class="container mt-4">

    <h2>Edit Profile</h2>

    <?php if ($success === "password"): ?>
        <div class="alert alert-success">Password updated successfully!</div>
    <?php endif; ?>

    <form action="update_profile.php" method="POST" enctype="multipart/form-data" class="mt-3">

        <!-- DISPLAYNAME -->
        <div class="mb-3">
            <label class="form-label">Username</label>
            <input type="text"
                   id="displayname"
                   name="displayname"
                   class="form-control"
                   value="<?= htmlspecialchars($user['displayname']) ?>"
                   required>
            <div id="nameCheck" class="mt-1"></div>
        </div>

        <!-- BIO -->
        <div class="mb-3">
            <label class="form-label">Bio</label>
            <textarea name="bio" class="form-control" rows="5"><?= htmlspecialchars($user['bio']) ?></textarea>
        </div>

        <!-- PROFILE PIC UPLOAD -->
        <div class="mb-3">
            <label class="form-label">Change Profile Picture (optional)</label>
            <input type="file" name="profile_picture" style="max-width: 300px" class="form-control">

            <?php if (!empty($user["profile_picture"])): ?>
                <p class="mt-2">Current image:</p>
                <img src="<?= $user["profile_picture"] ?>?v=<?= time() ?>"
                     class="rounded"
                     style="width:100px;height:100px;object-fit:cover;">

                <div class="mt-2">
                    <a href="delete_profile_picture.php" class="btn btn-danger btn-sm"
                       onclick="return confirm('Remove your profile picture?');">
                        Delete Profile Picture
                    </a>
                </div>
            <?php endif; ?>
        </div>

        <hr>

        <!-- CHANGE PASSWORD SECTION -->
        <h4>Change Password</h4>
        <div class="mb-3">
            <label class="form-label">Current Password</label>
            <input type="password" name="current_password" class="form-control" style="max-width: 300px" placeholder="Enter current password to change">
        </div>

        <div class="mb-3">
            <label class="form-label">New Password</label>
            <input type="password" name="new_password" class="form-control" style="max-width: 300px" placeholder="Enter new password">
        </div>

        <div class="mb-3">
            <label class="form-label">Confirm New Password</label>
            <input type="password" name="confirm_password" class="form-control" style="max-width: 300px" placeholder="Confirm new password">
        </div>

        <button type="submit" id="saveBtn" class="btn btn-primary">Save Changes</button>
        <a href="profile.php" class="btn btn-secondary">Cancel</a>

    </form>

</div>

<script>
$(document).ready(function() {
    $("#displayname").on("input", function() {

        let name = $(this).val().trim();
        let userId = <?= $user_id ?>;

        if (name.length === 0) {
            $("#nameCheck").text("");
            $("#saveBtn").prop("disabled", false);
            return;
        }

        $.get("check_displayname.php", { displayname: name, user_id: userId }, function(response) {
            if (response === "taken") {
                $("#nameCheck").text("Username already taken ❌").css("color", "red");
                $("#saveBtn").prop("disabled", true);
            }
            else if (response === "available") {
                $("#nameCheck").text("Username available ✔").css("color", "green");
                $("#saveBtn").prop("disabled", false);
            }
        });

    });
});
</script>

</body>
</html>
