<?php
require_once("./config.php");
require_once("./navbar.php");
require_once("./index.html");

// Detect login state
$isLoggedIn  = isset($_SESSION["user_id"]) && $_SESSION["user_id"] !== "guest";
$isGuest     = isset($_SESSION["role"]) && $_SESSION["role"] === "guest";
$displayName = $_SESSION["displayname"] ?? null;

// Do we have a "current" tournament remembered?
$hasCurrentTournament = isset($_SESSION['current_tournament_id']) 
    && ctype_digit((string)$_SESSION['current_tournament_id']);
$currentTournamentId = $hasCurrentTournament ? (int)$_SESSION['current_tournament_id'] : null;

// === Load tournaments for the statistics card (defensive, so no fatal errors) ===
$displayTournaments = [];

if (function_exists('get_pdo_connection')) {
    try {
        $db = get_pdo_connection();

        $stmt = $db->prepare("
            SELECT tournament_id, title, tourneystatus, start_at, end_at
            FROM tournament
            ORDER BY start_at DESC, tournament_id DESC
        ");
        $stmt->execute();
        $tournaments = $stmt->fetchAll(PDO::FETCH_ASSOC);

        // Always base on real current date here
        $currentDate = date('Y-m-d');

        if (!empty($tournaments)) {
            $upcoming  = [];
            $active    = [];
            $completed = [];

            foreach ($tournaments as $t) {
                $start = $t["start_at"] ?? null;
                $end   = $t["end_at"]   ?? null;

                // Normalize to dates (in case of DATETIME)
                $startDate = $start ? substr($start, 0, 10) : null;
                $endDate   = $end   ? substr($end, 0, 10)   : null;

                // 1) Prefer DB status if valid
                $statusRaw = strtolower(trim($t['tourneystatus'] ?? ''));
                $status = null;

                if (in_array($statusRaw, ['upcoming', 'active', 'completed'], true)) {
                    // Normalize capitalization
                    $status = ucfirst($statusRaw);
                } else {
                    // 2) Fallback: derive from dates if DB status is unknown
                    if ($endDate !== null && $endDate <= $currentDate) {
                        $status = "Completed";
                    } elseif ($startDate !== null && $startDate > $currentDate) {
                        $status = "Upcoming";
                    } else {
                        // Started or no dates -> treat as Active
                        $status = "Active";
                    }
                }

                $t['tourneystatus'] = $status;

                // 3) Put into correct bucket
                if ($status === "Upcoming") {
                    $upcoming[] = $t;
                } elseif ($status === "Active") {
                    $active[] = $t;
                } elseif ($status === "Completed") {
                    $completed[] = $t;
                }
            }

            // Sort each group by newest start time (DESC)
            $sortByStartDesc = function (&$arr) {
                usort($arr, function ($a, $b) {
                    $aStart = isset($a['start_at']) ? $a['start_at'] : '';
                    $bStart = isset($b['start_at']) ? $b['start_at'] : '';
                    return strcmp($bStart, $aStart); // DESC by start_at
                });
            };
            $sortByStartDesc($upcoming);
            $sortByStartDesc($active);
            $sortByStartDesc($completed);

            // Build display list: up to 6 upcoming, 6 active, then completed to 12 total
            $displayTournaments = array_slice($upcoming, 0, 6);
            $displayTournaments = array_merge(
                $displayTournaments,
                array_slice($active, 0, 6)
            );

            $max = 12;
            if (count($displayTournaments) < $max) {
                $remaining = $max - count($displayTournaments);
                $displayTournaments = array_merge(
                    $displayTournaments,
                    array_slice($completed, 0, $remaining)
                );
            }
        }

    } catch (Throwable $e) {
        // If anything goes wrong, just show no tournaments instead of erroring
        $displayTournaments = [];
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Welcome - Fantasy Tourney</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" 
          rel="stylesheet" />

    <style>
        /* Welcome header */
        .welcome-header {
            background: #34495E;
            color: white;
            padding: 80px 20px;
            text-align: center;
            margin-bottom: 40px;
        }

        .feature-card {
            transition: transform .15s ease, box-shadow .15s ease;
        }
        .feature-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 24px rgba(0,0,0,0.08);
        }

        /* Equal-height cards & small buttons */
        .feature-card .card-body {
            padding: 16px 18px;
            display: flex;
            flex-direction: column;
        }

        .feature-card .card-text {
            flex-grow: 1;
            margin-bottom: 12px;
        }

        .feature-card .card-body .btn {
            align-self: flex-start;    /* don’t stretch across the card */
            margin-top: auto;
            padding: 6px 14px;         /* smaller width visually */
            font-size: 0.9rem;
            border-radius: 6px;
        }

        /* Stats list styles */
        .tournament-list {
            max-height: 260px;
            overflow-y: auto;
            margin-top: 10px;
        }

        .tournament-link {
            display: block;
            padding: 6px 8px;
            border-radius: 8px;
            border-bottom: 1px solid #f1f1f1;
            color: inherit;
            text-decoration: none;
            transition: background-color .12s ease, transform .12s ease, box-shadow .12s ease;
        }
        .tournament-link:hover {
            background: #f8f9fa;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        }

        .tournament-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.95rem;
        }
        .tournament-title {
            font-weight: 500;
            font-size: 0.97rem;
        }

        .status-pill {
            border-radius: 999px;
            padding: 2px 10px;
            font-size: 0.78rem;
            font-weight: 600;
            color: #fff;
        }
        .status-pill-upcoming { background-color: #FF9800; }
        .status-pill-active   { background-color: #4CAF50; }
        .status-pill-completed{ background-color: #9E9E9E; }

        .recent-stats-title {
            font-size: 1.3rem;
        }
        .recent-stats-text {
            font-size: 0.98rem;
        }

        @media (max-width: 767px) {
            .tournament-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 4px;
            }
        }
    </style>
</head>

<body>

<div class="welcome-header">
    <h1 class="display-4 mb-3">Welcome to Fantasy Tourney</h1>
    <p class="lead">Create tournaments, vote in matchups, track statistics, and crown champions!</p>

    <?php if (!$isLoggedIn && !$isGuest): ?>
        <div class="mt-4">
            <a href="login.php" class="btn btn-light btn-lg me-2">Login</a>
            <a href="register.php" class="btn btn-outline-light btn-lg">Register</a>
        </div>

    <?php elseif ($isGuest): ?>
        <p class="mt-3 fs-4 fw-semibold">You’re browsing as a Guest.</p>
        <a href="logout.php" class="btn btn-outline-light btn-lg">Exit Guest Mode</a>

    <?php else: ?>
        <p class="mt-3 fs-3 fw-semibold">
            Hello, <span class="fw-bold"><?= htmlspecialchars($displayName) ?></span> 👋
        </p>
        <a href="profile.php" class="btn btn-outline-light btn-lg">Your Profile</a>
    <?php endif; ?>
</div>

<div class="container mb-5">

    <!-- ABOUT -->
    <div class="mb-5">
        <h2>About the Platform</h2>
        <p class="text-muted">
            Fantasy Tourney lets you build single-elimination brackets, upload entry images,
            run timed matchups, vote live, and explore tournament statistics.
        </p>
    </div>

    <!-- FIRST ROW -->
    <div class="row g-4 mb-3">
        <div class="col-md-6">
            <div class="card feature-card h-100 shadow-sm">
                <div class="card-body">
                    <h4 class="card-title">🏆 Create Tournaments</h4>
                    <p class="card-text">
                        Build a 16-entry tournament with custom names, descriptions, and optional
                        images. We automatically seed entries, create matchups, and set up upcoming
                        rounds for you.
                    </p>

                    <?php if (!$isLoggedIn): ?>
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#guestPromptModal">
                            Create Tournament
                        </button>
                    <?php else: ?>
                        <a href="create_tournament.php" class="btn btn-primary">Create Tournament</a>
                    <?php endif; ?>

                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card feature-card h-100 shadow-sm">
                <div class="card-body">
                    <h4 class="card-title">📋 Browse Tournaments</h4>
                    <p class="card-text">
                        Explore all public tournaments in one place. Use search and status filters
                        to quickly find brackets, then jump straight into active rounds to vote or
                        revisit completed events.
                    </p>
                    <a href="tournaments.php" class="btn btn-success">Browse Tournaments</a>
                </div>
            </div>
        </div>
    </div>

    <!-- SECOND ROW: RECENT STATS -->
    <div class="row g-4">
        <div class="col-12">
            <div class="card feature-card shadow-sm">
                <div class="card-body">
                    <h4 class="card-title recent-stats-title">📊 Recent Tournament Statistics</h4>
                    <p class="card-text recent-stats-text">
                        Quick access to the most recent upcoming and active tournaments.  
                        Click a tournament to view detailed stats.
                    </p>

                    <?php if (empty($displayTournaments)): ?>
                        <p class="text-muted mb-0">No tournaments available yet.</p>
                    <?php else: ?>

                        <?php if ($hasCurrentTournament): ?>
                            <?php
                                $currentTitle = null;
                                foreach ($displayTournaments as $t) {
                                    if ((int)$t['tournament_id'] === $currentTournamentId) {
                                        $currentTitle = $t['title'];
                                        break;
                                    }
                                }
                            ?>
                            <?php if ($currentTitle): ?>
                                <p class="small text-muted mb-1">
                                    Current tournament:
                                    <strong><?= htmlspecialchars($currentTitle) ?></strong>
                                </p>
                            <?php endif; ?>
                        <?php endif; ?>

                        <div class="tournament-list">
                            <?php foreach ($displayTournaments as $t): ?>
                                <?php
                                    $id     = (int)$t['tournament_id'];
                                    $title  = htmlspecialchars($t['title']);
                                    $status = $t['tourneystatus'];
                                    $pillClass = 'status-pill-' . strtolower($status);
                                    $isCurrent = $hasCurrentTournament && $currentTournamentId === $id;
                                ?>
                                <a href="statistics.php?tournament_id=<?= $id ?>" class="tournament-link">
                                    <div class="tournament-item">
                                        <div>
                                            <span class="tournament-title<?= $isCurrent ? ' text-primary' : '' ?>">
                                                <?= $title ?>
                                            </span>
                                            <?php if ($isCurrent): ?>
                                                <span class="badge bg-primary ms-1">Current</span>
                                            <?php endif; ?>
                                        </div>

                                        <span class="status-pill <?= $pillClass ?>">
                                            <?= htmlspecialchars($status) ?>
                                        </span>
                                    </div>
                                </a>
                            <?php endforeach; ?>
                        </div>

                    <?php endif; ?>

                </div>
            </div>
        </div>
    </div>

</div>

<!-- Guest Prompt Modal -->
<div class="modal fade" id="guestPromptModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <div class="modal-header">
        <h5 class="modal-title">Create an Account</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <div class="modal-body">
        <p class="mb-2">Guests can browse tournaments, but must log in to create one.</p>
      </div>

      <div class="modal-footer">
        <a href="register.php" class="btn btn-primary">Register</a>
        <a href="login.php" class="btn btn-outline-secondary">Login</a>
      </div>

    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>