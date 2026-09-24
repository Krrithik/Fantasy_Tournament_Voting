<?php
require_once("./auth.php");
// Deny guest sessions from accessing statistics
ensure_logged_in();

require_once("./config.php");
require_once("./navbar.php");
require_once("./index.html");

$db = get_pdo_connection();

// Prefer explicit ?tournament_id=... otherwise use session
if (isset($_GET['tournament_id'])) {
    $tournamentId = (int)$_GET['tournament_id'];
} elseif (isset($_SESSION['current_tournament_id'])) {
    $tournamentId = (int)$_SESSION['current_tournament_id'];
} else {
    $tournamentId = 0;
}

$errorMessage   = null;
$tournamentInfo = null;
$participation  = [];
$topEntries     = [];
$roundStats     = [];
$entriesList    = [];

if ($tournamentId === 0) {
    $errorMessage = "No tournament selected. Go to Tournaments, pick one, then click Statistics.";

} else {
    try {
        // Call stored procedure
        $query = $db->prepare("CALL get_tournament_stats(:tid)");
        $query->bindParam(":tid", $tournamentId, PDO::PARAM_INT);
        $query->execute();

        // RESULT SET 1: OVERVIEW
        $overview = $query->fetchAll(PDO::FETCH_ASSOC);

        if (count($overview) === 1 && isset($overview[0]['message'])) {
            $errorMessage = $overview[0]['message'];
        } else {
            $tournamentInfo = $overview[0] ?? null;

            // --- TIME NORMALIZATION & DURATION FIX (PHP-side) ---
            if ($tournamentInfo) {
                $startRaw = $tournamentInfo['start_at'] ?? null;
                $endRaw   = $tournamentInfo['end_at'] ?? null;

                $startDt = null;
                $endDt   = null;

                if (!empty($startRaw)) {
                    try {
                        $startDt = new DateTime($startRaw);
                        // Format nicely for display
                        $tournamentInfo['start_at'] = $startDt->format('Y-m-d H:i');
                    } catch (Exception $e) {
                        // leave as-is if it can't be parsed
                    }
                }

                if (!empty($endRaw)) {
                    try {
                        $endDt = new DateTime($endRaw);
                        $tournamentInfo['end_at'] = $endDt->format('Y-m-d H:i');
                    } catch (Exception $e) {
                        // leave as-is if it can't be parsed
                    }
                }

                // Recompute duration_days in PHP if both dates are good
                if ($startDt && $endDt) {
                    $diff = $startDt->diff($endDt);
                    $tournamentInfo['duration_days'] = $diff->days;
                }
            }

            // RESULT SET 2: PARTICIPATION
            $query->nextRowset();
            $participation = $query->fetch(PDO::FETCH_ASSOC) ?: [];

            // RESULT SET 3: TOP ENTRIES (ignored; we recompute below)
            $query->nextRowset();
            $discardTopEntries = $query->fetchAll(PDO::FETCH_ASSOC);

            // RESULT SET 4: VOTE DISTRIBUTION
            $query->nextRowset();
            $roundStats = $query->fetchAll(PDO::FETCH_ASSOC);
        }

        $query->closeCursor();

        // If we have a valid tournament, recompute sensitive stats directly
        if ($tournamentId !== 0 && $tournamentInfo) {

            // Recompute total votes and average votes per matchup from $roundStats
            if (!empty($roundStats)) {
                $totalVotes = 0;
                foreach ($roundStats as $round) {
                    $totalVotes += (int)($round['votes_in_round'] ?? 0);
                }
                $participation['total_votes'] = $totalVotes;

                $totalMatchups = isset($participation['total_matchups'])
                    ? (int)$participation['total_matchups']
                    : 0;

                if ($totalMatchups > 0) {
                    $participation['avg_votes_per_matchup'] = round(
                        $totalVotes / $totalMatchups,
                        2
                    );
                } else {
                    $participation['avg_votes_per_matchup'] = 0;
                }
            }

            // Recompute Top 5 Most Popular Entries without overcounting.
            // We ensure matchups are from THIS tournament via m.tournament_id = :tid.
            $topStmt = $db->prepare("
                SELECT 
                    e.entry_id,
                    e.name AS entry_name,
                    e.seed,
                    -- If you want unique voters per entry, use COUNT(DISTINCT v.user_id)
                    COUNT(v.user_id) AS total_votes_received,
                    COUNT(DISTINCT m.matchup_id) AS matchups_participated
                FROM entry e
                LEFT JOIN matchup m
                    ON (e.entry_id = m.entryA_id OR e.entry_id = m.entryB_id)
                   AND m.tournament_id = :tid
                LEFT JOIN vote v
                    ON v.matchup_id = m.matchup_id
                   AND v.entry_id = e.entry_id
                WHERE e.tournament_id = :tid
                GROUP BY e.entry_id, e.name, e.seed
                ORDER BY total_votes_received DESC, e.seed ASC
                LIMIT 5
            ");
            $topStmt->bindParam(':tid', $tournamentId, PDO::PARAM_INT);
            $topStmt->execute();
            $topEntries = $topStmt->fetchAll(PDO::FETCH_ASSOC) ?: [];

            // All entries in this tournament (for list with thumbnails)
            $entriesStmt = $db->prepare("
                SELECT entry_id, entry_name, image_url
                FROM view_tournament_entries
                WHERE tournament_id = :tid
                ORDER BY entry_name
            ");
            $entriesStmt->bindParam(':tid', $tournamentId, PDO::PARAM_INT);
            $entriesStmt->execute();
            $entriesList = $entriesStmt->fetchAll(PDO::FETCH_ASSOC);
        }

    } catch (PDOException $e) {
        $errorMessage = "Database error: " . htmlspecialchars($e->getMessage());
    }
}

$tournamentTitle = $tournamentInfo['title'] ?? 'Tournament Statistics';
$tournamentDesc  = $tournamentInfo['description'] ?? '';
$tourneyStatus   = $tournamentInfo['tourneystatus'] ?? null;
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= htmlspecialchars($tournamentTitle) ?> - Statistics</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        .stats-header {
            background: #34495E;
            color: white;
            padding: 40px 20px 30px; /* smaller, cleaner */
            text-align: center;
            margin-bottom: 25px;
        }
        .stats-header h1 {
            margin-bottom: 6px;
        }
        .stats-header .sub-info {
            margin-top: -4px;
            margin-bottom: 12px;
        }

        .stats-controls {
            display: inline-flex;
            align-items: center;
            gap: 12px;
            margin-top: 12px;
        }

        .status-badge {
            display: inline-block;
            padding: 4px 14px;
            border-radius: 999px;
            font-size: 0.8rem;
            font-weight: 600;
        }
        .status-active { background-color: #4CAF50; }
        .status-upcoming { background-color: #FF9800; }
        .status-completed { background-color: #9E9E9E; }

        .stats-card {
            border-radius: 12px;
            box-shadow: 0 4px 18px rgba(0, 0, 0, 0.05);
        }
        .stats-card .card-header {
            font-weight: 600;
            background-color: #f8f9fa;
        }

        .section-icon {
            margin-right: 6px;
        }

        @media (min-width: 992px) {
            .container-narrow {
                max-width: 960px;
            }
        }
    </style>
</head>
<body>

<div class="stats-header">
    <h1 class="display-5">Statistics</h1>

    <?php if (!$errorMessage): ?>
        <h2 class="h4 mt-3 mb-1"><?= htmlspecialchars($tournamentTitle) ?></h2>

        <?php if (!empty($tournamentDesc)): ?>
            <p class="sub-info"><?= nl2br(htmlspecialchars($tournamentDesc)) ?></p>
        <?php endif; ?>

        <div class="stats-controls">
            <?php if ($tourneyStatus): ?>
                <?php $statusClass = 'status-' . strtolower($tourneyStatus); ?>
                <span class="status-badge <?= htmlspecialchars($statusClass) ?>">
                    <?= htmlspecialchars($tourneyStatus) ?>
                </span>
            <?php endif; ?>

            <a href="tournaments.php" class="btn btn-light btn-sm">← Back to Tournaments</a>

            <a href="round8.php?tournament_id=<?= (int)$tournamentId ?>" 
               class="btn btn-outline-light btn-sm">
               View Bracket
            </a>
        </div>
    <?php endif; ?>
</div>

<div class="container container-narrow mb-5">

    <?php if ($errorMessage): ?>

        <div class="alert alert-danger">
            <?= htmlspecialchars($errorMessage) ?>
        </div>

    <?php else: ?>
<button onclick="window.print()" class="btn btn-secondary btn-sm ">
    🖨️ Save as PDF
</button>
        <!-- ================== OVERVIEW ================== -->
        <div class="card stats-card mb-4">
            <div class="card-header">
                <span class="section-icon">📋</span> Tournament Overview
            </div>
            <div class="card-body">
                <p><strong>Status:</strong> <?= htmlspecialchars($tourneyStatus) ?></p>

                <div class="row">
                    <div class="col-md-6 mb-2">
                        <p><strong>Start:</strong><br><?= htmlspecialchars($tournamentInfo['start_at'] ?? 'N/A'); ?></p>
                        <p><strong>End:</strong><br><?= htmlspecialchars($tournamentInfo['end_at'] ?? 'N/A'); ?></p>
                    </div>
                    <div class="col-md-6 mb-2">
                        <p><strong>Duration (days):</strong><br><?= htmlspecialchars($tournamentInfo['duration_days'] ?? 'N/A'); ?></p>
                        <p><strong>Created by:</strong><br><?= htmlspecialchars($tournamentInfo['created_by_admin'] ?? 'Unknown'); ?></p>
                    </div>
                </div>
            </div>
        </div>

        <!-- ================== PARTICIPATION ================== -->
         <div class="card stats-card mb-4">
            <div class="card-header">
                <span class="section-icon">👥</span> Participation Statistics
            </div>
            <div class="card-body">
                <?php if (!empty($participation)): ?>
                    <div class="row text-center text-md-start">
                        <div class="col-md-4 mb-3">
                            <p><strong>Total entries:</strong><br><?= htmlspecialchars($participation['total_entries'] ?? 0); ?></p>
                            <p><strong>Total matchups:</strong><br><?= htmlspecialchars($participation['total_matchups'] ?? 0); ?></p>
                            <p><strong>Completed matchups:</strong><br><?= htmlspecialchars($participation['completed_matchups'] ?? 0); ?></p>
                        </div>
                        <div class="col-md-4 mb-3">
                            <p><strong>Active matchups:</strong><br><?= htmlspecialchars($participation['active_matchups'] ?? 0); ?></p>
                            <p><strong>Upcoming matchups:</strong><br><?= htmlspecialchars($participation['upcoming_matchups'] ?? 0); ?></p>
                            <p><strong>Max round reached:</strong><br><?= htmlspecialchars($participation['max_round_reached'] ?? 0); ?></p>
                        </div>
                        <div class="col-md-4 mb-3">
                            <p><strong>Unique voters:</strong><br><?= htmlspecialchars($participation['unique_voters'] ?? 0); ?></p>
                            <p><strong>Total votes:</strong><br><?= htmlspecialchars($participation['total_votes'] ?? 0); ?></p>
                            <p><strong>Avg votes per matchup:</strong><br><?= htmlspecialchars($participation['avg_votes_per_matchup'] ?? 0); ?></p>
                        </div>
                    </div>
                <?php else: ?>
                    <p class="text-muted mb-0">No participation data available.</p>
                <?php endif; ?>
            </div>
        </div>

        <!-- ================== TOP 5 ENTRIES ================== -->
        <div class="card stats-card mb-4">
            <div class="card-header">
                <span class="section-icon">🏆</span> Top 5 Most Popular Entries
            </div>
            <div class="card-body">
                <?php if (!empty($topEntries)): ?>
                    <div class="table-responsive">
                        <table class="table table-striped align-middle mb-0">
                            <thead>
                                <tr>
                                    <th>Entry ID</th>
                                    <th>Name</th>
                                    <th>Seed</th>
                                    <th>Total Votes</th>
                                    <th>Matchups Participated</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($topEntries as $entry): ?>
                                    <tr>
                                        <td><?= htmlspecialchars($entry['entry_id']); ?></td>
                                        <td><?= htmlspecialchars($entry['entry_name']); ?></td>
                                        <td><?= htmlspecialchars($entry['seed']); ?></td>
                                        <td><?= htmlspecialchars($entry['total_votes_received']); ?></td>
                                        <td><?= htmlspecialchars($entry['matchups_participated']); ?></td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                <?php else: ?>
                    <p class="text-muted mb-0">No entries found for this tournament.</p>
                <?php endif; ?>
            </div>
        </div>

        <!-- ================== ALL ENTRIES IN THIS TOURNAMENT ================== -->
        <div class="card stats-card mb-4">
            <div class="card-header">
                <span class="section-icon">📜</span> Entries in this Tournament
            </div>
            <div class="card-body">
                <?php if (!empty($entriesList)): ?>
                    <div class="row row-cols-1 row-cols-md-2 g-3">
                        <?php foreach ($entriesList as $entry): ?>
                            <div class="col">
                                <div class="border rounded p-3 h-100 d-flex align-items-center">
                                    <div class="flex-grow-1">
                                        <strong>
                                            <?= htmlspecialchars($entry['entry_name']) ?>
                                        </strong>
                                        <div class="text-muted small">
                                            Entry ID: <?= (int)$entry['entry_id'] ?>
                                        </div>
                                    </div>

                                    <?php if (!empty($entry['image_url'])): ?>
                                        <div class="ms-3">
                                            <img src="<?= htmlspecialchars($entry['image_url']) ?>"
                                                 alt="<?= htmlspecialchars($entry['entry_name']) ?>"
                                                 style="width:60px; height:60px; object-fit:contain; border-radius:6px;">
                                        </div>
                                    <?php endif; ?>
                                </div>
                            </div>
                        <?php endforeach; ?>
                    </div>
                <?php else: ?>
                    <p class="text-muted mb-0">
                        No entries found for this tournament.
                    </p>
                <?php endif; ?>
            </div>
        </div>

        <!-- ================== VOTE DISTRIBUTION ================== -->
        <div class="card stats-card mb-4">
            <div class="card-header">
                <span class="section-icon">📊</span> Vote Distribution by Round
            </div>
            <div class="card-body">
                <?php if (!empty($roundStats)): ?>
                    <div class="table-responsive">
                        <table class="table table-bordered align-middle mb-0">
                            <thead>
                                <tr>
                                    <th>Round</th>
                                    <th>Matchups in Round</th>
                                    <th>Total Votes</th>
                                    <th>Avg Votes per Matchup</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($roundStats as $round): ?>
                                    <tr>
                                        <td><?= htmlspecialchars($round['round_number']); ?></td>
                                        <td><?= htmlspecialchars($round['matchups_in_round']); ?></td>
                                        <td><?= htmlspecialchars($round['votes_in_round']); ?></td>
                                        <td><?= htmlspecialchars($round['avg_votes_per_matchup']); ?></td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                <?php else: ?>
                    <p class="text-muted mb-0">No vote data by round yet.</p>
                <?php endif; ?>
            </div>
        </div>

    <?php endif; ?>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
