<?php
require 'config.php';
$query = "call list_bill()";
$res = mysqli_query($conn, $query);
$data = array();

while ($row = mysqli_fetch_assoc($res)) {
  $data[] = $row;
}
mysqli_free_result($res);
mysqli_next_result($conn);

if (isset($_POST['details'])) {
  $t = $_POST['details'][0];

  $_SESSION["bid"] = $data[$t]['BID'];
  header("Location: ./billInfo.php");

}
if (isset($_POST['detail1'])) {
  $_SESSION["bid"] = $_POST['detail1'][0];
  header("Location: ./billInfo.php");

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
  <title>Create bill</title>
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
        <a href="./addBook.php" style="text-decoration: none;">
          <span class="logo">LMS</span>
        </a>
      </div>
      <hr />
      <div class="center">
        <ul>
          <p class="title">MAIN</p>
          <a href="./dashboard.php">
            <li>
              <span>Dashboard</span>
            </li>
          </a>
          <p class="title">SERVICE</p>

          <!-- <a href="./addBook.php">
            <li>
              <span>Insert book</span>
            </li>
          </a> -->
          <a href="./manageBook.php">
            <li>
              <span>
                <i class="fas fa-book"></i>
                Manage book
              </span>
            </li>
          </a>
          <a href="./manageMember.php">
            <li>
              <span>
                <i class="fas fa-users"></i>
                Manage member</span>
            </li>
          </a>
          <!-- <a href="./createBill.php">
            <li>
              <span>Create bill</span>
            </li>
          </a> -->
          <a href="./manageBill.php">
            <li>
              <span>
                <i class="fas fa-clipboard-list"></i>
                Manage bill
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
      <ul class="nav nav-tabs">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="#">Bill management</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="./createBill.php?act=create">Create new bill</a>
        </li>
      </ul>
      <form method="POST" class="search-bar mt-lg-5">
        <div method="POST" class="input-group">
          <input class="form-control border-end-0 border rounded-pill" type="text" id="example-search-input"
            placeholder="search..." name="bid">
          <div class="input-group-append">
            <button class="btn btn-outline-secondary bg-white border-start-0 border rounded-pill ms-n3" type="submit"
              name="sb">
              <i class="fa fa-search"></i>
            </button>
          </div>
        </div>
      </form>

      <!--IF found, -->

      <div class="mt-lg-5">
        <table class="table mt-3">
          <thead class="thead-light">
            <tr>
              <th scope="col">Bill ID</th>
              <th scope="col">Status</th>
              <th scope="col">Action</th>
            </tr>
          </thead>
          <tbody>
            <?php
          if (isset($_POST['sb']) && isset($_POST['bid'])) {
            $temp = $_POST['bid'];

            $query = "call search_bill($temp)";

            try {
              $res = mysqli_query($conn, $query);
              if (!$res)
                throw new Exception("");
              else {
                $data1 = array();
                while ($row = mysqli_fetch_assoc($res)) {
                  $data1[] = $row;
                }
                mysqli_free_result($res);
                mysqli_next_result($conn);
                for ($i = 0; $i < count($data1); $i++) {

                  $id = $data1[$i]['BID'];
                  $query = "select check_valid_bill($id) as total";
                  $res = mysqli_query($conn, $query);
                  $row1 = mysqli_fetch_assoc($res);
                  mysqli_free_result($res);
                  mysqli_next_result($conn);
                  $valid = '';
                  if ($row1['total'])
                    $valid = 'Valid';
                  else
                    $valid = 'In valid';
                  echo '  <tr>
                  <th scope="row">' . $data1[$i]['BID'] . '</th>
                  <td>' . $valid . '</td>
                  
                  
                  <td><form method = "Post">
                  <button type="submit" class="btn btn-primary" name="detail1[]" value = "' . $data1[$i]['BID'] . '">View details</button>   
                  </form></td>
                  </tr>  ';
                }

              }
            } catch (Exception $e) {
              $str = $e->getmessage();
              echo
                "<script>alert('.$str.')</script>";
            }



          } else {
            for ($i = 0; $i < count($data); $i++) {
              $t = $data[$i]['BID'];

              $query = "select check_valid_bill($t) as total";
              $res = mysqli_query($conn, $query);
              $row = mysqli_fetch_assoc($res);
                
              mysqli_free_result($res);
              mysqli_next_result($conn);
              $valid = '';
              if ($row['total'])
                $valid = 'Valid';
              else
                $valid = 'In valid';
              echo '  <tr>
 <th scope="row">' . $data[$i]['BID'] . '</th>
 <td>' . $valid . '</td>
 
 
 <td><form method = "Post">
 <button type="submit" class="btn btn-primary" name="details[]" value = "' . $i . '">View details</button>   
 </form></td>
 </tr>  ';

            }

          }

          // <td>'. $data[$i]['edition'] . '</td>
// <td>'. $data[$i]['PRICE'] . '</td>
// <td>'. $data[$i]['available'] . '</td>
// <td>'. $data[$i]['destroyed'] . '</td>
// <td>'. $data[$i]['lost'].'</td>
// <td>'. $data[$i]['hired'].'</td>
// <td>'.$t1.'</td>
// <td>'.$t2.'</td>
// <td>'.$t3.'</td>
          ?>
          </tbody>
        </table>
      </div>
    </div>
  </div>



</body>