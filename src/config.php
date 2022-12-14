<?php
session_start();
if(isset($_COOKIE['id'])){
    $id = $_COOKIE['id'];
    if($id[0] == 'M'){
        //mysqli_close($conn);
        $conn = mysqli_connect("localhost","member","000000","libdb") or die ("could not connect to mysql");
    }
    elseif($id[0] == 'S') {
        //mysqli_close($conn);
        $conn = mysqli_connect("localhost", "staff", "000000", "libdb") or die("could not connect to mysql");
    } 
   
}
else{
    $conn = mysqli_connect("localhost","system","000000","libdb") or die ("could not connect to mysql"); 
}

if(isset($_GET['logout'])){
    
    setcookie("login", "false", time() - 3600, "/");
    setcookie("id", "", time() - 3600, "/");
    $_SESSION = [];
    session_unset();
    session_destroy();
    mysqli_close($conn);
        header("Location: ./login.php");
}
?>