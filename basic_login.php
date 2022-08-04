<?php
// session_start();
// if($_SESSION['username'] != NULL) {
//     header('Location: index.php');
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
    
</head>


<body class="text-center">
    <?php
        $con = oci_connect('STUDENT', 'STUDENT', 'localhost/XE') or die;

        include("nav_barr.php");
        function Login ()
        {
            global $con;
            $username = $_POST['username'];
            $password = $_POST['passwd'];
            $id_user = 0;
            $res_value = 0;
            $sql = 'BEGIN Login(:userr,:passs,:id_user,:res_value); END;';
            $stid = oci_parse($con, $sql);

            oci_bind_by_name($stid, ':userr',$username, 32);
            oci_bind_by_name($stid, ':passs',$password, 32);
            oci_bind_by_name($stid, ':id_user',$id_user, 20);
            oci_bind_by_name($stid, ':res_value',$res_value,20);
            oci_execute($stid);
            
            
            if($res_value==1)
            {
                session_start();
                $_SESSION['username'] = $username;
                $_SESSION['id_user'] = $id_user;
                header('location: home_page_log.php');
            }
            else
            {
                echo '<p class="error">Please provide valid username and password</p>';
            }
            
        }
        if(isset($_POST['submit']))
            { 
                Login();
            }
    ?>





<div id="login_box"
style ="margin-left: auto; margin-right:auto; width: 40%;">
<h1 class="h3 mb-3 font-weight-normal">Please login</h1>
    <form action="basic_login.php" method="post" class="form-signin" style = "flex-direction: column">
        <div id="login_username">
            <label for="re_username" class="sr-only">Username:</label>
            <input type="text" id="username" class="form-control" placeholder="Enter your username" name="username"/>
        </div>
        <div id="login_password">
            <label for="login_password" class="sr-only">Password:</label>
            <input type="password" id="passwd" class="form-control" placeholder="Enter your password" name="passwd"/>
        </div>
        <button class="btn btn-lg btn-primary btn-block" type="submit" name="submit">Login</button>
    </form>
</body>
</html>