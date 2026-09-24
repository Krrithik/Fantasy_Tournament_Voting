<style>
#display-check {
    display:block;
    margin-top:4px;
}
</style>

<?php
require_once("config.php");
require_once("./index.html");

// PROCESS FORM SUBMISSION
$message = "";
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $email = trim($_POST["email"]);
    $displayname = trim($_POST["displayname"]);
    $password = trim($_POST["password"]);
    $role = "player";   

    // Basic validation
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $message = "❌ Invalid email format.";
    } elseif (strlen($password) < 6) {
        $message = "❌ Password must be at least 6 characters.";
    } else {
        // check duplicate displayname
        $db = get_pdo_connection();
        $check = $db->prepare("SELECT COUNT(*) FROM users WHERE displayname = ?");
        $check->execute([$displayname]);
        $exists = $check->fetchColumn();

        if ($exists > 0) {
            $message = "❌ Display name already taken!";
        } else {
            // Insert new user with selected role
            $hash = password_hash($password, PASSWORD_DEFAULT);

            try{
                $stmt = $db->prepare("CALL register_user(?,?,?,?)");
                $stmt->execute([$email, $hash, $displayname, $role]);

                //  FIRST RESULT SET FROM PROCEDURE HAS A `message` COLUMN
                $row = $stmt->fetch(PDO::FETCH_ASSOC);
                $stmt->closeCursor();

                // If procedure returned an error message like "ERROR: Email already exists"
                if ($row && isset($row['message']) && strpos($row['message'], 'ERROR') === 0) {
                    $message = "❌ " . $row['message'];
                } else {
                    // Success – redirect to login
                    header("Location: login.php?registered=1");
                    exit;
                }

            } catch (PDOException $e) {
                $message = "❌ Database error: " . htmlspecialchars($e->getMessage());
            }
        }
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Create Account</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light d-flex justify-content-center align-items-center" style="height:100vh;">

<div class="card shadow" style="width: 380px;">
    <div class="card-body">
        <h3 class="text-center mb-3">Create Account</h3>

        <?php if ($message): ?>
        <div class="alert alert-danger"><?php echo $message; ?></div>
        <?php endif; ?>

        <form method="POST">

            <!-- Email -->
            <label>Email:</label>
            <input type="email" name="email" class="form-control mb-2" required>

            <!-- Display Name -->
            <label class="mt-2">Display Name:</label>
            <input type="text" name="displayname" id="displayname" class="form-control" required>
            <small id="display-check" class="text-danger"></small>

            <!-- Password -->
            <label>Password:</label>
            <input type="password" id="password" name="password" class="form-control" required>

            <!-- Strength bar -->
            <div class="mt-2">
                <div id="pw-strength-bar" style="height: 8px; width: 100%; background:#ccc; border-radius:4px;">
                    <div id="pw-strength-fill" style="height:100%; width:0%; background:red; border-radius:4px;"></div>
                </div>
                <small id="pw-strength-text"></small>
            </div>

            
            
            <button class="btn btn-primary w-100 mt-3">Create Account</button>
        </form>

        <hr>
        <a href="login.php" class="btn btn-link w-100">Already have an account? Log in</a>
    </div>
</div>

<script>
// ===== PASSWORD METER =====
document.getElementById("password").addEventListener("input", function () {
    let pw = this.value;
    let score = 0;

    if (pw.length >= 6) score++;
    if (pw.match(/[A-Z]/)) score++;
    if (pw.match(/[0-9]/)) score++;
    if (pw.match(/[^A-Za-z0-9]/)) score++;

    const bar = document.getElementById("pw-strength-fill");
    const text = document.getElementById("pw-strength-text");

    const widths = ["10%", "40%", "70%", "100%"];
    const colors = ["red", "orange", "gold", "green"];
    const labels = ["Weak", "Fair", "Good", "Strong"];

    bar.style.width = widths[score-1] || "5%";
    bar.style.background = colors[score-1] || "red";
    text.innerHTML = labels[score-1] || "";
});

// ===== LIVE DISPLAYNAME CHECK =====
document.getElementById("displayname").addEventListener("keyup", function () {
    const name = this.value.trim();

    if (name.length === 0) {
        document.getElementById("display-check").innerHTML = "";
        return;
    }

    fetch("check_displayname.php?displayname=" + encodeURIComponent(name))
        .then(res => res.json())
        .then(data => {
            const box = document.getElementById("display-check");

            if (data.exists) {
                box.innerHTML = "❌ Display name already taken";
                box.classList.remove("text-success");
                box.classList.add("text-danger");
            } else {
                box.innerHTML = "✔ Display name available";
                box.classList.remove("text-danger");
                box.classList.add("text-success");
            }
        })
        .catch(err => console.error(err));
});
</script>

</body>
</html>
