<?php
session_start(); //starts all the sessions 
    if($_SESSION['username'] == NULL) {
        header('Location: home_page.php'); //take user to the login page if there's no information stored in session variable
    } 
?>

<!DOCTYPE html>
<html>
<head>
    <title>Mersul Trenurilor</title>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="description" content="Main Page Mersul Trenurilor"/>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/login.css" rel="stylesheet">
    
</head>

<body class="text-center">

<?php
    include("nav_barr.php");
    //include("search_trains.php");
    

?>
<div id="login_box"
style ="margin-left: auto; margin-right:auto; width: 40%;">
<h1 class="h3 mb-3 font-weight-normal">Welcome, fellow!</h1>
</div>
</body>
</html>