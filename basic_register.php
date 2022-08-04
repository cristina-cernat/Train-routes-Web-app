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
    <link href="css/register.css" rel="stylesheet">

</head>

<body class="text-center">
    <?php
        $con = oci_connect('STUDENT', 'STUDENT', 'localhost/XE') or die;
        include("nav_barr.php");
            function Register()
            {
                global $con;
                $res_value = 0;
                $username = $_POST['username'];
                $password = $_POST['passwd'];
                    if(is_valid_username($username) && is_valid_password($password))
                    {
                        $sql = 'BEGIN Register(:usern,:parola,:res_value); END;';
                        $stid = oci_parse($con, $sql);
                        
                        oci_bind_by_name($stid, ':usern',$username, 32);
                        oci_bind_by_name($stid, ':parola',$password, 32);
                        oci_bind_by_name($stid, ':res_value',$res_value,20);
                        oci_execute($stid);

                        if($res_value==1)
                        {
                            session_start();
                            $_SESSION['username'] = $username;
                            $_SESSION['passwd'] = $password;
                            header('location: basic_login.php');
                        }
                    }
                    else
                    {
                        echo '<p class="error">Please provide valid username and password:</p>';
                        echo '<p class="sub-error">Username must be between 6-32 characters, must start with letter</p>';
                        echo '<p class="sub-error">Password needs to be at least 8 characters, must contain at least one lowercase and uppercase</p>';
                    }
            }

            function is_valid_username($username) {
                //  $user_pattern = '/^[A-Za-z][A-Za-z0-9][.][A-Za-z0-9]{5,31}$/';
                //  return preg_match_all($user_pattern, $username) ? TRUE : FALSE;
                return TRUE;
            }
            
            function is_valid_password($password) {
                //  $pass_pattern = '$S*(?=S{8,})(?=S*[a-z])(?=S*[A-Z])';
                //  return preg_match_all($pass_pattern, $password) ? TRUE : FALSE;
                return TRUE;
            }
            if(isset($_POST['submit']))
            {
                Register();
            }
    ?>

<div id="login_box"
style ="margin-left: auto; margin-right:auto; width: 40%;">
<h1 class="h3 mb-3 font-weight-normal">Register Now!</h1>
    <form action="basic_register.php" method="post" class="form-signin">
        <div id="login_username">
            <label for="login_username" class="sr-only">Username:</label>
            <input type="text" id="username" class="form-control" placeholder="Enter your username" name="username"/>
        </div>
        <div id="login_password">
            <label for="login_password" class="sr-only">Password:</label>
            <input type="password" id="passwd" class="form-control" placeholder="Enter your password" name="passwd"/>
        </div>
        <!-- <div id="login_password">
            <label for="login_password" class="sr-only">Password:</label>
            <input type="password" id="passwd" class="form-control" placeholder="Re-enter your password" name="passwd"/>
        </div> -->
        <button class="btn btn-lg btn-primary btn-block" type="submit" name="submit" value="register">Register</button>
    </form>
</body>
</html>