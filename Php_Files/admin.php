<?php
require_once("config.php");
require_once("auth.php");
require_once("./index.html");

// REQUIRE ADMIN ACCOUNT
if (!isset($_SESSION["role"]) || $_SESSION["role"] !== "admin") {
    header("Location: guest_denied.php");
    exit;
}

$db = get_pdo_connection();

// Fetch all users
$users = $db->query("SELECT user_id, email, displayname FROM users ORDER BY user_id")->fetchAll(PDO::FETCH_ASSOC);

// Fetch all tournaments
$tournaments = $db->query("
    SELECT tournament_id, title, tourneystatus, user_id
    FROM view_tournament_summary
    ORDER BY tournament_id DESC
")->fetchAll(PDO::FETCH_ASSOC);
?>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    body {
        background: linear-gradient(135deg, #EEF2F3 0%, #DDE1E7 100%);
    }

    .profile-container {
        background: #FFFFFF;
        border-radius: 12px;
        padding: 25px;
        box-shadow: 0 6px 18px rgba(0,0,0,0.08);
        margin-bottom: 25px;
    }

    .section-title {
        font-weight: 600;
        font-size: 1.3rem;
        color: #2C3E50;
        border-left: 4px solid #4A90E2;
        padding-left: 10px;
        margin-bottom: 12px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .collapse-btn {
        font-size: 0.85rem;
        border-radius: 8px;
        padding: 4px 10px;
    }

    .search-box {
        margin-bottom: 10px;
    }

    .dropdown-search-list {
        background: white;
        border: 1px solid #ccc;
        border-radius: 6px;
        display: none;
        max-height: 200px;
        overflow-y: auto;
        position: absolute;
        width: 100%;
        z-index: 10;
    }

    .dropdown-search-item {
        padding: 8px 12px;
        cursor: pointer;
    }
    .dropdown-search-item:hover {
        background-color: #f0f0f0;
    }
</style>
</head>

<body>
<?php require_once("navbar.php"); ?>

<div class="container mt-4">

    <!-- ADMIN HEADER -->
    <div class="profile-container">
        <div class="section-title">Admin Panel</div>
        <p class="text-muted">Manage users and tournaments.</p>
    </div>

    <!-- USERS SECTION -->
    <div class="profile-container">
        <div class="section-title">
            All Users
            <button class="btn btn-outline-primary collapse-btn" 
                    data-bs-toggle="collapse" 
                    data-bs-target="#usersSection">
                View
            </button>
        </div>

        <div class="collapse" id="usersSection">

            <!-- USER SEARCH -->
            <div class="position-relative">
                <input id="userSearch" type="text" class="form-control search-box" placeholder="Search users...">
                <div id="userDropdown" class="dropdown-search-list"></div>
            </div>

            <!-- USERS TABLE -->
            <table class="table table-bordered table-sm">
                <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th>Email</th>
                        <th>Display Name</th>
                        <th>Actions</th>
                    </tr>
                </thead>

                <tbody id="userTable">
                    <?php foreach ($users as $u): ?>
                    <tr>
                        <td><?= $u["user_id"] ?></td>
                        <td><?= htmlspecialchars($u["email"]) ?></td>
                        <td><?= htmlspecialchars($u["displayname"]) ?></td>
                        <td>
                            <a href="delete_user.php?id=<?= $u['user_id'] ?>"
                               class="btn btn-sm btn-danger"
                               onclick="return confirm('Ban/delete this user?');">
                                Delete
                            </a>
                        </td>
                    </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>

        </div>
    </div>


    <!-- TOURNAMENTS SECTION -->
    <div class="profile-container">
        <div class="section-title">
            All Tournaments
            <button class="btn btn-outline-primary collapse-btn" 
                    data-bs-toggle="collapse" 
                    data-bs-target="#tournamentsSection">
                View
            </button>
        </div>

        <div class="collapse" id="tournamentsSection">

            <!-- TOURNAMENT SEARCH -->
            <div class="position-relative">
                <input id="tournamentSearch" type="text" class="form-control search-box" placeholder="Search tournaments...">
                <div id="tournamentDropdown" class="dropdown-search-list"></div>
            </div>

            <!-- TOURNAMENT TABLE -->
            <table class="table table-bordered table-sm">
                <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Status</th>
                        <th>Creator</th>
                        <th>Actions</th>
                    </tr>
                </thead>

                <tbody id="tournamentTable">
                    <?php foreach ($tournaments as $t): ?>
                    <tr>
                        <td><?= $t["tournament_id"] ?></td>
                        <td><?= htmlspecialchars($t["title"]) ?></td>
                        <td><?= $t["tourneystatus"] ?></td>
                        <td><?= $t["user_id"] ?></td>
                        <td>
                            <a href="delete_tournament.php?id=<?= $t['tournament_id'] ?>"
                               class="btn btn-sm btn-danger"
                               onclick="return confirm('Delete this tournament AND all matchups/entries/votes?');">
                                Delete
                            </a>
                        </td>
                    </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>

        </div>
    </div>

</div>

<script>
// ------------- USER SEARCH FILTER & DROPDOWN ----------
document.getElementById("userSearch").addEventListener("input", function() {
    const query = this.value.toLowerCase();
    const rows = document.querySelectorAll("#userTable tr");
    const dropdown = document.getElementById("userDropdown");

    dropdown.innerHTML = "";
    dropdown.style.display = query ? "block" : "none";

    rows.forEach(row => {
        const text = row.innerText.toLowerCase();
        row.style.display = text.includes(query) ? "" : "none";

        if (text.includes(query)) {
            const item = document.createElement("div");
            item.className = "dropdown-search-item";
            item.innerText = row.children[2].innerText;
            item.onclick = () => {
                row.scrollIntoView({ behavior: 'smooth', block: 'center' });
                dropdown.style.display = "none";
            };
            dropdown.appendChild(item);
        }
    });
});

// ------------- TOURNAMENT SEARCH FILTER & DROPDOWN ----------
document.getElementById("tournamentSearch").addEventListener("input", function() {
    const query = this.value.toLowerCase();
    const rows = document.querySelectorAll("#tournamentTable tr");
    const dropdown = document.getElementById("tournamentDropdown");

    dropdown.innerHTML = "";
    dropdown.style.display = query ? "block" : "none";

    rows.forEach(row => {
        const text = row.innerText.toLowerCase();
        row.style.display = text.includes(query) ? "" : "none";

        if (text.includes(query)) {
            const item = document.createElement("div");
            item.className = "dropdown-search-item";
            item.innerText = row.children[1].innerText;
            item.onclick = () => {
                row.scrollIntoView({ behavior: 'smooth', block: 'center' });
                dropdown.style.display = "none";
            };
            dropdown.appendChild(item);
        }
    });
});
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
