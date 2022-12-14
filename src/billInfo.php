<?php
require 'config.php';
//require 'privileges.php';

//$ssn = $_SESSION["ssn"];
$bid = $_SESSION["bid"];
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

if (isset($_POST['ext'])) {
  $t = $_POST['ext'][0];
  $f = $data1[$t]['ISBN'];

  $query = "call extend_book($bid, '$f')";
  try {
    $res = mysqli_query($conn, $query);
    if (!$res)
      throw new Exception("");
    else {
      header("Refresh:0");
      echo
        "<script>alert('Extend $f successfully')</script>";
    }
  } catch (Exception $e) {
    $str = $e->getmessage();
    echo
      "<script>alert('.$str.')</script>";
  }

}
if (isset($_POST['more'])) {
  $_SESSION['ssn'] = $_POST['more'];
  header("Location: ./memberInfo.php");
}

if(isset($_POST['sub'])){
  $id = $_COOKIE['id'];
try{
  if(isset($_POST['return']))
  {
    $isbn = $_POST['return'];
    $query = "call RETURN_BOOK('$id','$isbn',$bid,'0','0')";
    $res = mysqli_query($conn, $query);  
   
  }
  if(isset($_POST['destroy'])){
    $isbn = $_POST['destroy'];
    $query = "call RETURN_BOOK('$id','$isbn',$bid,'0','1')";
    $res = mysqli_query($conn, $query); 
   
  }
  if(isset($_POST['lost'])){
    $isbn = $_POST['lost'];
    $query = "call RETURN_BOOK('$id','$isbn',$bid,'1','0')";
    $res = mysqli_query($conn, $query);
    
  }
  if (!$res)
  throw new Exception("");
  else{
    header("Refresh:0");
      echo
        "<script>alert('Return $isbn successfully')</script>";
  }
}catch (Exception $e) {
  $str = $e->getmessage();
  echo
    "<script>alert('.$str.')</script>";
}  
}

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

  <script type="text/javascript">
    function addFields() {
      var newDuedate = document.getElementById("newDuedate");
      var input = document.createElement("input");
      input.type = "date";
      var confirm = document.createElement("button");
      confirm.textContent = "confirm";
      confirm.setAttribute("class", "btn btn-primary")

      newDuedate.appendChild(input);
      newDuedate.appendChild(confirm);
    }
  </script>

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
            <li class="active">
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
          <a class="nav-link" href="./createBill.php">Create new bill</a>
        </li>
      </ul>

      <!-- Back button -->
      <button class="back-btn" onclick="history.back()">
        <a href="./manageBill.php" style="color: black;">
          <i class="fas fa-chevron-left"></i>
          Back
        </a>
      </button>

      <div class="card">
        <div class="card-body">
          <div class="wrapper">
            <h2>Bill information</h2>
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
                    <span class="a-text-bold">Member : </span>
                    <span>
                      <?php echo $row['MEMBER_SSN'];
                    echo '<form method = "Post" >
                    <button type="submit" class="btn btn-info btn-sm ml-5" name="more" value = "' . $row['MEMBER_SSN'] . '">more details</button>   
                </form>'
                      ?>
                    </span>

                  </span>
                </li>
                <li>
                  <span class="a-list-item">
                    <span class="a-text-bold">Staff : </span>
                    <span>
                      <?php echo $row['STAFF_SSN']; ?>
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
          </div>
        </div>


        <!--  -->
        <div class="card">
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
                                
                              </span>
                              <form method = "Post">
                                <button type="submit" class="btn btn-info btn-sm ml-5" name="ext[]" value = "' . $i . '">Extend </button>   
                              </form>
                            </li>
                            <li>
                              <span class="a-list-item">
                                <span class="a-text-bold">Return date : </span>
                                <span>' . $t . '</span>     
                                
                              </span>
                            </li>
                          </ol> ';
                    if($t == 'NULL'){
                    $tmp .= '<form method = "Post" class="billOption-form">
                      <div class="row">
                        <div class="form-check col-2">
                          <label class="form-check-label" for="check1">
                            <input type="checkbox" class="form-check-input" id="check1" name="return" value="' . $data1[$i]['ISBN'] . '"
                              checked>Return
                          </label>
                        </div>
                        <div class="form-check col-2">
                          <label class="form-check-label" for="check2">
                            <input type="checkbox" class="form-check-input" id="check2" name="destroy"
                              value="' . $data1[$i]['ISBN'] . '">Destroy
                          </label>
                        </div>
                        <div class="form-check col-2">
                          <label class="form-check-label">
                            <input type="checkbox" class="form-check-input" name="lost"
                            value="' . $data1[$i]['ISBN'] . '" >Lost
                          </label>
                        </div>
                      </div>
                      <button type="submit" class="btn btn-primary mt-3" name="sub">Submit</button>
                    </form>';
                    }   
                    $tmp .='   
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
  </div>
</body>

</html>