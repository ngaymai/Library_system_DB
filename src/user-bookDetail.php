<?php
require 'config.php';
//require 'privileges.php';

$isbn = $_GET['isbn'];
$query = "call find_book('$isbn')";
$res = mysqli_query($conn, $query);

$row = mysqli_fetch_assoc($res);
mysqli_free_result($res);
mysqli_next_result($conn);

$query3 = "call find_author('$isbn')";
$query1 = "call find_language('$isbn')";
$query2 = "call find_subject('$isbn')";
$res1 = mysqli_query($conn,$query1);



$ar1=$ar2=$ar3=[];
$tmp1 = $tmp2 = $tmp3 = "";
while($row1 = mysqli_fetch_array($res1)){

  if($tmp1 == "")
  {
    $tmp1 =  $row1[0]; 
  } else
    $tmp1 = $tmp1 . ', ' . $row1[0];
}
//$t1 = implode(",",$ar1);
mysqli_free_result($res1);
mysqli_next_result($conn);
$res2 = mysqli_query($conn,$query2);
while($row2 = mysqli_fetch_array($res2)){
  // $tmp =  implode(',',$row2); 
  // $ar2[] = $tmp; 
  if($tmp2 == "")  
    $tmp2 =  $row2[0]; 
   else
    $tmp2 = $tmp2 . ', ' . $row2[0];
}
//$t2 = implode(",",$ar2);
mysqli_free_result($res2);
mysqli_next_result($conn);
$res3 = mysqli_query($conn,$query3);
while($row3 = mysqli_fetch_array($res3)){
  if($tmp3 == "")  
  $tmp3 =  $row3[0]; 
 else
  $tmp3 = $tmp3 . ', ' . $row3[0];
}      
mysqli_free_result($res3);
mysqli_next_result($conn);
?>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Book detail</title>
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
  <div class="bookDetail">
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
          <a href="#">
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
            <li class="active">
              <span>
                <i class="fas fa-book"></i>
                Book library
              </span>
            </li>
          </a>

          <!-- <a href="./createBill.php">
            <li>
              <span>Create bill</span>
            </li>
          </a> -->
          <a href="./user-bill.php">
            <li>
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
    <!-- End sidebar -->
    <!-- Container -->
    <div class="bookDetail-container">
      <center>
        <h3 style="margin-bottom: 50px">Simple library management</h3>
      </center>



      <!-- Back button -->
      <button class="back-btn" onclick="history.back()">
        <a style="color: black;">
          <i class="fas fa-chevron-left"></i>
          Back
        </a>
      </button>


      <!-- Product detail -->
      <div class="card">
        <div class="card-body">
          <div class="wrapper">
            <h2>Book detail information</h2>
            <!-- <div class="detailsBullet">
              <ul>
                <li><span class="a-list-item"><span class="a-text-bold">ISBN : </span><span>123</span></span></li>
                <li><span class="a-list-item"><span class="a-text-bold">Title : </span><span>Calculus 2</span></span>
                </li>
                <li><span class="a-list-item"><span class="a-text-bold">Edition : </span><span>1</span></span></li>
                <li><span class="a-list-item"><span class="a-text-bold">Price : </span><span>200.000</span></span></li>
                <li><span class="a-list-item"><span class="a-text-bold">Language : </span><span>VN, USA,
                      ENG</span></span>
                </li>
                <li>
                  <span class="a-list-item">
                    <span class="a-text-bold">Subject : </span>
                    <span> Chemistry, ...</span>
                  </span>
                </li>
                <li>
                  <span class="a-list-item">
                    <span class="a-text-bold">Author : </span>
                    <span>
                      Nguyen Van A, fsjdfij, fdfj
                    </span>
                  </span>
                </li>
                <li>
                  <span class="a-list-item">
                    <span class="a-text-bold">Publication : </span>
                    <span>
                      Nha xuat ban Ha
                    </span>
                  </span>
                </li>
                <li>
                  <span class="a-list-item">
                    <span class="a-text-bold">Status : </span>
                    <span>
                      Borrowing
                    </span>
                  </span>
                </li>
                <li>
                  <span class="a-list-item">
                    <span class="a-text-bold">Being borrowed by : </span>
                    <span>
                      Nguyen Van B
                    </span>
                  </span>
                </li>
                <li>
                  <span class="a-list-item">
                    <span class="a-text-bold">Number of copies: </span>
                    <span>
                      20
                    </span>
                  </span>
                </li>
              </ul>
            </div> -->
            <div class="detailsBullet">
          <ul>
            <li><span class="a-list-item"><span class="a-text-bold">ISBN : </span><span><?php echo $row['ISBN'] ?></span></span></li>
            <li><span class="a-list-item"><span class="a-text-bold">Title : </span><span><?php echo $row['title'] ?></span></span></li>
            <li><span class="a-list-item"><span class="a-text-bold">Edition : </span><span><?php echo $row['edition'] ?></span></span></li>
            <li><span class="a-list-item"><span class="a-text-bold">Price : </span><span><?php echo $row['PRICE'] ?></span></span></li>
            <li><span class="a-list-item"><span class="a-text-bold">Language : </span><span><?php echo $tmp1 ?></span></span>
            </li>
            <li>
              <span class="a-list-item">
                <span class="a-text-bold">Subject : </span>
                <span> <?php echo $tmp2 ?></span>
              </span>
            </li>
            <li>
              <span class="a-list-item">
                <span class="a-text-bold">Author : </span>
                <span>
                <?php echo $tmp3 ?>
                </span>
              </span>
            </li>
            <!-- <li>
              <span class="a-list-item">
                <span class="a-text-bold">Publication : </span>
                <span>
                  Nha xuat ban Ha
                </span>
              </span>
            </li> -->
            <li>
              <span class="a-list-item">
                <span class="a-text-bold">Status :                
                </span>
                <span>
                <?php
                $st = ""; 
                if($row['available']){
                  $st ='Available';
                }
                else{
                  $st = 'Not Available';
                }
                if($row['destroyed']){
                  
                  $st = $st .', destroyed';
                }
                if($row['lost']){
                  $st = $st . ', lost';
                }
                if($row['hired']){
                  $st = $st . ', hired';
                }

                echo $st;
                 ?>
                </span>
              </span>
            </li>
          </ul>
        </div>
          </div>
        </div>
      </div>





    </div> <!-- End container -->

  </div> <!-- End BookDetail -->
</body>