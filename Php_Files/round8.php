<?php
require_once("./config.php");
require_once("./navbar.php");
require_once("./index.html");



// Current logged-in user
$currentUserId = $_SESSION["user_id"] ?? null;

// Get tournament ID
$tournamentId = isset($_GET['tournament_id']) ? intval($_GET['tournament_id']) : 0;

if ($tournamentId === 0) {
    die("Error: No tournament selected");
}

// Run updates ONCE per page load (in correct order)
update_matchups_by_time();
update_tournament_statuses();
advance_winners_to_next_round();

$db = get_pdo_connection();

// Get tournament details INCLUDING creator user_id
$tournamentQuery = $db->prepare("
   SELECT t.tournament_id, t.title, t.description, t.tourneystatus, t.user_id,
           u.displayname AS creator_name, 
           u.profile_picture AS creator_pic, 
           u.bio AS creator_bio
    FROM tournament t
    JOIN users u ON t.user_id = u.user_id
    WHERE t.tournament_id = :tournamentId
");
$tournamentQuery->bindParam(':tournamentId', $tournamentId, PDO::PARAM_INT);
$tournamentQuery->execute();
$tournament = $tournamentQuery->fetch(PDO::FETCH_ASSOC);

if (!$tournament) {
    die("Error: Tournament not found");
}

// Tournament creator ID
$tournamentCreatorId = $tournament["user_id"];

// Get all matchups for this tournament, grouped by round
$matchupsQuery = $db->prepare("
    SELECT 
        m.matchup_id,
        m.round_number,
        m.status,
        m.opens_at,
        m.closes_at,
        e1.entry_id AS entryA_id,
        e1.name AS entryA_name,
        e1.description AS entryA_description,
        e1.image_URL AS entryA_image,
        e2.entry_id AS entryB_id,
        e2.name AS entryB_name,
        e2.description AS entryB_description,
        e2.image_URL AS entryB_image,
        (SELECT COUNT(*) FROM vote WHERE matchup_id = m.matchup_id AND entry_id = e1.entry_id) AS votesA,
        (SELECT COUNT(*) FROM vote WHERE matchup_id = m.matchup_id AND entry_id = e2.entry_id) AS votesB
    FROM matchup m
    LEFT JOIN entry e1 ON m.entryA_id = e1.entry_id
    LEFT JOIN entry e2 ON m.entryB_id = e2.entry_id
    WHERE m.tournament_id = :tournamentId
    ORDER BY m.round_number, m.matchup_id
");
$matchupsQuery->bindParam(':tournamentId', $tournamentId, PDO::PARAM_INT);
$matchupsQuery->execute();
$allMatchups = $matchupsQuery->fetchAll(PDO::FETCH_ASSOC);

// Get the current user's votes for this tournament
$userVotesStmt = $db->prepare("
    SELECT 
        v.vote_id,
        v.matchup_id,
        v.entry_id,
        v.cast_at,
        m.round_number,
        e.name AS entry_name
    FROM vote v
    JOIN matchup m ON v.matchup_id = m.matchup_id
    JOIN entry e ON v.entry_id = e.entry_id
    WHERE v.user_id = :uid
      AND m.tournament_id = :tid
    ORDER BY m.round_number, v.cast_at
");
$userVotesStmt->execute([
    ':uid' => $currentUserId,
    ':tid' => $tournamentId
]);
$userVotes = $userVotesStmt->fetchAll(PDO::FETCH_ASSOC);


// Group matchups by round
$matchupsByRound = [];
foreach ($allMatchups as $matchup) {
    $round = $matchup['round_number'];
    if (!isset($matchupsByRound[$round])) {
        $matchupsByRound[$round] = [];
    }
    $matchupsByRound[$round][] = $matchup;
}

// Determine bracket structure
$totalEntries = 0;
if (!empty($matchupsByRound)) {
    $firstRound = min(array_keys($matchupsByRound));
    $totalEntries = count($matchupsByRound[$firstRound]) * 2;
}

// Calculate number of rounds
$maxRound = !empty($matchupsByRound) ? max(array_keys($matchupsByRound)) : 0;

// Round names based on bracket size
function getRoundName($roundNumber, $totalRounds) {
    $roundsFromEnd = $totalRounds - $roundNumber + 1;
    
    switch ($roundsFromEnd) {
        case 1: return "Final";
        case 2: return "Semi-Finals";
        case 3: return "Quarter-Finals";
        case 4: return "Round of 16";
        default: return "Round $roundNumber";
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="./round8.css" rel="stylesheet" type="text/css" />
    <title><?php echo htmlspecialchars($tournament['title']); ?> - Bracket</title>

    <style>
        .tournament-title {
             background: #34495E;
            color: white;
            padding: 50px 20px 35px;
            text-align: center;
            margin-bottom: 25px;
        }
        
        .tournament-title .sub-info {
            max-width: 700px;
            margin: 0 auto 10px;
            font-size: 1.05rem;
        }

        .status-badge {
            display: inline-block;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.9rem;
            margin-left: 10px;
        }
        
        .status-active { background: #4CAF50; }
        .status-upcoming { background: #FF9800; }
        .status-completed { background: #9E9E9E; }
        
        .matchup-box {
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .matchup-box:hover {
            background-color: #e8f5e9 !important;
            transform: translateX(3px);
        }
        
        .entry-name {
            font-weight: bold;
            color: #333;
            font-size: 0.95rem;
        }
        
        .vote-count {
            font-size: 0.85rem;
            color: #666;
            display: block;
            margin-top: 2px;
        }
        
        .vs {
            display: block;
            font-weight: bold;
            color: #999;
            margin: 5px 0;
            font-size: 0.9rem;
        }
        
        .matchup-status {
            font-size: 0.75rem;
            margin-top: 5px;
            display: block;
        }
        
        .entry-card {
            border: 2px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            transition: all 0.3s ease;
        }
        
        .entry-card:hover {
            border-color: #4CAF50;
            box-shadow: 0 4px 12px rgba(76, 175, 80, 0.2);
        }
        
        .entry-image-placeholder {
            width: 100%;
            height: 200px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            font-size: 4rem;
            font-weight: bold;
            border-radius: 8px;
            margin-bottom: 15px;
        }
        
        .vote-button {
            width: 100%;
            padding: 12px;
            font-size: 1.1rem;
            font-weight: bold;
        }

        .tournament-controls {
            display: inline-flex;
            gap: 12px;
            margin-top: 10px;
        }
    </style>
    <script>
// ====== CONTROL AUTO-REFRESH SAFELY ======

let modalOpen = false;

document.addEventListener("shown.bs.modal", () => modalOpen = true);
document.addEventListener("hidden.bs.modal", () => modalOpen = false);

function userIsScrolling() {
    return window.scrollY > 150;
}

// Poll server once every 4 seconds
setInterval(() => {
    if (modalOpen) return;
    if (userIsScrolling()) return;

    fetch("check_round_change.php?tournament_id=<?= $tournamentId ?>")
        .then(res => res.json())
        .then(data => {
            if (data.changed === true) {
                location.reload();
            }
        })
        .catch(console.error);
}, 4000);


// ====== COUNTDOWN TIMER ======
function startCountdown(matchupId, closesAt) {
    const label = document.getElementById("timer-" + matchupId);
    if (!label) return;

    function updateTimer() {
        let diff = new Date(closesAt) - new Date();

        if (diff <= 0) {
            label.innerHTML = "Voting closed";
            return;
        }

        let seconds = Math.floor(diff / 1000);
        label.innerHTML = "Voting ends in: " + seconds + "s";

        requestAnimationFrame(updateTimer);
    }

    updateTimer();
}
</script>


</head>
<body>

<div class="tournament-title">
    <h1 class="display-5 mb-2">
        <?= htmlspecialchars($tournament['title']); ?>
    </h1>


    <div class="d-flex justify-content-center align-items-center mt-3 mb-3">
        <?php 
            $pic = !empty($tournament["creator_pic"]) ? $tournament["creator_pic"] : "uploads/profile_pics/default-avatar.png";
        ?>
        <img src="<?= htmlspecialchars($pic) ?>" 
             alt="Creator" 
             class="rounded-circle me-2" 
             style="width: 40px; height: 40px; object-fit: cover; border: 2px solid rgba(255,255,255,0.8);">
        
        <span style="color: rgba(255,255,255,0.9); font-size: 0.95rem;">
            Created by 
            <strong class="text-white text-decoration-underline" 
                    data-bs-toggle="tooltip" 
                    data-bs-placement="top" 
                    title="Bio: <?= htmlspecialchars($tournament['creator_bio'] ?? 'No bio available.') ?>"
                    style="cursor: help;">
                <?= htmlspecialchars($tournament['creator_name']) ?>
            </strong>
        </span>
    </div>
    <?php if (!empty($tournament['description'])): ?>
        <p class="lead sub-info">
            <?= nl2br(htmlspecialchars($tournament['description'])); ?>
        </p>
    <?php endif; ?>

    <span class="status-badge status-<?= strtolower($tournament['tourneystatus']); ?>">
        <?= htmlspecialchars($tournament['tourneystatus']); ?>
    </span>

    <div class="tournament-controls">
        <a href="tournaments.php" class="btn btn-light btn-sm">← Back to Tournaments</a>
        <a href="statistics.php?tournament_id=<?= $tournamentId; ?>" 
           class="btn btn-outline-light btn-sm">
           View Statistics
        </a>
    </div>
</div>


<?php if (empty($matchupsByRound)): ?>
<div class="container">
    <div class="alert alert-warning" role="alert">
        <h4 class="alert-heading">No Matchups Found!</h4>
        <p>This tournament doesn't have any matchups yet.</p>
        <a href="tournaments.php" class="btn btn-primary mt-2">← Back to Tournaments</a>
    </div>
</div>
<?php else: ?>

<?php if (!empty($userVotes)): ?>
<div class="container mb-4">
    <h3>Your Votes</h3>
    <ul class="list-group">
        <?php foreach ($userVotes as $v): ?>
            <li class="list-group-item">
                <strong>Round <?= $v['round_number'] ?>:</strong>
                You voted for <strong><?= htmlspecialchars($v['entry_name']) ?></strong>
                (Matchup #<?= $v['matchup_id'] ?>)
            </li>
        <?php endforeach; ?>
    </ul>
</div>
<?php endif; ?>


<div class="tournament-container">
    <div class="tournament-headers">
        <?php for ($round = 1; $round <= $maxRound; $round++): ?>
            <h3><?php echo getRoundName($round, $maxRound); ?></h3>
        <?php endfor; ?>
        <h3>Winner</h3>
    </div>

    <div class="tournament-brackets">
        <?php for ($round = 1; $round <= $maxRound; $round++): 
            $roundMatchups = $matchupsByRound[$round] ?? [];
        ?>
            <ul class="bracket bracket-<?php echo $round; ?>">
                <?php foreach ($roundMatchups as $matchup): ?>
                    <li class="team-item matchup-box"
                        data-bs-toggle="modal" 
                        data-bs-target="#matchupModal<?php echo $matchup['matchup_id']; ?>"
                        style="cursor: pointer;">
                        
                        <div class="entry-name">
                            <?= $matchup['entryA_name'] ? htmlspecialchars($matchup['entryA_name']) : "TBD" ?>
                        </div>
                        <span class="vote-count">
                            <?= $matchup['votesA'] ?? 0 ?> votes
                        </span>

                        <span class="vs">VS</span>

                        <div class="entry-name">
                            <?= $matchup['entryB_name'] ? htmlspecialchars($matchup['entryB_name']) : "TBD" ?>
                        </div>
                        <span class="vote-count">
                            <?= $matchup['votesB'] ?? 0 ?> votes
                        </span>


                        <?php if ($matchup['status'] === 'Completed'): ?>
                            <span class="matchup-status" style="color: #4CAF50; font-weight: bold;">
                                ✓ FINISHED
                            </span>
                        <?php elseif ($matchup['status'] === 'Active'): ?>
                            <span class="matchup-status" style="color: #2196F3; font-weight: bold;">
                                🗳️ VOTE NOW
                            </span>
                        <?php else: ?>
                            <span class="matchup-status" style="color: #FF9800;">
                                ⏰ Upcoming
                            </span>
                        <?php endif; ?>
                    </li>
                <?php endforeach; ?>
            </ul>
        <?php endfor; ?>

        <ul class="bracket bracket-winner">
            <li class="team-item">
                <?php
                    $finalRound = $matchupsByRound[$maxRound] ?? [];
                    if (!empty($finalRound) && $finalRound[0]['status'] === 'Completed') {
                        $final = $finalRound[0];
                        $winner = ($final['votesA'] > $final['votesB']) 
                            ? $final['entryA_name'] 
                            : $final['entryB_name'];
                        echo "🏆 " . htmlspecialchars($winner);
                    } else {
                        echo "TBD";
                    }
                ?>
            </li>
        </ul>
    </div>
</div>
<?php endif; ?>

<?php foreach ($allMatchups as $matchup): ?>
<div class="modal fade" id="matchupModal<?php echo $matchup['matchup_id']; ?>" 
     tabindex="-1" 
     aria-labelledby="matchupModalLabel<?php echo $matchup['matchup_id']; ?>" 
     aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="matchupModalLabel<?php echo $matchup['matchup_id']; ?>">
                    <?= getRoundName($matchup['round_number'], $maxRound); ?> - Matchup #<?php echo $matchup['matchup_id']; ?>
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <div class="modal-body">
                <div class="row g-4">
                    <p id="timer-<?php echo $matchup['matchup_id']; ?>" 
                    class="text-center text-primary fw-bold mb-3"></p>

                    <script>
                    <?php if ($matchup['status'] === 'Active'): ?>
                    startCountdown(<?php echo $matchup['matchup_id']; ?>, "<?php echo $matchup['closes_at']; ?>");
                    <?php endif; ?>
                    </script>

                    <div class="col-md-5">
                        <div class="entry-card">
                            <?php if ($matchup['entryA_image'] && $matchup['entryA_id']): ?>
                                <img src="<?php echo htmlspecialchars($matchup['entryA_image']); ?>" 
                                     class="img-fluid rounded mb-3" 
                                     alt="<?php echo htmlspecialchars($matchup['entryA_name']); ?>"
                                     style="width: 100%; height: 200px; object-fit: contain;">
                            <?php else: ?>
                                <div class="entry-image-placeholder">
                                    <?= $matchup['entryA_id'] ? strtoupper(substr($matchup['entryA_name'], 0, 1)) : "?" ?>
                                </div>
                            <?php endif; ?>
                            
                            <h3 class="text-center mb-3">
                                <?= $matchup['entryA_name'] ? htmlspecialchars($matchup['entryA_name']) : "TBD" ?>
                            </h3>
                            
                            <p class="text-muted">
                                <?= $matchup['entryA_id'] 
                                    ? htmlspecialchars($matchup['entryA_description'] ?? 'No description available')
                                    : "TBD" ?>
                            </p>
                            
                            <div class="text-center my-3">
                                <h2 class="text-primary">
                                    <?= $matchup['votesA'] ?? 0 ?>
                                    <small class="text-muted">votes</small>
                                </h2>
                            </div>
                            
                            <?php if ($matchup['status'] === 'Active' && $matchup['entryA_id']): ?>
                               <form method="POST" action="cast_vote.php">
    <input type="hidden" name="matchup_id" value="<?= $matchup['matchup_id'] ?>">
    <input type="hidden" name="entry_id" value="<?= $matchup['entryA_id'] ?>">
    <button type="submit" class="btn btn-success vote-button">
        ✓ Vote for <?= htmlspecialchars($matchup['entryA_name']) ?>
    </button>
</form>

                            <?php else: ?>
                                <button class="btn btn-secondary vote-button" disabled>
                                    Voting Closed
                                </button>
                            <?php endif; ?>
                        </div>
                    </div>

                    <div class="col-md-2 d-flex align-items-center justify-content-center">
                        <div class="text-center">
                            <h1 class="display-3 text-muted">VS</h1>
                        </div>
                    </div>

                    <div class="col-md-5">
                        <div class="entry-card">
                            <?php if ($matchup['entryB_image'] && $matchup['entryB_id']): ?>
                                <img src="<?php echo htmlspecialchars($matchup['entryB_image']); ?>" 
                                     class="img-fluid rounded mb-3" 
                                     alt="<?php echo htmlspecialchars($matchup['entryB_name']); ?>"
                                     style="width: 100%; height: 200px; object-fit: contain;">
                            <?php else: ?>
                                <div class="entry-image-placeholder">
                                    <?= $matchup['entryB_id'] ? strtoupper(substr($matchup['entryB_name'], 0, 1)) : "?" ?>
                                </div>
                            <?php endif; ?>
                            
                            <h3 class="text-center mb-3">
                                <?= $matchup['entryB_name'] ? htmlspecialchars($matchup['entryB_name']) : "TBD" ?>
                            </h3>
                            
                            <p class="text-muted">
                                <?= $matchup['entryB_id'] 
                                    ? htmlspecialchars($matchup['entryB_description'] ?? 'No description available')
                                    : "TBD" ?>
                            </p>
                            
                            <div class="text-center my-3">
                                <h2 class="text-primary">
                                    <?= $matchup['votesB'] ?? 0 ?>
                                    <small class="text-muted">votes</small>
                                </h2>
                            </div>
                            
                            <?php if ($matchup['status'] === 'Active' && $matchup['entryB_id']): ?>
                                <form method="POST" action="cast_vote.php">
    <input type="hidden" name="matchup_id" value="<?= $matchup['matchup_id'] ?>">
    <input type="hidden" name="entry_id" value="<?= $matchup['entryB_id'] ?>">
    <button type="submit" class="btn btn-success vote-button">
        ✓ Vote for <?= htmlspecialchars($matchup['entryB_name']) ?>
    </button>
</form>

                            <?php else: ?>
                                <button class="btn btn-secondary vote-button" disabled>
                                    Voting Closed
                                </button>
                            <?php endif; ?>
                        </div>
                    </div>
                </div>

                <div class="mt-4 p-3 bg-light rounded">
                    <div class="row">
                        <div class="col-md-4">
                            <strong>Status:</strong>
                            <span class="badge bg-<?php 
                                echo $matchup['status'] === 'Active' ? 'success' : 
                                    ($matchup['status'] === 'Completed' ? 'secondary' : 'warning'); 
                            ?>">
                                <?php echo $matchup['status']; ?>
                            </span>
                        </div>
                        <div class="col-md-4">
                            <strong>Opens:</strong> 
                            <?php echo date('M j, Y g:i A', strtotime($matchup['opens_at'])); ?>
                        </div>
                        <div class="col-md-4">
                            <strong>Closes:</strong> 
                            <?php echo date('M j, Y g:i A', strtotime($matchup['closes_at'])); ?>
                        </div>
                        <div class="col-md-12 mt-3 text-center">
                            <?php if ($matchup['status'] === 'Active'): ?>
                                <span id="timer-<?php echo $matchup['matchup_id']; ?>" 
                                    class="badge bg-primary p-2"
                                    data-closes="<?php echo strtotime($matchup['closes_at']); ?>">
                                    ⏳ Voting ends in: calculating…
                                </span>
                            <?php endif; ?>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<?php endforeach; ?>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
<script>
// Auto-update countdown timers & refresh on expiration
function updateCountdownTimers() {
    const now = Math.floor(Date.now() / 1000);

    document.querySelectorAll("[id^='timer-']").forEach(el => {
        const closesAt = parseInt(el.getAttribute("data-closes"), 10);
        const remaining = closesAt - now;

        if (remaining <= 0) {
            el.textContent = "Voting ended — updating…";
            // Refresh to load new winners/rounds
           setTimeout(() => { location.reload(); }, 1500);
            return;
        }

        const hrs = Math.floor(remaining / 3600);
        const mins = Math.floor((remaining % 3600) / 60);
        const secs = remaining % 60;

        el.textContent = `⏳ Voting ends in: ${
            (hrs > 0 ? hrs + "h " : "") +
            (mins > 0 ? mins + "m " : "") +
            secs + "s"
        }`;
    });
}

// Update timers every second
setInterval(updateCountdownTimers, 1000);

// Initial call
updateCountdownTimers();

const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
    const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
