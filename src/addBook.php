<?php
require 'config.php';
//require 'privileges.php';
if (isset($_POST["submit"])) {
  $isbn = $_POST["isbn"];
  $title = $_POST["title"];
  $author = $_POST["author"];
  $edition = $_POST["edition"];
  $price = $_POST["price"];
  $subArea = $_POST["subArea"];
  $language = $_POST["language"];
  $query = "select isbn from book where ISBN = $isbn";
  $res = mysqli_query($conn, $query);
  $row = mysqli_fetch_assoc($res);
  $authorlist = explode(",", $author);
  $languagelist = explode(",", $language);
  $subArealist = explode(",", $subArea);
  if (mysqli_num_rows($res) > 0) {
    echo
      "<script>alert('The book $isbn has exist')</script>";
  } else {
    if (isset($_POST["hired"])) {
      $query = "call insert_book('$isbn','$title','$edition','$price', '1')";
      // $out = mysqli_query($conn, $query);      
    } else {
      $query = "call insert_book('$isbn','$title','$edition','$price', '0')";
      //$out = mysqli_query($conn, $query);
    }

    try {
      $res = mysqli_query($conn, $query);
      if (!$res)
        throw new Exception("");
       // mysqli_free_result($res);
       // mysqli_next_result($conn); 
    } catch (Exception $e) {
      $str = $e->getmessage();
      echo
        "<script>alert('.$str.')</script>";
    }
    foreach ($authorlist as $a) {
      $query = "call insert_author('$isbn','$a')";
      try {
        $res = mysqli_query($conn, $query);
        if (!$res)
          throw new Exception("");
  
      } catch (Exception $e) {
        $str = $e->getmessage();
        echo
          "<script>alert('.$str.')</script>";
      }
      
    }

    foreach ($languagelist as $a) {
      $query = "call insert_lang('$isbn','$a')";
      mysqli_query($conn, $query);
    }

    foreach ($subArealist as $a) {
      $query = "call insert_subj('$isbn','$a')";
      mysqli_query($conn, $query);
    }
    echo
      "<script>alert('Insert book successfully')</script>";      
  }

}
?>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Insert book</title>
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




  <div class="addbook">
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
            <li class="active">
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


    <div class="addbook-container">
      <center>
        <h3 style="margin-bottom: 50px">Simple library management</h3>
      </center>

      <ul class="nav nav-tabs">
        <li class="nav-item">
          <a class="nav-link" aria-current="page" href="./manageBook.php">Management</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" href="#">Insertion</a>
        </li>
      </ul>

      <form class="addbook-form card-body" method="Post" action="">
        <div class="form-group row">
          <label for="inputISBN" class="col-sm-2 col-form-label">Enter ISBN</label>
          <div class="col-sm-10">
            <input type="text" class="form-control" id="inputISBN" name="isbn">
          </div>
        </div>
        <div class="form-group row">
          <label for="inputTitle" class="col-sm-2 col-form-label">Enter title</label>
          <div class="col-sm-10">
            <input type="text" class="form-control" id="inputTitle" name="title">
          </div>
        </div>
        <div class="form-group row">
          <label for="inputAuthor" class="col-sm-2 col-form-label">Enter author</label>
          <div class="col-sm-10">
            <input type="text" class="form-control" id="inputAuthor" name="author">
          </div>
        </div>
        <div class="form-group row">
          <label for="inputEdition" class="col-sm-2 col-form-label">Enter edition</label>
          <div class="col-sm-10">
            <input type="text" class="form-control" id="inputEdition" name="edition">
          </div>
        </div>
        <div class="form-group row">
          <label for="inputlanguage" class="col-sm-2 col-form-label">Enter language</label>
          <div class="col-sm-10">
            <input type="text" class="form-control" id="inputlanguage" name="language">
          </div>
        </div>
        <div class="form-group row">
          <label for="inputPrice" class="col-sm-2 col-form-label">Enter price</label>
          <div class="col-sm-10">
            <input type="text" class="form-control" id="inputPrice" name="price">
          </div>
        </div>
        <div class="form-group row">
          <label for="inputSubArea" class="col-sm-2 col-form-label">Enter Subject area</label>
          <div class="col-sm-10">
            <input type="text" class="form-control" id="inputSubArea" name="subArea">
          </div>
        </div>
        <div class="form-check">
          <input class="form-check-input" type="radio" name="hired" id="flexRadioDefault1">
          <label class="form-check-label" for="flexRadioDefault1">
            hired?
          </label>
        </div>
        <center>

          <button type="submit" class="btn btn-primary" name="submit">Submit</button>
          <input class="btn btn-primary" type="reset" value="Reset">
        </center>
      </form>
    </div>
  </div>

</body>