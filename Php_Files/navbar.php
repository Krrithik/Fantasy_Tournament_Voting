<?php
// Figure out "current" tournament for Statistics link
$currentTournamentId = null;

// If page has ?tournament_id=### in the URL, then use it
if (isset($_GET['tournament_id']) && ctype_digit((string)$_GET['tournament_id'])) {
    $currentTournamentId = (int)$_GET['tournament_id'];

// Else fall back to what we remembered in the session
} elseif (isset($_SESSION['current_tournament_id']) && ctype_digit((string)$_SESSION['current_tournament_id'])) {
    $currentTournamentId = (int)$_SESSION['current_tournament_id'];
}
?>


<nav class="navbar navbar-expand-lg navbar-light" 
     style="background-color:#E3E6EB;">

  <div class="container-fluid">
    <a class="navbar-brand" href="welcome.php">Fantasy Tourney</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">

      <!-- LEFT SIDE NAV ITEMS (pushed left via me-auto) -->
      <!-- Navigation Links -->
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">

        <li class="nav-item">
          <a class="nav-link" href="./welcome.php">Welcome</a>
        </li>

        <li class="nav-item">
            <a class="nav-link" href="./tournaments.php">Tournaments</a>
        </li>

        <?php if (isset($_SESSION["user_id"]) && $_SESSION["user_id"] !== "guest"): ?>
        <li class="nav-item">
            <a class="nav-link" href="profile.php">Profile</a>
        </li>
        <?php endif; ?>

      </ul>

      <!-- RIGHT SIDE NAV ITEMS (login, user, admin, logout) -->
      <!-- Login / Logout / Admin Panel -->
      <ul class="navbar-nav mb-2 mb-lg-0">

        <?php 
        // Navbar Login / Role Logic
        // Handles all user/session visibility
        
        // CASE 1 – NOT LOGGED IN AT ALL
        if (!isset($_SESSION["user_id"]) && !isset($_SESSION["role"])): ?>

            <li class="nav-item">
                <a class="nav-link" href="login.php">Login</a>
            </li>

            <li class="nav-item">
                <a class="nav-link" href="register.php">Register</a>
            </li>

            <li class="nav-item">
                <a class="nav-link text-info" href="guest_login.php">Continue as Guest</a>
            </li>

        <?php 
        // CASE 2 – LOGGED IN AS GUEST
        elseif (isset($_SESSION["role"]) && $_SESSION["role"] === "guest"): ?>

            <li class="nav-item">
                <span class="nav-link">Hello, Guest</span>
            </li>

            <li class="nav-item">
                <a class="nav-link" href="logout.php">Exit Guest Mode</a>
            </li>

        <?php 
        // CASE 3 – NORMAL USER / ADMIN
        else: ?>

            <li class="nav-item">
                <span class="nav-link">
                    Hello, <?php echo htmlspecialchars($_SESSION["displayname"]); ?>
                </span>
            </li>

            <?php if ($_SESSION["role"] === "admin"): ?>
            <li class="nav-item">
                <a class="nav-link" href="admin.php">Admin Panel</a>
            </li>
            <?php endif; ?>

            <li class="nav-item">
                <a class="nav-link" href="logout.php">Logout</a>
            </li>

        <?php endif; ?>

      </ul> <!-- END OF RIGHT SIDE NAV -->

    </div>
  </div>
</nav>