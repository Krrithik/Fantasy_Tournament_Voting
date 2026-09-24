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

// ------------------------------
// Fetch user profile info
// ------------------------------
$stmt = $db->prepare("
    SELECT displayname, bio, profile_picture
    FROM users
    WHERE user_id = ?
");
$stmt->execute([$user_id]);
$user = $stmt->fetch(PDO::FETCH_ASSOC);

// ------------------------------
// Tournaments created by user
// ------------------------------
$q = $db->prepare("
    SELECT tournament_id, title, tourneystatus 
    FROM tournament 
    WHERE user_id = ?
");
$q->execute([$user_id]);
$myTournaments = $q->fetchAll(PDO::FETCH_ASSOC);

// ------------------------------
// Detailed vote history
// ------------------------------

// probably could make this a view
$q3 = $db->prepare("
    SELECT 
        m.tournament_id,
        t.title AS tournament_title,
        m.round_number,
        e_choice.name AS chosen_entry,
        eA.name AS entryA_name,
        eB.name AS entryB_name,
        v.cast_at,
        v.matchup_id
    FROM vote v
    JOIN matchup m      ON v.matchup_id = m.matchup_id
    JOIN tournament t   ON m.tournament_id = t.tournament_id
    JOIN entry e_choice ON v.entry_id = e_choice.entry_id
    JOIN entry eA       ON m.entryA_id = eA.entry_id
    JOIN entry eB       ON m.entryB_id = eB.entry_id
    WHERE v.user_id = ?
    ORDER BY m.round_number ASC, v.cast_at DESC
");
$q3->execute([$user_id]);
$myVotes = $q3->fetchAll(PDO::FETCH_ASSOC);
?>
<!DOCTYPE html>
<html>
<head>
    <style>
    body {
        background: linear-gradient(135deg, #EEF2F3 0%, #DDE1E7 100%);
        min-height: 100vh;
    }

    /* NAVBAR stronger and cleaner */
    .navbar {
        background-color: #1F2937 ;
    }

    /* White profile section with subtle shadow */
    .profile-container {
        background: #FFFFFF;
        border-radius: 12px;
        padding: 30px;
        box-shadow: 0 6px 18px rgba(0,0,0,0.08);
        margin-bottom: 30px;
    }

    /* Slightly tinted second card type for contrast */
    .profile-container.alt {
        background: #FAFBFF;
        border-radius: 12px;
        padding: 30px;
        box-shadow: 0 6px 18px rgba(0,0,0,0.06);
        margin-bottom: 30px;
    }

    .section-title {
        font-weight: 600;
        margin-top: 15px;
        margin-bottom: 20px;
        font-size: 1.4rem;
        color: #2C3E50;
        border-left: 4px solid #4A90E2;
        padding-left: 10px;
    }

    .accordion-item {
        border-radius: 10px !important;
        overflow: hidden;
        margin-bottom: 10px;
        border: 1px solid #d1d5db;
        background: #FFFFFF;
    }

    .accordion-button {
        font-weight: 500;
        background: #F3F4F6;
    }

    .accordion-button:not(.collapsed) {
        background: #E5E7EB;
        color: #1F2937;
    }
</style>


    <title>Your Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
<?php require_once("navbar.php"); ?>

<div class="container mt-4">

    <!-- USER HEADER -->
    <div class="profile-container alt">
        <div class="d-flex align-items-center">

            <div>
                <?php 
                $pic = !empty($user["profile_picture"]) 
                    ? $user["profile_picture"] 
                    : "uploads/profile_pics/default-avatar.png";
                ?>
                <img src="<?= $pic ?>?v=<?= time() ?>" 
                    class="rounded-circle" 
                    style="width:120px;height:120px;object-fit:cover;">
            </div>

            <div class="ms-4">
                <h2>Hello, <?= htmlspecialchars($_SESSION["displayname"]); ?></h2>

                <?php if (!empty($user["bio"])): ?>
                    <p class="mt-2"><?= nl2br(htmlspecialchars($user["bio"])); ?></p>
                <?php else: ?>
                    <p class="text-muted"><i>No bio yet.</i></p>
                <?php endif; ?>

                <a href="edit_profile.php" class="btn btn-outline-primary btn-sm mt-2">Edit Profile</a>
            </div>

        </div>

        <a href="create_tournament.php" class="btn btn-primary mt-4 mb-2">+ Create Tournament</a>

        <div class="section-title">Your Tournaments</div>
        <?php if (empty($myTournaments)): ?>
            <p>You haven’t created any tournaments yet.</p>
        <?php else: ?>
            <ul class="list-group mb-4">
                <?php foreach ($myTournaments as $t): ?>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        <span><strong><?= htmlspecialchars($t['title']) ?></strong> (<?= $t['tourneystatus'] ?>)</span>
                        <div>
                            <a href="edit_tournament.php?id=<?= $t['tournament_id'] ?>" class="btn btn-warning btn-sm">Edit</a>
                            <a href="end_tournament.php?id=<?= $t['tournament_id'] ?>" class="btn btn-danger btn-sm">End</a>
                            <a href="delete_tournament.php?id=<?= $t['tournament_id'] ?>" 
                            class="btn btn-danger btn-sm"
                            onclick="return confirm('Are you sure you want to permanently delete this tournament?');">
                                Delete
                            </a>
                        </div>
                    </li>
                <?php endforeach; ?>
            </ul>
        <?php endif; ?>
    </div> <!-- END PROFILE CARD -->


    <!-- PARTICIPATION SECTION -->
    <div class="profile-container">
        <div class="section-title">Tournament Voting History</div>

        <?php if (empty($myVotes)): ?>
            <p class="text-muted">You haven't voted in any matchups yet.</p>

        <?php else: ?>

            <?php 
            $tournaments = [];
            foreach ($myVotes as $v) {
                $tournaments[$v['tournament_id']][] = $v;
            }
            ?>

            <div class="mb-3">
                <input 
                    id="participationSearch" 
                    type="text" 
                    class="form-control" 
                    placeholder="Search tournaments, rounds, or matchups..."
                >
            </div>

            <div id="participationContainer">
                <div class="accordion" id="tournamentAccordion">

                    <?php foreach ($tournaments as $tid => $votes): ?>

                        <?php 
                        $rounds = [];
                        foreach ($votes as $v) {
                            $rounds[$v['round_number']][] = $v;
                        }
                        ?>

                        <div class="accordion-item mb-2 shadow-sm">
                            <h2 class="accordion-header" id="headingT<?= $tid ?>">
                                <button class="accordion-button collapsed" 
                                        type="button" 
                                        data-bs-toggle="collapse" 
                                        data-bs-target="#collapseT<?= $tid ?>">
                                    🏆 <?= htmlspecialchars($votes[0]['tournament_title']); ?>
                                </button>
                            </h2>

                            <div id="collapseT<?= $tid ?>" 
                                class="accordion-collapse collapse" 
                                data-bs-parent="#tournamentAccordion">
                                
                                <div class="accordion-body">

                                    <div class="accordion" id="roundAccordion<?= $tid ?>">

                                        <?php foreach ($rounds as $roundNum => $roundVotes): ?>
                                            <div class="accordion-item mb-2">
                                                <h2 class="accordion-header" id="headingR<?= $tid . "_" . $roundNum ?>">
                                                    <button class="accordion-button collapsed"
                                                            type="button"
                                                            data-bs-toggle="collapse"
                                                            data-bs-target="#collapseR<?= $tid . "_" . $roundNum ?>">
                                                        🔁 Round <?= $roundNum ?>
                                                    </button>
                                                </h2>

                                                <div id="collapseR<?= $tid . "_" . $roundNum ?>" 
                                                    class="accordion-collapse collapse"
                                                    data-bs-parent="#roundAccordion<?= $tid ?>">
                                                    
                                                    <div class="accordion-body">

                                                        <?php foreach ($roundVotes as $v): ?>
                                                            <div class="border rounded p-2 mb-2">
                                                                <strong>
                                                                    <?= htmlspecialchars($v['entryA_name']) ?>
                                                                    <span class="text-muted">vs</span>
                                                                    <?= htmlspecialchars($v['entryB_name']) ?>
                                                                </strong>
                                                                <br>

                                                                <span class="text-success fw-bold">
                                                                    ✓ You voted for: <?= htmlspecialchars($v['chosen_entry']); ?>
                                                                </span>
                                                                <br>

                                                                <small class="text-muted">
                                                                    Voted at: <?= date("M j, Y g:i A", strtotime($v['cast_at'])); ?>
                                                                </small>
                                                            </div>
                                                        <?php endforeach; ?>

                                                    </div>
                                                </div>
                                            </div>
                                        <?php endforeach; ?>

                                    </div>

                                    <div class="text-center mt-3">
                                        <a href="round8.php?tournament_id=<?= $tid ?>" 
                                        class="btn btn-primary">
                                            View Tournament
                                        </a>
                                    </div>

                                </div>
                            </div>

                        </div>

                    <?php endforeach; ?>

                </div>
            </div>

        <?php endif; ?>
    </div>

</div><!-- end container -->


<script>
document.getElementById("participationSearch").addEventListener("input", function () {
    const query = this.value.toLowerCase();
    const container = document.getElementById("participationContainer");
    const tournaments = container.querySelectorAll(".accordion-item");

    tournaments.forEach(t => {
        const text = t.innerText.toLowerCase();
        t.style.display = text.includes(query) ? "" : "none";
    });
});
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
