<?php require_once("config.php"); ?>

<!DOCTYPE html>
<html>
<head>
    <title>Access Denied</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light d-flex flex-column" style="min-height:100vh;">

<?php require_once("navbar.php"); ?>

<div class="flex-grow-1 d-flex justify-content-center align-items-center">
    <div class="card shadow p-4 text-center" style="width: 420px;">
        <h3 class="mb-3">Guests Cannot Access This Page</h3>
        <p class="text-muted">
            Please create an account or log in to use this feature.
        </p>

        <a href="login.php" class="btn btn-primary w-100 mb-2">Log In</a>
        <a href="register.php" class="btn btn-outline-primary w-100">Create Account</a>
    </div>
</div>

</body>
</html>
