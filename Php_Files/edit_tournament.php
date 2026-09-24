<?php
require_once("config.php");
require_once("navbar.php");

if (!isset($_SESSION["user_id"])) {
    header("Location: guest_denied.php");
    exit;
}

$db = get_pdo_connection();

$id = intval($_GET["id"]);

// Ensure the logged-in user owns this tournament
$check = $db->prepare("SELECT * FROM tournament WHERE tournament_id = ? AND user_id = ?");
$check->execute([$id, $_SESSION["user_id"]]);
$t = $check->fetch(PDO::FETCH_ASSOC);

if (!$t) {
    die("<h2 class='text-center mt-5 text-danger'>You cannot edit this tournament.</h2>");
}

// Convert MySQL datetime → datetime-local format
$startValue = "";
if (!empty($t["start_at"])) {
    $startValue = date("Y-m-d\TH:i", strtotime($t["start_at"]));
}

$endValue = "";
if (!empty($t["end_at"])) {
    $endValue = date("Y-m-d\TH:i", strtotime($t["end_at"]));
}

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $title = trim($_POST["title"]);
    $description = trim($_POST["description"]);
    $start = $_POST["start_at"];
    $end = !empty($_POST["end_at"]) ? $_POST["end_at"] : NULL;

    $update = $db->prepare("
        UPDATE tournament SET 
            title = ?, 
            description = ?, 
            start_at = ?, 
            end_at = ?
        WHERE tournament_id = ?
    ");
    $update->execute([$title, $description, $start, $end, $id]);

    header("Location: profile.php");
    exit;
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Tournament</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">
<div class="container mt-4">

    <h2>Edit Tournament</h2>

    <form method="POST" class="card p-4 shadow" style="max-width:600px;">

        <label class="mb-1">Title:</label>
        <input type="text" 
               name="title" 
               class="form-control mb-3" 
               value="<?= htmlspecialchars($t['title']) ?>" 
               required>

        <label class="mb-1">Description:</label>
        <textarea name="description" 
                  class="form-control mb-3" 
                  required><?= htmlspecialchars($t['description']) ?></textarea>

        <label class="mb-1">Start Date & Time:</label>
        <input type="datetime-local" 
               name="start_at" 
               class="form-control mb-3" 
               value="<?= $startValue ?>" 
               required>

        <label class="mb-1">End Date & Time:</label>
        <input type="datetime-local" 
               name="end_at" 
               class="form-control mb-3" 
               value="<?= $endValue ?>">

        <button class="btn btn-primary w-100 mt-3">Save Changes</button>
    </form>

    <p class="text-muted mt-3">
        Entries cannot be edited after a tournament is created.
        To change entries, delete this tournament and create a new one.
    </p>

</div>
</body>
</html>
