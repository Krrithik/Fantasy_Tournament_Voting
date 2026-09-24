<?php
require_once("./config.php");
require_once("./index.html");

// Read search term from query string
$searchTitle = isset($_GET['title']) ? trim($_GET['title']) : '';

// Read status filter from query string
$statusFilter = isset($_GET['status']) ? strtolower(trim($_GET['status'])) : '';
$validStatuses = ['upcoming', 'active', 'completed'];
if (!in_array($statusFilter, $validStatuses)) {
    $statusFilter = ''; // treat anything invalid as "all"
}

$db = get_pdo_connection();

// Build query (filter by title only)
if ($searchTitle === '') {
    $tournamentsStmt = $db->prepare("
        SELECT tournament_id, title, description, tourneystatus, start_at, end_at
        FROM view_tournament_summary
    ");
    $tournamentsStmt->execute();
} else {
    $tournamentsStmt = $db->prepare("
        SELECT tournament_id, title, description, tourneystatus, start_at, end_at
        FROM view_tournament_summary
        WHERE title LIKE :title
    ");
    $like = "%" . $searchTitle . "%";
    $tournamentsStmt->bindParam(':title', $like, PDO::PARAM_STR);
    $tournamentsStmt->execute();
}
$results = $tournamentsStmt->fetchAll(PDO::FETCH_ASSOC);

if ($searchTitle === '') {
    // NEW: get all active tournaments from the view
    $activeStmt = $db->prepare("
        SELECT tournament_id, title, description, tourneystatus, start_at, end_at
        FROM view_active_tournaments
    ");
    $activeStmt->execute();
} else {
    // NEW: filter the view by title when the user searches
    $activeStmt = $db->prepare("
        SELECT tournament_id, title, description, tourneystatus, start_at, end_at
        FROM view_active_tournaments
        WHERE title LIKE :title
    ");
    $like = "%" . $searchTitle . "%";
    $activeStmt->bindParam(':title', $like, PDO::PARAM_STR);
    $activeStmt->execute();
}
$activeResults = $activeStmt->fetchAll(PDO::FETCH_ASSOC);  // NEW
?>



<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
    crossorigin="anonymous"
  />
  <title>Fantasy Tourney - Tournaments</title>

  <style>
.tournaments-header {
    background: #34495E;
    color: white;
    padding: 50px 20px 35px;
    text-align: center;
    margin-bottom: 25px;
}


    .tournaments-header h1 {
        margin-bottom: 8px;
    }
    .tournaments-header p.lead {
        max-width: 700px;
        margin: 0 auto;
        font-size: 1.05rem;
    }

    @media (min-width: 992px) {
        .container-narrow {
            max-width: 960px;
        }
    }

    .section-heading {
        display: flex;
        align-items: center;
        gap: 8px;
        font-size: 1.1rem;
        font-weight: 600;
        margin-top: 24px;
        margin-bottom: 6px;
    }

    .status-dot {
        width: 12px;
        height: 12px;
        border-radius: 50%;
        display: inline-block;
    }
    .status-dot-upcoming { background-color: #FF9800; }
    .status-dot-active   { background-color: #4CAF50; }
    .status-dot-completed{ background-color: #9E9E9E; }

    .tournament-pill {
        border-radius: 999px;
        padding: 6px 16px;
        font-size: 0.95rem;
    }
  </style>
</head>
<body>
  <?php require_once("./navbar.php"); ?>

  <!-- Gradient header -->
  <div class="tournaments-header">
      <h1 class="display-5">Browse Tournaments</h1>
      <p class="lead">
          Search for tournaments, filter by status, and jump straight into the bracket view.
      </p>
  </div>

  <div class="container container-narrow mb-5">
    <!-- SEARCH + STATUS FILTER FORM -->
    <form class="row g-2 mb-3 align-items-center" method="get" action="tournaments.php">

        <!-- Search bar -->
        <div class="col-md-7 col-lg-8">
            <input
                type="text"
                name="title"
                class="form-control"
                placeholder="Search tournaments"
                value="<?= htmlspecialchars($searchTitle) ?>"
                style="height: 38px;"
            >
        </div>

        <!-- Status dropdown -->
        <div class="col-md-3 col-lg-2">
            <select
                name="status"
                class="form-select form-select-sm"
                style="height: 38px;"
            >
                <option value="" <?= $statusFilter === '' ? 'selected' : '' ?>>All</option>
                <option value="upcoming" <?= $statusFilter === 'upcoming' ? 'selected' : '' ?>>Upcoming</option>
                <option value="active" <?= $statusFilter === 'active' ? 'selected' : '' ?>>Active</option>
                <option value="completed" <?= $statusFilter === 'completed' ? 'selected' : '' ?>>Completed</option>
            </select>
        </div>

        <!-- Search button -->
        <div class="col-md-2 col-lg-2">
            <button class="w-100 btn-sm" type="submit" style="height:38px; background:#f2f2f5; color:#333; border:1px solid #d3d3d9;">Search</button>
        </div>
    </form>

    <?php if ($searchTitle !== '' || $statusFilter !== ''): ?>
      <p class="text-muted mb-3">
        <?php if ($searchTitle !== ''): ?>
          Search: <strong><?= htmlspecialchars($searchTitle) ?></strong>
        <?php endif; ?>
        <?php if ($statusFilter !== ''): ?>
          <?= $searchTitle !== '' ? ' | ' : '' ?>
          Status: <strong><?= ucfirst($statusFilter) ?></strong>
        <?php endif; ?>
      </p>
    <?php endif; ?>

    <!-- UPCOMING -->
    <?php if ($statusFilter === '' || $statusFilter === 'upcoming'): ?>
      <hr>
      <h3 class="section-heading">
          <span class="status-dot status-dot-upcoming"></span>
          Upcoming
      </h3>
      <?php
        $hasUpcoming = false;
        ob_start();
      ?>
      <div class="d-flex flex-wrap gap-2 mt-2">
      <?php
        foreach ($results as $tournament) {
          if ($tournament['tourneystatus'] === "Upcoming") {
            $hasUpcoming = true;
            $id    = (int)$tournament['tournament_id'];
            $title = htmlspecialchars($tournament['title']);
            echo <<<HTML
              <a href="round8.php?tournament_id={$id}" 
              class="btn btn-primary tournament-pill" 
              style="background-color: #FF9800; border-color: #FF9800;">
                  {$title}
              </a>
            HTML;
          }
        }
      ?>
      </div>
      <?php
        $upcomingHtml = ob_get_clean();
        if ($hasUpcoming) {
            echo $upcomingHtml;
        } else {
            echo '<p class="text-muted mt-2">No upcoming tournaments match your filters.</p>';
        }
      ?>
    <?php endif; ?>

    <!-- ACTIVE -->
    <?php if ($statusFilter === '' || $statusFilter === 'active'): ?>
       <hr>
  <h3 class="section-heading">
      <span class="status-dot status-dot-active"></span>
      Active
  </h3>
  <?php
    $hasActive = false;
    ob_start();
  ?>
  <div class="d-flex flex-wrap gap-2 mt-2">
  <?php
    foreach ($results as $tournament) {
      if ($tournament['tourneystatus'] === "Active") {
        $hasActive = true;
        $id    = (int)$tournament['tournament_id'];
        $title = htmlspecialchars($tournament['title']);
        echo <<<HTML
          <a href="round8.php?tournament_id={$id}" class="btn btn-success tournament-pill">
              {$title}
          </a>
        HTML;
      }
    }
  ?>
      </div>
      <?php
        $activeHtml = ob_get_clean();
        if ($hasActive) {
            echo $activeHtml;
        } else {
            echo '<p class="text-muted mt-2">No active tournaments match your filters.</p>';
        }
      ?>
    <?php endif; ?>

    <!-- COMPLETED -->
    <?php if ($statusFilter === '' || $statusFilter === 'completed'): ?>
      <hr>
      <h3 class="section-heading">
          <span class="status-dot status-dot-completed"></span>
          Completed
      </h3>
      <?php
        $hasCompleted = false;
        ob_start();
      ?>
      <div class="d-flex flex-wrap gap-2 mt-2">
      <?php
        foreach ($results as $tournament) {
          if ($tournament['tourneystatus'] === "Completed") {
            $hasCompleted = true;
            $id    = (int)$tournament['tournament_id'];
            $title = htmlspecialchars($tournament['title']);
            echo <<<HTML
              <a href="round8.php?tournament_id={$id}" class="btn btn-secondary tournament-pill">
                  {$title}
              </a>
            HTML;
          }
        }
      ?>
      </div>
      <?php
        $completedHtml = ob_get_clean();
        if ($hasCompleted) {
            echo $completedHtml;
        } else {
            echo '<p class="text-muted mt-2">No completed tournaments match your filters.</p>';
        }
      ?>
    <?php endif; ?>

  </div>

  <script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
    crossorigin="anonymous"
  ></script>
</body>
</html>
