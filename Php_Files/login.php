<?php
require_once("config.php");
require_once("./index.html");

$message = "";
if (isset($_GET["registered"])) {
    $message = "🎉 Account created! Please log in.";
}

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $email = trim($_POST["email"]);
    $password = trim($_POST["password"]);

    $db = get_pdo_connection();
    $q = $db->prepare("SELECT * FROM users WHERE email = ?");
    $q->execute([$email]);
    $user = $q->fetch(PDO::FETCH_ASSOC);

    if ($user && password_verify($password, $user["password"])) {
        $_SESSION["user_id"]      = $user["user_id"];
        $_SESSION["role"]         = $user["role"];
        $_SESSION["displayname"]  = $user["displayname"];

        header("Location: welcome.php");
        exit;
    } else {
        $message = "❌ Invalid login.";
    }
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>Log In</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light d-flex justify-content-center align-items-center" style="height:100vh;">

<div class="card shadow" style="width: 380px;">
    <div class="card-body">

        <h3 class="text-center mb-3">Log In</h3>

        <?php if ($message): ?>
        <div class="alert alert-info"><?php echo $message; ?></div>
        <?php endif; ?>

        <form method="POST">
            <label>Email:</label>
            <input type="email" name="email" class="form-control mb-2" required>

            <label>Password:</label>
            <input type="password" name="password" class="form-control mb-3" required>

            <button class="btn btn-primary w-100">Log In</button>
            <a href="guest_login.php" class="btn btn-secondary w-100 mt-2">Continue as Guest</a>

        </form>

        <hr>
        <a href="register.php" class="btn btn-link w-100">Create an account</a>
    </div>
</div>

</body>
</html>
