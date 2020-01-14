
<?php

header("Access-Control-Allow-origin: *");

$dsn = "mysql:host=localhost;dbname=leave";
$username = "root";
$password = "";
$cs =   'utf8';

try{
    $db = new PDO($dsn, $username, $password);
    echo "you've connected to death stranding";
}catch(PDOException $e){
    $error_message = $e->getMessage();
    echo $error_message;
    exit();
}
?>