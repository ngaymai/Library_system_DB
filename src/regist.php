<?php
require 'config.php';
//require 'privileges.php';

if(isset($_POST['submit']))
{
  $fullname = $_POST['fullname'];
  $address = $_POST['addr'];
  $email = $_POST['email'];
  $password = $_POST['pswd'];
  $phone = $_POST['pnb'];
  $username = $_POST['username'];
  $check = 1;  
  $query = "call check_account('$email','','')";
  $duplicate = mysqli_query($conn, $query);
  if(mysqli_num_rows($duplicate)>0){  
      echo
      "<script>alert('Email has already exist')</script>";
      $check = 0;
  } 
  mysqli_free_result($duplicate);
  mysqli_next_result($conn);

  $query = "call check_account('','$phone','')";
  $duplicate = mysqli_query($conn, $query);
  if(mysqli_num_rows($duplicate)>0){  
      echo
      "<script>alert('Phone number has already exist')</script>";
    $check = 0;
  } 
  mysqli_free_result($duplicate);
  mysqli_next_result($conn);
  
  $query = "call check_account('','','$username')";
  $duplicate = mysqli_query($conn, $query);
  if(mysqli_num_rows($duplicate)>0){  
      echo
      "<script>alert('Username has already exist')</script>";
      $check = 0;
  } 
  mysqli_free_result($duplicate);
  mysqli_next_result($conn);
  
  
  if($check == 1){
    if(isset($_POST['is_staff'])){
      
      $query = " call insert_account('$email','$password','$fullname','$address','$phone', '$username','1') ";
      }
    else{
          $query = " call insert_account('$email','$password','$fullname','$address','$phone', '$username','0') ";
      }
      mysqli_query($conn, $query);
      echo
  "<script>alert('Regist successfully')</script>";  
  } 
}
?>

<!DOCTYPE html>

<html>
    <head>
    <title>Library System</title>
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
      
  
    </head>
    <body>
    <div class="container"  >
  <h2>Regist</h2>
  <br>
  <form method="POST" action="">
  <div class="form-group form-check">
    <label class="form-check-label">
      <input class="form-check-input" type="checkbox" name="is_staff"> Staff
    </label>
  </div>
    <div class="form-group">
      <label for="email">Email:</label>
      <input type="email" class="form-control" id="email" placeholder="Enter email" name="email" require>
    </div>
    <div class="form-group">
      <label for="addr">Address:</label>
      <input type="text" class="form-control" id="addr" placeholder="Enter address" name="addr" require>
    </div>
    <div class="form-group">
      <label for="fullname">fullname:</label>
      <input type="text" class="form-control" id="fullname" placeholder="Enter fullname" name="fullname" require>
    </div>
    <div class="form-group">
      <label for="pnb">Phone number:</label>      
      <input type="tel" class="form-control" id="pnb" placeholder="Enter phone number" name="pnb" require>
    </div>
    <div class="form-group">
      <label for="username">username:</label>
      <input type="text" class="form-control" id="username" placeholder="Enter username" name="username" require>
    </div>
    <div class="form-group">
      <label for="pwd">Password:</label>
      <input type="password" class="form-control" id="pwd" placeholder="Enter password" name="pswd" require>
    </div>
    <div class = "text-left">
      <button type="submit" class="btn btn-primary" name="submit">Register</button>
     </div>    
  </form>
  <br>
  <a href="./login.php">Login</a>
  <hr>
</div>



    </body>
</html>




