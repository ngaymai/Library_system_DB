<?php
require 'config.php';
// require 'privileges.php';
$query1 = "call top_book()";
$query2 = "call top_member()";

?>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Dashboard</title>
  <link rel="stylesheet" href="../static/styles.css">
  <link rel="stylesheet" href="//use.fontawesome.com/releases/v5.15.4/css/all.css">
  <!-- Latest compiled and minified CSS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="../static/styles.css">

  <!-- jQuery library -->
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>

  <!-- Popper JS -->
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

  <!-- Latest compiled JavaScript -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>


</head>


<body>

  <div class="dashboard">
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
            <li class="active">
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

    <div class="dashboard-container">
      <center>
        <h3 style="margin-bottom: 50px">Simple library management</h3>
      </center>


      <div class="welcome">
        <h5><?php echo $_COOKIE['id']; ?></h5>
      </div>


     <!-- Top 5 book -->
     <div class="top5-book">
        <h6><b>Top 5 most rented books</b></h6>
        <table class="table table-bordered table-striped">
          <thead>
            <tr>
              <th>ISBN</th>
              <th>Title</th>
              <th>Times</th>
            </tr>
          </thead>
          <tbody id="myTable">
            <?php
            try {
              $res = mysqli_query($conn, $query1);

              if (!$res)
                throw new Exception("");
              else {
                $data = array();
                while ($row = mysqli_fetch_assoc($res)) {
                  $data[] = $row;
                }
                mysqli_free_result($res);
                mysqli_next_result($conn);
                if ($data) {
                  $tmp = "";
                  foreach ($data as $i) {
                    $tmp .= '<tr>
                    <td>' . $i['ISBN'] . '</td>
                    <td>' . $i['title'] . '</td>
                    <td>' . $i['times'] . '</td>
                  </tr>';
                  }
                  echo $tmp;
                }
              }
            } catch (Exception $e) {
              $str = $e->getmessage();
              echo
                "<script>alert('.$str.')</script>";
            }
            ?>

          </tbody>
        </table>

        <!-- Top 5 member -->

      </div>
      <!-- Top 5 book -->
      <div class="top5-book">
        <h6><b>Top 5 most member</b></h6>
        <table class="table table-bordered table-striped">
          <thead>

            <tr>
              <th>SSN</th>
              <th>Full name</th>
              <th>Times</th>
            </tr>
          </thead>
          <tbody id="myTable">
            <?php
          try {
            $res = mysqli_query($conn, $query2);

            if (!$res)
              throw new Exception("");
            else {
              $data = array();
              while ($row = mysqli_fetch_assoc($res)) {
                $data[] = $row;
              }
              mysqli_free_result($res);
mysqli_next_result($conn);
              if ($data) {
                $tmp = "";
                foreach ($data as $i) {
                  $tmp .= '<tr>
                    <td>' . $i['SSN'] . '</td>
                    <td>' . $i['FULL_NAME'] . '</td>
                    <td>' . $i['times'] . '</td>
                  </tr>';
                }
                echo $tmp;
              }
            }
          } catch (Exception $e) {
            $str = $e->getmessage();
            echo
              "<script>alert('.$str.')</script>";
          }
          ?>
          </tbody>
        </table>
      </div>

</body>