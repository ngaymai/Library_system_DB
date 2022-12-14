<?php
require 'config.php';
$ssn = $_COOKIE['id'];
$query = "select A.BID from bill A, valid_bill B where A.BID = B.BID and A.MEMBER_SSN = '$ssn'";
$res = mysqli_query($conn, $query);
$data1 = array();

while ($row = mysqli_fetch_assoc($res)) {
  $data1[] = $row;
}

$query = "select A.BID from bill A, invalid_bill B where A.BID = B.BID and A.MEMBER_SSN = '$ssn'";
$res = mysqli_query($conn, $query);
$data2 = array();

while ($row = mysqli_fetch_assoc($res)) {
  $data2[] = $row;
}

if (isset($_POST['details'])) {
  $t = $_POST['details'][0];

  $_SESSION["bid"] = $data[$t]['BID'];
  header("Location: ./billInfo.php");

}
if (isset($_POST['detail1'])) {
  $_SESSION["bid"] = $_POST['detail1'][0];
  header("Location: ./user-billInfo.php");

}

// $query1 = "SELECT language FROM language WHERE ISBN = '001'";
// $res1 = mysqli_query($conn, $query1);
// $ar1=[];
// while($row1 = mysqli_fetch_assoc($res1)){
//   $tmp =  implode(',',$row1); 
//   $ar1[] = $tmp;                
// } 
// var_dump($ar1);
// echo implode(',',$ar1);   

?>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Manage book</title>
  <link rel="stylesheet" href="../static/styles.css">
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

  <div class="mngBill">
    <div class="sidebar">
      <div class="top">
        <a href="#" style="text-decoration: none;">
          <span class="logo">LMS</span>
        </a>
      </div>
      <hr />
      <div class="center">
        <ul>
          <p class="title">MAIN</p>
          <a href="./user-dashboard.php">
            <li>
              <i class="fas fa-th-large"></i>
              <span>Dashboard</span>
            </li>
          </a>
          <p class="title">SERVICE</p>

          <!-- <a href="./addBook.php">
            <li>
              <span>Insert book</span>
            </li>
          </a> -->
          <a href="./user-viewbook.php">
            <li>
              <span>
                <i class="fas fa-book"></i>
                Book Library
              </span>
            </li>
          </a>
          <!-- <a href="./createBill.php">
            <li>
              <span>Create bill</span>
            </li>
          </a> -->
          <a href="./user-bill.php">
            <li class="active">
              <span>
                <i class="fas fa-clipboard-list"></i>
                Bill information
              </span>
            </li>
          </a>
          <a href="./user-infor.php">
            <li>
              <span>
                <i class="fas fa-clipboard-list"></i>
                User information
              </span>
            </li>
          </a>
          <a href="./config.php?logout=true">
            <li>
              <span>
                <i class="fas fa-sign-out-alt"></i>
                Log out
              </span>
            </li>
          </a>
        </ul>
      </div>
    </div>

    <div class="mngBill-container">
      <center>
        <h3 style="margin-bottom: 50px">Simple library management</h3>
      </center>


      <div class="card m-4">
        <div class="card-body">
          <h3>Active bill</h3>
          <div class="mt-lg-5">
            <table class="table mt-3">
              <thead class="thead-light">
                <tr>
                  <th scope="col">Bill ID</th>
                  <th scope="col">Action</th>
                </tr>
              </thead>
              <tbody>
                <?php

                for ($i = 0; $i < count($data1); $i++) {
                  echo '  <tr>
  <th scope="row">' . $data1[$i]['BID'] . '</th> 
  <td>  <a href="./user-billInfor.php?bid=' . $data1[$i]['BID'] . '" class="btn btn-primary">View detail</a></td>
  </tr>  ';
                }
                ?>
              </tbody>
            </table>
          </div>
        </div>
      </div>


      <div class="card m-4">
        <div class="card-body">
          <h3>Inactive bill</h3>
          <div class="mt-lg-5">
            <table class="table mt-3">
              <thead class="thead-light">
                <tr>
                  <th scope="col">Bill ID</th>                  
                  <th scope="col">Action</th>
                </tr>
              </thead>
              <tbody>
              <?php

for ($i = 0; $i < count($data2); $i++) {
  echo '  <tr>
<th scope="row">' . $data2[$i]['BID'] . '</th> 
<td>  <a href="./user-billInfor.php?bid=' . $data2[$i]['BID'] . '" class="btn btn-primary">View detail</a></td>
</tr>  ';
}
?>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>



  </div>
</body>



</html>