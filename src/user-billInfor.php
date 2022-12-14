<?php
require 'config.php';
//require 'privileges.php';

//$ssn = $_SESSION["ssn"];
$bid = $_GET["bid"];
$query = "call find_bill_from_bid($bid)";
$res = mysqli_query($conn, $query);
$row = mysqli_fetch_assoc($res);
mysqli_free_result($res);
mysqli_next_result($conn);
$query = "call bill_detail($bid)";
$res = mysqli_query($conn, $query);
$data1 = array();
while ($row1 = mysqli_fetch_assoc($res)) {
  $data1[] = $row1;
}
mysqli_free_result($res);
mysqli_next_result($conn);
$query = "select check_valid_bill($bid) as total";
$res1 = mysqli_query($conn, $query);
$tmp = mysqli_fetch_array($res1, 1);
mysqli_free_result($res1);
mysqli_next_result($conn);
$state = "";
if ($tmp['total'])
  $state = 'Valid';
else
  $state = 'Invalid';

if (isset($_GET['isbn'])) {
  $f = $_GET['isbn'];
  $query = "call extend_book($bid, '$f')";
  try {
    $res = mysqli_query($conn, $query);
    if (!$res)
      throw new Exception("");
    else {
      //header("Refresh:0");
      echo
        "<script>alert('Extend $f successfully')</script>";
    }
  } catch (Exception $e) {
    $str = $e->getmessage();
    echo
      "<script>alert('.$str.')</script>";
  }

}


if (isset($_POST['sub'])) {
  $id = $_COOKIE['id'];

}

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

      <!-- Back button -->
      <button class="back-btn fas fa-chevron-left" style="color: black;" onclick="history.back()">        
          Back        
      </button>


      <div class="detailsBullet">
        <ul>
          <li>
            <span class="a-list-item">
              <span class="a-text-bold">Bill ID : </span>
              <span>
                <?php echo $row['BID']; ?>
              </span>
            </span>
          </li>
          <li>
            <span class="a-list-item">
              <span class="a-text-bold">Start date : </span>
              <span>
                <?php echo $row['start_date']; ?>
              </span>
            </span>
          </li>

          <li>
            <span class="a-list-item">
              <span class="a-text-bold">Status : </span>
              <span>
                <?php echo $state; ?>
              </span>
            </span>
          </li>
        </ul>
      </div>

      <div class="card m-4">
        <div class="card-body">
          <h3>Book List</h3>
          <div id="accordion">
            <?php
            if ($data1) {
              $tmp = "";
              for ($i = 0; $i < count($data1); $i++) {
                $is = $data1[$i]['ISBN'];
                $query = "call find_book('$is')";
                $res = mysqli_query($conn, $query);
                $row2 = mysqli_fetch_assoc($res);
                mysqli_free_result($res);
                mysqli_next_result($conn);
                $t = "";
                if ($data1[$i]['RETURN_DATE']) {
                  $t = $data1[$i]['RETURN_DATE'];
                } else
                  $t = 'NULL';
                $tmp .= '<div class="card">
                      <div class="card-header" id="headingOne">
                        <h5 class="mb-0">
                          <button class="btn btn-link" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true"
                            aria-controls="collapseOne">
                            #' . ($i + 1) . ' ' . $row2['title'] . '      
                          </button>
                        </h5>
                      </div>
      
                      <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordion">
                        <div class="card-body">
                          <ol>
                            <li>
                              <span class="a-list-item">
                                <span class="a-text-bold">Book ID : </span>
                                <span>' . $data1[$i]['ISBN'] . '</span>
                              </span>
                            </li>                                                        
                            <li class="row">
                              <span class="a-list-item col-5 ">
                                <span class="a-text-bold ">Due date : </span>
                                <span class="col-3">' . $data1[$i]['DUE_DATE'] . '
                                </span>
                                <a href="./user-billInfor.php?bid='.$bid.'&isbn=' . $data1[$i]['ISBN'] . '" class="btn btn-info btn-sm ml-5" id="filldetails">Extend</a>
                              </span>                              
                            </li>
                            <li>
                              <span class="a-list-item">
                                <span class="a-text-bold">Return date : </span>
                                <span>' . $t . '</span>     
                                
                              </span>
                            </li>
                          </ol> 
                       
                        </div>
                      </div>
                    </div>';

              }
              echo $tmp;
            }
            ?>

          </div>
        </div>

      </div>



    </div>
  </div>  
</body>



</html>