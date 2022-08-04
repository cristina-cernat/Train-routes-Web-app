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

     $con = oci_connect('STUDENT', 'STUDENT', 'localhost/XE') or die;

     function Search()
     {
        global $con;
        $first_st = $_GET['first_st'];
        $second_st = $_GET['second_st'];
        $rezultat = '';
        $sql_direct = 'BEGIN :out := traseu_direct(:statie1,:statie2); END;';
        $stid = oci_parse($con, $sql);

        oci_bind_by_name($stid, ':statie1',$first_st, 32);
        oci_bind_by_name($stid, ':statie2',$second_st, 32);
        oci_bind_by_name($stid, ':out',$rezultat);
        oci_execute($stid);

        header("location: show_table.php");
     }

     if(isset($_POST['search']))
        { 
            Search();
        }


?>

<div style="margin-left: auto; margin-right: auto; display: flex-column;">
    <h1 class="h3 mb-3 font-weight-normal" style="margin-left: auto; margin-right: auto;">Enter your stations</h1>
    <form class="form-inline mt-2 mt-md-0" action="show_table.php" method="get" style="margin-left: auto; margin-right: auto;">

      <input class="form-control mr-sm-2" type="text" name="first_st" placeholder="From" aria-label="Search">
      <input class="form-control mr-sm-2" type="text" name="second_st" placeholder="To" aria-label="Search">
      <button class="btn btn-outline-success my-2 my-sm-0" style="color: #ffff !important; border-color: #007bff !important; background-color: #007bff;"  type="submit" name="search">Search</button>
    </form>
</div>

</body>
</html