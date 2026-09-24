<?php
require_once("config.php");

if (!isset($_SESSION["user_id"])) {
    header("Location: guest_denied.php");
    exit;
}

$db = get_pdo_connection();

/* ----------------------------------------------
   Round duration (hours)  
   0.008333 hours ≈ ~30 seconds (testing)
---------------------------------------------- */
$ROUND_DURATION_HOURS = 0.008333;
$durationSeconds = (int) round($ROUND_DURATION_HOURS * 3600);


if ($_SERVER["REQUEST_METHOD"] === "POST") {

    $title = trim($_POST["title"]);
    $description = trim($_POST["description"]);
    $start_at = $_POST["start_at"];
    $end_at = $_POST["end_at"];
    $userId = $_SESSION["user_id"];

    // Validate names
    for ($i = 1; $i <= 16; $i++) {
        if (empty($_POST["entry_name_$i"])) {
            die("❌ Error: All 16 entries must have names.");
        }
    }

    try {
        /* ------------------------------------------
           1. Create Tournament
        -------------------------------------------*/
        $stmt = $db->prepare("CALL create_tournament(?,?,?,?,?)");
        $stmt->execute([$title, $description, $start_at, $end_at, $userId]);

        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        $stmt->closeCursor();

        $tournamentId = $row["new_tournament_id"] ?? $db->lastInsertId();


        /* ------------------------------------------
           2. INSERT ENTRIES — FILE UPLOADING
        -------------------------------------------*/

        $entries = [];  

        $insertEntry = $db->prepare("
            INSERT INTO entry (name, description, image_URL, seed, tournament_id)
            VALUES (?, ?, ?, ?, ?)
        ");

        // ABSOLUTE directory on server
        $uploadRoot = __DIR__ . "/uploads/entry_images/";  

        // PUBLIC URL path stored in DB
        $publicRoot = "uploads/entry_images/";

        if (!is_dir($uploadRoot)) {
            mkdir($uploadRoot, 0777, true);
        }

        for ($i = 1; $i <= 16; $i++) {

            $name = trim($_POST["entry_name_$i"]);
            $desc = trim($_POST["entry_desc_$i"]);
            $imagePath = NULL;

            // -----------------------
            // FILE UPLOAD HANDLING
            // -----------------------
            if (!empty($_FILES["entry_img"]["name"][$i])) {

                $original = basename($_FILES["entry_img"]["name"][$i]);

                // sanitize filename
                $clean = preg_replace("/[^A-Za-z0-9._-]/", "_", $original);

                $filename = "{$tournamentId}_{$i}_" . time() . "_" . $clean;

                $serverFile = $uploadRoot . $filename;   
                $publicFile = $publicRoot . $filename;   // what goes in DB

                if (move_uploaded_file($_FILES["entry_img"]["tmp_name"][$i], $serverFile)) {
                    $imagePath = $publicFile;
                }
            }

            $insertEntry->execute([$name, $desc, $imagePath, $i, $tournamentId]);
            $entries[] = $db->lastInsertId();
        }


        /* ------------------------------------------
           3. ROUND 1 MATCHUPS
        -------------------------------------------*/
        $insertMatchup = $db->prepare("
            INSERT INTO matchup 
                (round_number, status, opens_at, closes_at, tournament_id, entryA_id, entryB_id)
            VALUES (1, 'Active', ?, ?, ?, ?, ?)
        ");

        $now = new DateTime("now");
        $round1_open = $now->format("Y-m-d H:i:s");

        $round1_close_dt = clone $now;
        $round1_close_dt->modify("+{$durationSeconds} seconds");
        $round1_close = $round1_close_dt->format("Y-m-d H:i:s");

        $pairs = [
            [0, 15], [1, 14], [2, 13], [3, 12],
            [4, 11], [5, 10], [6, 9], [7, 8]
        ];

        foreach ($pairs as [$a, $b]) {
            $insertMatchup->execute([
                $round1_open,
                $round1_close,
                $tournamentId,
                $entries[$a],
                $entries[$b]
            ]);
        }

        


        /* ------------------------------------------
           4. FUTURE ROUNDS
        -------------------------------------------*/
        $insertEmpty = $db->prepare("
            INSERT INTO matchup 
                (round_number, status, opens_at, closes_at, tournament_id, entryA_id, entryB_id)
            VALUES (?, 'Upcoming', ?, ?, ?, NULL, NULL)
        ");

        // Round 2
        $r2_open = $round1_close;
        $r2_close = date("Y-m-d H:i:s", strtotime($r2_open) + $durationSeconds);
        for ($i = 0; $i < 4; $i++) {
            $insertEmpty->execute([2, $r2_open, $r2_close, $tournamentId]);
        }

        // Round 3
        $r3_open = $r2_close;
        $r3_close = date("Y-m-d H:i:s", strtotime($r3_open) + $durationSeconds);
        for ($i = 0; $i < 2; $i++) {
            $insertEmpty->execute([3, $r3_open, $r3_close, $tournamentId]);
        }

        // Final
        $r4_open = $r3_close;
        $r4_close = date("Y-m-d H:i:s", strtotime($r4_open) + $durationSeconds);
        $insertEmpty->execute([4, $r4_open, $r4_close, $tournamentId]);


        /* ------------------------------------------
           5. Redirect
        -------------------------------------------*/
        header("Location: round8.php?tournament_id=$tournamentId");
        exit;

    } catch (PDOException $e) {
        echo "<strong>Error creating tournament:</strong> " . htmlspecialchars($e->getMessage());
    }
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>Create Tournament</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<?php require_once("navbar.php"); ?>

<div class="container mt-4">
    <h2>Create Tournament</h2>

    <form method="POST" enctype="multipart/form-data" class="card p-4 shadow">
        
        <label>Title:</label>
        <input type="text" name="title" class="form-control mb-2" required>

        <label>Description:</label>
        <textarea name="description" class="form-control mb-2" required></textarea>

        <label>Start Date/Time:</label>
        <input type="datetime-local" name="start_at" class="form-control mb-2" required>

        <label>End Date/Time:</label>
        <input type="datetime-local" name="end_at" class="form-control mb-2" required>

        <hr>
        <h4>Entries (16 required)</h4>

        <div class="row">
        <?php for ($i = 1; $i <= 16; $i++): ?>
           <div class="col-md-6 mb-3">
                <div class="card p-3">
                    <h5>Entry <?= $i ?></h5>

                    <label>Name:</label>
                    <input type="text" name="entry_name_<?= $i ?>" class="form-control" required>

                    <label class="mt-2">Description (optional):</label>
                    <input type="text" name="entry_desc_<?= $i ?>" class="form-control">

                    <label class="mt-2">Image (optional):</label>
                    <input 
                        type="file"
                        name="entry_img[<?= $i ?>]"
                        class="form-control entry-image-input"
                        accept="image/*"
                        data-preview="preview_<?= $i ?>"
                    >

                    <div class="mt-2 text-center">
                        <img id="preview_<?= $i ?>" 
                             src="#" 
                             style="max-width: 100%; max-height: 150px; display:none; border-radius:6px;">
                    </div>

                </div>
            </div>
        <?php endfor; ?>
        </div>

        <button class="btn btn-primary w-100 mt-3">Create Tournament</button>
    </form>

</div>

<script>
// Live image preview
document.querySelectorAll(".entry-image-input").forEach(input => {
    input.addEventListener("change", function() {
        let file = this.files[0];
        let previewId = this.getAttribute("data-preview");
        let previewImg = document.getElementById(previewId);

        if (file) {
            let reader = new FileReader();
            reader.onload = e => {
                previewImg.src = e.target.result;
                previewImg.style.display = "block";
            };
            reader.readAsDataURL(file);
        } else {
            previewImg.src = "#";
            previewImg.style.display = "none";
        }
    });
});
</script>

</body>
</html>
