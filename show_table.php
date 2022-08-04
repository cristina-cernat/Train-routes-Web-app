<?php
session_start(); //starts all the sessions 
error_reporting(E_ERROR | E_PARSE);
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
$con = oci_connect('STUDENT', 'STUDENT', 'localhost/XE') or die;

include("nav_barr.php");

    $first_st = $_GET['first_st'];
    $second_st = $_GET['second_st'];
    $rezultat = '';
    $sql_direct = 'BEGIN :out := traseu.traseu_direct(:statie1,:statie2); END;';
    $stid = oci_parse($con, $sql_direct);

    oci_bind_by_name($stid, ':statie1',$first_st, 32);
    oci_bind_by_name($stid, ':statie2',$second_st, 32);
    oci_bind_by_name($stid, ':out',$rezultat, 3000);
    oci_execute($stid);

    $linii = explode(";",$rezultat);




        //table
        echo "<table border='1' style=\"margin:auto; width: 75%;>\n\"";
        $ncols = 5;
    
        //head of the table
        echo "<tr>\n";
        
        echo "<th>From</th>\n";
        echo "<th>To</th>\n";
        echo "<th>Train number</th>\n";
        echo "<th>Leaves at</th>\n";
        echo "<th>Arrives at</th>\n";
        
        
        echo "</tr>\n";

    foreach ($linii as $inc)
    { 
        foreach (explode(',', $inc) as $item)
        {
            echo '<td>'.$item.'</td>';
            //echo "</tr>\n";
        }
        echo "</tr>\n";
    }
    echo "</table>\n";

 //code to handle the exception
    if(empty($rezultat)==true)
    {
    
        echo '<p class="error">No data found</p>';
    }
//print($rezultat);
    


?>

</body>
</html>
