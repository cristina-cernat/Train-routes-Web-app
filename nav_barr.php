<?php
// session_start();
// if($_SESSION['username'] != NULL) {
//     header('Location: nav_bar_log.php');
// }
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
    <link href="css.nav_bar.css" rel="stylesheet">
    
    <style>
      .btn-outline-success:hover {color: #ffff !important; border-color: #007bff !important; background-color: #007bff;}
      .btn-outline-success:active {color: #ffff !important; border-color: #0056b3 !important; background-color: #0056b3 !important;}
      .btn-outline-success:focus {color: #ffff !important; border-color: #007bff !important; background-color: #007bff; box-shadow: rgba(0,0,255,0.3) !important;}
      .btn-outline-success:focus-within {color: #ffff !important; border-color: #007bff !important; background-color: #007bff;}
  
      
    </style>

</head>

<body>
  <?php
 
  
  // session_start();
  // if($_SESSION['username'] != NULL) {
  //     header('Location: nav_bar_log.php');
  // }
?>

<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
  <img src="img/train.svg" class="logo">
  <a class="navbar-brand" href="home_page.php" >Mersul Trenurilor</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarCollapse">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="search_trains.php">Search for a train<span class="sr-only">(current)</span></a>
      <!-- </li>
      <li class="nav-item">
        <a class="nav-link" href="basic_login.php">Login</a>
      </li> -->

      <!-- <li class="nav-item">
        <a class="nav-link disabled" href="#">Disabled</a>
      </li> -->
    </ul>
    <form class="form-inline mt-2 mt-md-0" method="post" action="basic_login.php">
      <!-- <input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search"> -->
        
      <button class="btn btn-outline-success my-2 my-sm-0" style="color: #007bff; border-color: #007bff" name="login" value="login">Login</button>
     <a class="nav-link" href="basic_register.php">Register</a>   
    </form>
  </div>
</nav>

</body>
</html>