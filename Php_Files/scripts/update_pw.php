
<!-- code from professor for making hashed passwords on mock data generated -->

<?php

// update_pw.php
// Traverses a MariaDB table and replaces a password column with the
// result of PHP's password_hash() function

function getInput($prompt = "Enter Input: ") {
    echo $prompt;
    return trim(fgets(STDIN));
}

function getPassword($prompt = "Enter Password:") {
    echo $prompt;

    system('stty -echo');

    $password = trim(fgets(STDIN));

    system('stty echo');

    echo "\n";

    return $password;
}
$user = getInput("Enter username: ");
$dbpass = getPassword();
$dbname = getInput("Enter database: ");
//$db = new mysqli("localhost", $user, $dbpass, $dbname);
$db = new PDO("mysql:host=localhost;dbname=$dbname", $user, $dbpass, array());

$tables = $db->prepare("show tables");
$tables->execute();

$tableNames = $tables->fetchAll(PDO::FETCH_NUM);

//while ($table = $tableNames->fetch_assoc()) {
foreach($tableNames as $table) {
    echo $table[0] . "\n";
}

$chosenTable = getInput("Enter a table name: ");

$cq = $db->prepare("describe $chosenTable");
$cq->execute();

$describe = $cq->fetchAll(PDO::FETCH_ASSOC);

echo "Description of columns in $chosenTable\n";

//while ($d = $describe->fetch_assoc()) {
foreach($describe as $d) {
    echo "Field: " . $d['Field'] . ", Type: " . $d['Type']  . " \n";
    //print_r($d);
}

$pkColumn = getInput("Enter a column to represent the primary key: ");
$passwordColumn = getInput("Enter a column name to run through password_hash: ");
$passwordSaveTo = getInput("Enter a column name to save the hashed password to: ");
$cq = $db->prepare("select * from $chosenTable WHERE $passwordColumn IS NOT NULL");
$cq->execute();

$rows = $cq->fetchAll(PDO::FETCH_ASSOC);

$numRows = count($rows);
$input = getInput("Press enter to show $chosenTable contents ($numRows rows): ");

$first = false;
//while ($row = $rows->fetch_assoc()) {
foreach($rows as $row) {
    $id = $row[$pkColumn];
    $plaintext = $row[$passwordColumn];
    $hash = password_hash($plaintext, PASSWORD_DEFAULT);
    echo "$id: $plaintext -> $hash\n";

    $update = $db->prepare("UPDATE $chosenTable SET `$passwordSaveTo` = ? WHERE $pkColumn = ?");
    $update->bindParam(1, $hash, PDO::PARAM_STR);
    $update->bindParam(2, $id, PDO::PARAM_STR);
    if (!$update->execute()) {
        print_r($db->errorInfo());
    }
}
?>
