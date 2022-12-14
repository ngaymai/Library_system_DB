<?php
require 'config.php';

if(isset($_POST["submit"]))
{  
  $password = $_POST['pswd'];
  $username = $_POST['username'];
  
  
  $query = "call find_account('$username')";
  $res = mysqli_query($conn, $query);
  $row = mysqli_fetch_assoc($res);  
  if(mysqli_num_rows($res)>0){
      if($password == $row["PASSWORD"]){        
       // $_SESSION["login"]=true;
       // $_SESSION["id"] = $row["SSN"];
      setcookie("login", "true", time() + 24 * 60 * 60, "/");
      setcookie("id", $row["SSN"], time()+ 24*60*60, "/");
      if($row["SSN"][0] == 'S')
        header("Location: ./dashboard.php");
      else if($row["SSN"][0]=='M')
        header("Location: ./user-dashboard.php");
      }
      else{
        echo
      "<script>alert('Wrong Password')</script>";
      }
  } 
  else{      
          echo
      "<script>alert('User not exist')</script>";
    } 
    mysqli_free_result($res);
    mysqli_next_result($conn);  
  }
?>

<!DOCTYPE html>

<html>
    <head>
    <title>Login</title>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="style.css">
        <link rel="stylesheet" href="//use.fontawesome.com/releases/v5.15.4/css/all.css">
  <!-- Latest compiled and minified CSS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">

  <!-- jQuery library -->
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>

  <!-- Popper JS -->
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

  <!-- Latest compiled JavaScript -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
      
       <!----> 
    </head>
    <body>
    <div class="container">
  <h2>Login</h2>
  <form method="Post" action="">
    <div class="form-group">
      <label for="username">Username:</label>
      <input type="text" class="form-control" id="username" placeholder="Enter username" name="username">
    </div>
    <div class="form-group">
      <label for="pwd">Password:</label>
      <input type="password" class="form-control" id="pwd" placeholder="Enter password" name="pswd">
    </div>
    <div class = "text-left">
      <button type="submit" class="btn btn-primary" name="submit">Login</button>
      </div>
       
    <div class="text-center" >        
        <p>Don't have an accounts? <a href="./regist.php"> Sign up</a></p>   
    </div>    
  </form>
</div>




    </body>
</html>