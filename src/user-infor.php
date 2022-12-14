<?php
require 'config.php';
//require 'privileges.php';

$ssn = $_COOKIE["id"];
//echo $ssn;
$query = "call find_member_detail('$ssn')";
$res = mysqli_query($conn, $query);
$row = mysqli_fetch_assoc($res);
mysqli_free_result($res);
mysqli_next_result($conn);

$query = "call find_bill_from_ssn('$ssn')";
$res = mysqli_query($conn, $query);
$data1 = array();
while ($row1 = mysqli_fetch_assoc($res)) {
  $data1[] = $row1;
}
mysqli_free_result($res);
mysqli_next_result($conn);
$sum = 0;
$query = "call FIND_PUNISH('$ssn');";

$res = mysqli_query($conn, $query);
$data3 = array();
while ($row3 = mysqli_fetch_assoc($res)) {
  $data3[] = $row3;
}
mysqli_free_result($res);
mysqli_next_result($conn);
if ($data3) {
  foreach ($data3 as $t) {
    $sum += $t['FINE'];
  }
}

if(isset($_POST['go'])){
  $_SESSION['bid'] = $_POST['go'];
  header("Location: ./billInfo.php");
}
?>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Manage member</title>
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
  <div class="mngMember">
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
            <li>
              <span>
                <i class="fas fa-clipboard-list"></i>
                Bill information
              </span>
            </li>
          </a>
          <a href="#">
            <li class="active">
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
    <div class="mngMember-container">
      <center>
        <h3 style="margin-bottom: 50px">Simple library management</h3>
      </center>



      <div class="card m-5">
        <div class="card-body">
          <div class="wrapper">
            <h2>Member information</h2>
            <div class="detailsBullet">
              <ul>
                <li>
                  <span class="a-list-item">
                    <span class="a-text-bold">Name : </span>
                    <span>
                      <?php echo $row['FULL_NAME'] ?>
                    </span>
                  </span>
                </li>
                <li>
                  <span class="a-list-item">
                    <span class="a-text-bold">SSN : </span>
                    <span>
                      <?php echo $ssn ?>
                    </span>
                  </span>
                </li>
                <li>
                  <span class="a-list-item">
                    <span class="a-text-bold">Address : </span>
                    <span>
                      <?php echo $row['ADDRESS'] ?>
                    </span>
                  </span>
                </li>
                <li>
                  <span class="a-list-item">
                    <span class="a-text-bold">Email : </span>
                    <span>
                      <?php echo $row['EMAIL'] ?>
                    </span>
                  </span>
                </li>
                <li>
                  <span class="a-list-item">
                    <span class="a-text-bold">Phone : </span>
                    <span>
                      <?php echo $row['PHONE'] ?>
                    </span>
                  </span>
                </li>
                <li>
                  <span class="a-list-item">
                    <span class="a-text-bold">Point : </span>
                    <span>
                      <?php echo $row['POINT'] ?>
                    </span>
                  </span>
                </li>
                <li>
                  <span class="a-list-item">
                    <span class="a-text-bold">Total of rented books : </span>
                    <span>
                      <?php echo $row['total_book'] ?>
                    </span>
                  </span>
                </li>
                <li>
                  <span class="a-list-item">
                    <span class="a-text-bold">Number of Borrowing Books : </span>
                    <span>
                      <?php echo $row['AMOUNT_BOOK'] ?>
                    </span>
                  </span>
                </li>
              </ul>
            </div>

          </div>

        </div>
      </div>



      <!-- Punishment -->
      <div class="card m-5">
        <div class="card-body">
          <div class="wrapper">
            <h2>Punishment history</h2>
            <span class="a-list-item">
                    <span class="a-text-bold">Total : </span>
                    <span>
                      <?php echo $sum . ' VND' ?>
                    </span>
                  </span>
                  <table class="table">
                    <thead>
                      <tr>
                        <th scope="col">#</th>
                        <th scope="col">Bill ID</th>
                        <th scope="col">ISBN</th>
                        <th scope="col">Punish date</th>
                        <th scope="col">Fine</th>
                        <th scope="col">Type</th>
                      </tr>
                    </thead>
                    <tbody>
                      <?php
                      if ($data3) {

                        $tmp = $type = "";

                        for ($i = 0; $i < count($data3); $i++) {
                          if ($data3[$i]['IS_LOST'])
                            $type = 'Lost';
                          else if ($data3[$i]['IS_DESTROY'])
                            $type = 'Destroyed';
                          else
                            $type = 'Late';

                          $tmp .= '<tr>
                      <th scope="row">' . ($i + 1) . '</th>
                      <td>' . $data3[$i]['BID'] . '</td>
                      <td>' . $data3[$i]['ISBN'] . '</td>
                      <td>' . $data3[$i]['PUNISH_DATE'] . '</td>
                      <td>' . $data3[$i]['FINE'] . '</td>
                      <td>' . $type . '</td>
                      
                    </tr>';
                          $sum += $data3[$i]['FINE'];
                        }
                        echo $tmp;
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