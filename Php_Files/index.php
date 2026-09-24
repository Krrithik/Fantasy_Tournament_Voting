<?php 
require_once("./config.php");

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
    <title>Fantasy-Tourney</title>
  </head>
  <body>
    <?php 
      require_once("./navbar.php");
    ?>
    <h1>Hello world</h1>

    <?php 
      $db = get_pdo_connection();
      $users = $db->prepare("select * from users");
      $users->execute();
      $results = $users->fetchAll(PDO::FETCH_ASSOC);

      foreach($results as $user){
        echo "<div>";
        echo "{$user['displayname']}";
        echo "</div>";
      }
    ?>
    

    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
      crossorigin="anonymous"
    ></script>
  </body>
</html>
