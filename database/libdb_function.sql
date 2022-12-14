-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 13, 2022 at 04:10 PM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `libdb`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `BILL_DETAIL` (IN `S` INT(9))   BEGIN
SELECT * FROM BILL A, book_rental B
WHERE A.BID = S AND A.BID = B.BID; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `check_account` (IN `$email` VARCHAR(255), `$phone` VARCHAR(12), `$username` VARCHAR(255))   BEGIN
select * from account 
      where email = $email or phone = $phone or username = $username;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_bill` (IN `$bid` INT(9))   BEGIN
delete from valid_bill where bid =  $bid;
delete from bill where bid =  $bid; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `extend_book` (IN `$bid` INT(9), `$isbn` VARCHAR(13))   BEGIN
update book_rental 
set due_date = ADDDATE(DUE_DATE, 15 )
where isbn = $isbn and bid = $bid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `find_account` (IN `S` VARCHAR(255))   BEGIN
select * from account 
      where username = S; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `find_author` (IN `$isbn` VARCHAR(13))   BEGIN
SELECT AUTHOR_NAME FROM author WHERE ISBN = $isbn;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `FIND_BILL` (IN `S` CHAR(10))   BEGIN
SELECT A.BID, A.start_date FROM BILL A, valid_bill B
WHERE A.MEMBER_SSN = S AND A.BID = B.BID; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `find_bill_from_bid` (IN `$bid` INT(9))   BEGIN
select * from bill where BID = $bid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `find_bill_from_ssn` (IN `$ssn` CHAR(10))   BEGIN
select * from bill where member_ssn = $ssn;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `find_book` (IN `$isbn` VARCHAR(13))   BEGIN
select * from book where ISBN = $isbn;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `find_language` (IN `$isbn` VARCHAR(13))   BEGIN
SELECT language FROM language WHERE ISBN = $isbn;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `find_member_detail` (IN `$ssn` CHAR(10))   BEGIN
select * from account A, member B where A.SSN = $ssn and A.SSN = B.SSN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `FIND_PUNISH` (IN `S` CHAR(10))   BEGIN
SELECT * FROM (SELECT B.* FROM BILL A, book_rental B
WHERE (A.MEMBER_SSN = S AND A.BID = B.BID)) TMP WHERE TMP.PUNISH_DATE IS NOT NULL; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `find_subject` (IN `$isbn` VARCHAR(13))   BEGIN
SELECT subject FROM subject_area WHERE ISBN = $isbn;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_account` (IN `$email` VARCHAR(255), `$password` VARCHAR(50), `$fullname` VARCHAR(255), `$address` VARCHAR(255), `$phone` VARCHAR(12), `$username` VARCHAR(255), `$staff` INT(1))   BEGIN
IF $staff = 1 THEN
INSERT INTO ACCOUNT (EMAIL, PASSWORD , FULL_NAME, ADDRESS, PHONE, username, is_staff) 
          VALUES ($email,$password,$fullname,$address,$phone,$username,'1');
ELSE
INSERT INTO ACCOUNT (EMAIL, PASSWORD , FULL_NAME, ADDRESS, PHONE, username) 
          VALUES ($email,$password,$fullname,$address,$phone, $username);
end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_author` (IN `$isbn` VARCHAR(13), `$au` VARCHAR(255))   BEGIN
insert into author(isbn, author_name)
      values($isbn,$au);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_bill` (IN `ssns` CHAR(10), `ssnm` CHAR(10))   BEGIN
insert into bill(staff_ssn, member_ssn)
  values(ssns,ssnm);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_book` (IN `$isbn` VARCHAR(13), `$title` VARCHAR(255), `$edition` INT(11), `$price` DECIMAL(10,2), `$hired` INT(1))   BEGIN
if $hired = 1 then 
insert into book(isbn, title, edition, price)
      values($isbn,$title,$edition,$price);
ELSE
insert into book(isbn, title, edition, price, hired)
      values($isbn,$title,$edition,$price, 0);
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_book_rental` (IN `$bid` INT(9), `$isbn` VARCHAR(13))   BEGIN
insert into book_rental(bid, isbn)
  values($bid,$isbn);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_lang` (IN `$isbn` VARCHAR(13), `$lang` VARCHAR(50))   BEGIN
insert into language(isbn, language)
      values($isbn,$lang);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_subj` (IN `$isbn` VARCHAR(13), `$subj` VARCHAR(255))   BEGIN
insert into subject_area(isbn, subject)
      values($isbn,$subj);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `IS_BORROWING` (IN `S` CHAR(10))   BEGIN
SELECT R.ISBN FROM book_rental R, (SELECT B.BID AS ID FROM BILL B, valid_bill R
WHERE B.BID = R.BID AND B.MEMBER_SSN = S) T
WHERE R.BID = T.ID AND R.RETURN_DATE IS NULL;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LATE_BOOK` (IN `S` CHAR(10), OUT `c` INT)   BEGIN 
CREATE TEMPORARY TABLE TAB(ISBN INT);
INSERT INTO TAB(ISBN)
SELECT R.ISBN FROM book_rental R, (SELECT B.BID AS ID FROM BILL B, valid_bill R
WHERE B.BID = R.BID AND B.MEMBER_SSN = S) T
WHERE R.BID = T.ID AND R.RETURN_DATE IS NULL AND R.DUE_DATE < CURRENT_DATE();
SET C = (SELECT COUNT(*) FROM TAB);
SELECT * FROM TAB;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `list_bill` ()   BEGIN
SELECT * FROM bill;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `list_book` ()   BEGIN
SELECT * FROM book;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `list_member` ()   BEGIN
select * from account where ssn like 'M%';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `RETURN_BOOK` (IN `S` CHAR(10), IN `I` VARCHAR(13), IN `B` INT, IN `L` BOOLEAN, IN `D` BOOLEAN)   BEGIN
DECLARE $D DATE;
SELECT DUE_DATE INTO $D FROM book_rental
WHERE ISBN = I AND BID = B; 
IF D = 1 THEN
UPDATE book_rental SET RETURN_DATE = CURRENT_DATE(), PUNISH_DATE = CURRENT_DATE(), FINE = FIND_PRICE(I), IS_DESTROY = 1, STAFF_SSN = S
WHERE ISBN = I AND BID = B;
ELSEIF L = 1 THEN 
UPDATE book_rental SET RETURN_DATE = CURRENT_DATE(), PUNISH_DATE = CURRENT_DATE(), FINE = FIND_PRICE(I), IS_LOST = 1, STAFF_SSN = S
WHERE ISBN = I AND BID = B;
ELSEIF $D < CURRENT_DATE() THEN
UPDATE book_rental SET RETURN_DATE = CURRENT_DATE(), PUNISH_DATE = CURRENT_DATE(), FINE = 50*FIND_PRICE(I), STAFF_SSN = S
WHERE ISBN = I AND BID = B;
ELSE 
UPDATE book_rental SET RETURN_DATE = CURRENT_DATE(), STAFF_SSN = S, RETURN_DEPOSIT = 1
WHERE ISBN = I AND BID = B;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `search_bill` (IN `temp` INT)   BEGIN
select * from bill where bid like concat('%',temp,'%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `search_book` (IN `temp` INT)   BEGIN
select * from book where isbn like concat('%',temp,'%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `search_member` (IN `temp` VARCHAR(10))   BEGIN
select * from account where ssn like concat('M%',temp,'%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `top_book` ()   BEGIN
SELECT count(A.BID) as times, A.ISBN, B.title from book_rental A, book B
 WHERE A.ISBN = B.ISBN
 GROUP BY isbn
ORDER BY times DESC LIMIT  5;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `top_member` ()   BEGIN
SELECT A.SSN, A.FULL_NAME, COUNT(B.ISBN) as times from account A, book_rental B, bill C
 WHERE A.SSN = C.MEMBER_SSN AND B.BID = C.BID
 GROUP BY isbn
 ORDER BY times DESC LIMIT  5;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `CHECK_BILL` (`TEMP` INT) RETURNS INT(11)  BEGIN
DECLARE $RES INT;
SELECT COUNT(ISBN) INTO $RES FROM book_rental
WHERE BID = TEMP AND RETURN_DATE IS NULL;
RETURN $RES;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `check_valid_bill` (`$bid` INT(13)) RETURNS INT(11)  BEGIN
DECLARE RES INT;
set RES = 0; 
SELECT count(*)
into RES
FROM valid_bill a
WHERE BID = $bid;
RETURN RES;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `FIND_LATE` (`S` CHAR(10)) RETURNS INT(11)  BEGIN
DECLARE $RES INT;
SELECT COUNT(R.ISBN) INTO $RES FROM book_rental R, (SELECT B.BID AS ID FROM BILL B, valid_bill R
WHERE B.BID = R.BID AND B.MEMBER_SSN = S) T
WHERE R.BID = T.ID AND R.RETURN_DATE IS NULL AND R.DUE_DATE < CURRENT_DATE();
RETURN $RES;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `FIND_PRICE` (`S` VARCHAR(13)) RETURNS DECIMAL(10,2)  BEGIN
DECLARE RES DECIMAL(10,2);
SELECT B.price INTO RES
FROM BOOK B 
WHERE B.ISBN = S; 
RETURN RES;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

CREATE TABLE `account` (
  `SSN` char(10) NOT NULL,
  `USERNAME` varchar(255) NOT NULL,
  `EMAIL` varchar(255) NOT NULL,
  `PASSWORD` varchar(50) NOT NULL,
  `FULL_NAME` varchar(255) NOT NULL,
  `ADDRESS` varchar(255) NOT NULL,
  `PHONE` varchar(12) NOT NULL,
  `IS_STAFF` tinyint(1) DEFAULT 0,
  `create_date` date DEFAULT curdate()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `account`
--

INSERT INTO `account` (`SSN`, `USERNAME`, `EMAIL`, `PASSWORD`, `FULL_NAME`, `ADDRESS`, `PHONE`, `IS_STAFF`, `create_date`) VALUES
('M000000001', 'bbb', 'nvb123@gmail.com', 'bbb123', 'Nguyen Van B', 'BBB', '222222', 0, '2022-12-07'),
('M000000002', 'nvd', 'nvd@gmail.com', 'nnvd123', 'Nguyen Van D', 'DDD', '444444', 0, '2022-12-07'),
('M000000003', 'nvf', 'nvf@gmail.com', 'nvf123', 'Nguyen Van F', 'FFF', '666666', 0, '2022-12-07'),
('M000000004', 'nvg', 'nvg@gmail.com', 'nvg123', 'Nguyen Van G', 'GGG', '777777', 0, '2022-12-07'),
('M000000005', 'nvh', 'nvh@gmail.com', 'nvh123', 'Nguyen Van H', 'HHH', '101010', 0, '2022-12-07'),
('M000000006', 'nvj', 'nvj@gmail.com', 'nvj123', 'Nguyen Van J', 'JJJ', '232323', 0, '2022-12-08'),
('M000000007', 'nvfi', 'nvfi@gmail.com', 'nvfi123', 'Nguyen Van Fi', 'fififi', '888888', 0, '2022-12-08'),
('M000000008', 'thk', 'thk@gmail.com', 'thk123', 'Truong Hai K', 'hkhk', '676767', 0, '2022-12-12'),
('S000000001', 'aaa', 'nva123@gmail.com', 'aaa123', 'Nguyen Van A', 'AAA', '111111', 1, '2022-12-07'),
('S000000002', 'nvc', 'nvc@gmail.com', 'nvc123', 'Nguyen Van C', 'CCC', '333333', 1, '2022-12-07'),
('S000000003', 'nve', 'nve@gmail.com', 'nve123', 'Nguyen Van E', 'EEE', '555555', 1, '2022-12-07'),
('S000000004', 'nvt', 'nvt@gmail.com', 'nvt123', 'Nguyen Van T', 'ttt', '331122', 1, '2022-12-08');

--
-- Triggers `account`
--
DELIMITER $$
CREATE TRIGGER `INSERT_SSN` AFTER INSERT ON `account` FOR EACH ROW BEGIN
IF NEW.SSN LIKE 'S%' THEN
INSERT INTO staff(SSN)
VALUES(NEW.SSN);
ELSEIF NEW.SSN LIKE 'M%' THEN
INSERT INTO member(SSN)
VALUES(NEW.SSN);
END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `TRIGGER_SSN` BEFORE INSERT ON `account` FOR EACH ROW BEGIN
SET @ID = 1000000000;
SET @TMP1 = (SELECT COUNT(SSN) FROM ACCOUNT WHERE(SSN LIKE 'S%'));
SET @TMP2 = (SELECT COUNT(SSN) FROM ACCOUNT WHERE SSN LIKE 'M%');
IF NEW.IS_STAFF = 1 THEN
SET @ID = @ID + @TMP1 + 1;
SET @STR = CONVERT(@ID, CHAR);
SET NEW.SSN = CONCAT('S',SUBSTRING(@STR,2));
ELSE 
SET @ID = @ID + @TMP2 + 1;
SET @STR = CONVERT(@ID, CHAR);
SET NEW.SSN = CONCAT('M',SUBSTRING(@STR,2));
END IF; 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `author`
--

CREATE TABLE `author` (
  `ISBN` varchar(13) NOT NULL,
  `author_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `author`
--

INSERT INTO `author` (`ISBN`, `author_name`) VALUES
('0001', ' Do Van C'),
('0001', ' Truong Thi B'),
('0001', 'Hoang Thi A'),
('0002', ' Do Van F'),
('0002', 'Truong Thi E'),
('0003', ' Do Van C'),
('0003', ' Truong Thi Y'),
('0003', 'Hoang Thi R'),
('0004', ' Do Van P'),
('0004', ' Truong Thi B'),
('0004', 'Hoang Thi H'),
('0005', ' Do Van C'),
('0005', ' Truong Thi Y'),
('0005', 'Hoang Thi R'),
('0006', ' Do Van CO'),
('0006', ' Truong Thi K'),
('0006', 'Hoang Thi R'),
('0007', ' Do Van C'),
('0007', ' Truong Thi Y'),
('0007', 'Hoang Thi R'),
('0008', ' Do Van C'),
('0008', ' Truong Thi Y'),
('0008', 'Hoang Thi R'),
('0009', ' Do Van C'),
('0009', ' Truong Thi Y'),
('0009', 'Hoang Thi R'),
('0010', ' Do Van C'),
('0010', ' Truong Thi Y'),
('0010', 'Hoang Thi R'),
('0011', 'NGUYEN THI L'),
('0012', ' Do Van K'),
('0012', ' Truong Thi Z'),
('0012', 'Hoang Thi I'),
('0012', 'NGUYEN THI K'),
('0013', ' Ha Van T'),
('0013', ' Nguyen Trong N'),
('0013', 'Truong Hai I');

-- --------------------------------------------------------

--
-- Table structure for table `bill`
--

CREATE TABLE `bill` (
  `BID` int(9) NOT NULL,
  `STAFF_SSN` char(10) NOT NULL,
  `MEMBER_SSN` char(10) NOT NULL,
  `start_date` date DEFAULT curdate()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bill`
--

INSERT INTO `bill` (`BID`, `STAFF_SSN`, `MEMBER_SSN`, `start_date`) VALUES
(58, 'S000000001', 'M000000001', '2022-12-07'),
(69, 'S000000001', 'M000000002', '2022-12-07'),
(75, 'S000000002', 'M000000001', '2022-08-30'),
(76, 'S000000002', 'M000000003', '2022-08-30'),
(77, 'S000000002', 'M000000005', '2022-12-08'),
(78, 'S000000001', 'M000000005', '2022-12-08'),
(79, 'S000000001', 'M000000006', '2022-12-08'),
(80, 'S000000001', 'M000000007', '2022-12-08'),
(88, 'S000000001', 'M000000007', '2022-12-11'),
(89, 'S000000002', 'M000000008', '2022-12-12');

--
-- Triggers `bill`
--
DELIMITER $$
CREATE TRIGGER `check_member` BEFORE INSERT ON `bill` FOR EACH ROW BEGIN
DECLARE $POINT INT;
DECLARE $MSG VARCHAR(128);
DECLARE $BOOK INT;
DECLARE $TOTAL INT;
DECLARE $COUNT INT;
SET $COUNT = FIND_LATE(NEW.MEMBER_SSN);
SET $POINT = (SELECT POINT FROM MEMBER 
              WHERE(SSN = NEW.MEMBER_SSN));
SET $BOOK = (SELECT AMOUNT_BOOK FROM MEMBER 
             WHERE(SSN = NEW.MEMBER_SSN));
SET $TOTAL = (SELECT TOTAL_BOOK FROM MEMBER 
             WHERE(SSN = NEW.MEMBER_SSN));
IF $COUNT > 0 THEN 
set $msg = concat('ERROR: THE MEMBER ', cast(new.MEMBER_SSN as char), ' IS NOT ALLOW TO BORROWING');
signal sqlstate '45000' set message_text = $msg;
END IF;
IF $POINT = 0 THEN
set $msg = concat('MyTriggerError: THE POINT OF THE MEMBER ', cast(new.MEMBER_SSN as char), ' IS 0');
signal sqlstate '45000' set message_text = $msg;
END IF;
IF $BOOK = $TOTAL THEN
set $msg = concat('MyTriggerError: THE NUMBER OF BORROWING BOOK OF THE MEMBER ', cast(new.MEMBER_SSN as char), ' IS FULL');
signal sqlstate '45000' set message_text = $msg;
END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_validbill` AFTER INSERT ON `bill` FOR EACH ROW BEGIN
INSERT INTO valid_bill(BID, NOTICE_DATE)
VALUES(NEW.BID, ADDDATE(NEW.START_DATE,23));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `book`
--

CREATE TABLE `book` (
  `ISBN` varchar(13) NOT NULL,
  `title` varchar(255) NOT NULL,
  `edition` int(11) DEFAULT NULL,
  `PRICE` decimal(10,2) DEFAULT NULL,
  `available` tinyint(1) DEFAULT 1,
  `destroyed` tinyint(1) DEFAULT 0,
  `lost` tinyint(1) DEFAULT 0,
  `hired` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `book`
--

INSERT INTO `book` (`ISBN`, `title`, `edition`, `PRICE`, `available`, `destroyed`, `lost`, `hired`) VALUES
('0001', 'AAA', 1, '200000.00', 0, 0, 0, 1),
('0002', 'BBBB', 2, '300000.00', 1, 1, 0, 1),
('0003', 'CCC', 2, '400000.00', 0, 0, 0, 1),
('0004', 'DDD', 2, '500000.00', 0, 0, 1, 1),
('0005', 'EEE', 3, '1000000.00', 1, 0, 0, 0),
('0006', 'FFFF', 4, '2000000.00', 1, 0, 0, 0),
('0007', 'aaaa', 2, '200000.00', 1, 0, 0, 1),
('0008', 'rrrr', 2, '200000.00', 0, 0, 1, 1),
('0009', 'uyuy', 1, '300000.00', 1, 0, 0, 1),
('0010', 'yyyy', 4, '200000.00', 1, 0, 0, 1),
('0011', 'ererer', 2, '200000.00', 0, 0, 0, 1),
('0012', 'auauau', 4, '3000000.00', 0, 0, 0, 1),
('0013', 'newtest', 8, '3000000.00', 1, 0, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `book_rental`
--

CREATE TABLE `book_rental` (
  `ISBN` varchar(13) NOT NULL,
  `BID` int(9) NOT NULL,
  `DUE_DATE` date DEFAULT NULL,
  `DEPOSIT` decimal(10,2) DEFAULT NULL,
  `FEE` decimal(10,2) DEFAULT NULL,
  `FINE` decimal(10,2) DEFAULT NULL,
  `PUNISH_DATE` date DEFAULT NULL,
  `RETURN_DEPOSIT` tinyint(1) DEFAULT 0,
  `RETURN_DATE` date DEFAULT NULL,
  `STAFF_SSN` char(10) DEFAULT NULL,
  `IS_LOST` tinyint(1) DEFAULT 0,
  `IS_DESTROY` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `book_rental`
--

INSERT INTO `book_rental` (`ISBN`, `BID`, `DUE_DATE`, `DEPOSIT`, `FEE`, `FINE`, `PUNISH_DATE`, `RETURN_DEPOSIT`, `RETURN_DATE`, `STAFF_SSN`, `IS_LOST`, `IS_DESTROY`) VALUES
('0001', 58, '2023-01-06', '50000.00', '60000.00', NULL, NULL, 0, '2022-12-07', 'S000000001', 0, 0),
('0001', 78, '2023-01-22', '50000.00', '60000.00', NULL, NULL, 0, NULL, NULL, 0, 0),
('0002', 58, '2023-01-06', '50000.00', '90000.00', '150000.00', '2022-12-07', 0, '2022-12-07', 'S000000001', 0, 1),
('0003', 69, '2023-01-06', '50000.00', '120000.00', NULL, NULL, 0, '2022-12-07', 'S000000001', 0, 0),
('0003', 79, '2023-01-07', '50000.00', '120000.00', NULL, NULL, 0, NULL, NULL, 0, 0),
('0004', 69, '2023-01-06', '50000.00', '150000.00', NULL, NULL, 0, '2022-12-07', 'S000000001', 0, 0),
('0004', 80, '2023-01-07', '50000.00', '150000.00', '500000.00', '2022-12-08', 0, '2022-12-08', 'S000000001', 1, 0),
('0007', 75, '2022-11-03', '50000.00', '60000.00', '100000.00', '2022-12-08', 0, '2022-12-08', 'S000000002', 0, 0),
('0008', 77, '2023-01-07', '50000.00', '60000.00', '200000.00', '2022-12-08', 0, '2022-12-08', 'S000000002', 1, 0),
('0010', 76, '2022-11-03', '50000.00', '60000.00', '100000.00', '2022-12-08', 0, '2022-12-08', 'S000000002', 0, 0),
('0011', 88, '2023-01-10', '50000.00', '60000.00', NULL, NULL, 0, NULL, NULL, 0, 0),
('0012', 88, '2023-01-10', '50000.00', '900000.00', NULL, NULL, 0, NULL, NULL, 0, 0),
('0013', 89, '2023-01-26', '50000.00', '900000.00', NULL, NULL, 1, '2022-12-12', 'S000000002', 0, 0);

--
-- Triggers `book_rental`
--
DELIMITER $$
CREATE TRIGGER `EXTEND` BEFORE UPDATE ON `book_rental` FOR EACH ROW BEGIN
DECLARE $MSG VARCHAR(128);

DECLARE $start date;
DECLARE $due date;
SELECT start_date into $start from bill where bid = new.bid;
set $due = old.due_date;
if old.return_date is null then 
if (datediff($due, $start) > 30) && (new.due_date > old.due_date) then
SET $MSG = CONCAT("ERROR: THE BOOK ", CAST(NEW.ISBN AS CHAR),' HAD ALREADY EXTENDED');
signal sqlstate '45000' set message_text = $MSG;
END IF;
else 
SET $MSG = CONCAT("ERROR: THE BOOK ", CAST(NEW.ISBN AS CHAR),' HAD ALREADY RETURNED');
signal sqlstate '45000' set message_text = $MSG;
end if;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `_UPDATE` AFTER INSERT ON `book_rental` FOR EACH ROW BEGIN
DECLARE $ID CHAR(10);
SELECT M.SSN INTO $ID FROM MEMBER M, BILL B 
	WHERE B.BID = NEW.BID AND B.MEMBER_SSN = M.SSN;
UPDATE MEMBER SET AMOUNT_BOOK = AMOUNT_BOOK +1 
	WHERE SSN = $ID;
UPDATE BOOK SET AVAILABLE = 0 
	WHERE ISBN = NEW.ISBN;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `check_BOOK` BEFORE INSERT ON `book_rental` FOR EACH ROW BEGIN
DECLARE $MSG VARCHAR(128);
DECLARE $SUM INT;
DECLARE $LIST VARCHAR(13);
DECLARE $ID VARCHAR(13);
DECLARE $SSN CHAR(10);
DECLARE $STATUS1 BOOLEAN;
DECLARE $STATUS2 BOOLEAN;
DECLARE $STATUS3 BOOLEAN;
DECLARE $t1 int;
DECLARE $t2 int;
SELECT B.member_SSN INTO $SSN FROM BILL B
WHERE B.BID = NEW.BID;

SELECT COUNT(ISBN) INTO $SUM FROM book_rental
             WHERE(BID = NEW.BID);
SELECT K.ISBN, K.available, K.hired, K.destroyed INTO $ID, $STATUS1, $STATUS2, $STATUS3 FROM BOOK K
             WHERE(K.ISBN = NEW.ISBN);
IF $STATUS1 = 0 THEN 
SET $MSG = CONCAT("ERROR: THE BOOK ", CAST(NEW.ISBN AS CHAR),' IS NOT AVAILABLE');
signal sqlstate '45000' set message_text = $MSG;
ELSEIF $STATUS2 = 0 THEN
SET $MSG = CONCAT('ERROR: THE BOOK ',CAST(NEW.ISBN AS CHAR),' IS NOT LENDABLE');
signal sqlstate '45000' set message_text = $MSG;
ELSEIF $STATUS3 = 1 THEN
SET $MSG = CONCAT('ERROR: THE BOOK ',CAST(NEW.ISBN AS CHAR),' IS NOT LENDABLE');
signal sqlstate '45000' set message_text = $MSG;
END IF;
IF $SUM = 5 THEN
SET $MSG = CONCAT('ERROR: THE NUMBER OF BOOK IN BILL ',CAST(NEW.BID AS CHAR),' OVERHEAD');
signal sqlstate '45000' set message_text = $msg;
END IF;
select a.total_book, a.AMOUNT_BOOK into $t1, $t2 from member a, bill B
where a.SSN = b.MEMBER_SSN and b.BID = new.bid;
IF $t1 = $t2 THEN
SET $MSG = CONCAT('ERROR: THE NUMBER OF BORROWING BOOK OF MEMBER IS OVERHEAD');
signal sqlstate '45000' set message_text = $msg;
END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `return_book` BEFORE UPDATE ON `book_rental` FOR EACH ROW BEGIN
DECLARE $ID CHAR(10);
DECLARE $TEMP INT;
SET $TEMP = CHECK_BILL(NEW.BID) - 1;
IF !(new.return_date <=> old.return_date) THEN
SET $ID = (SELECT B.MEMBER_SSN FROM BILL B
WHERE B.BID = NEW.BID);
IF (NEW.RETURN_DATE <= NEW.DUE_DATE) && (NEW.IS_DESTROY = 0) && (NEW.IS_LOST = 0)THEN
UPDATE BOOK SET AVAILABLE = 1 
WHERE ISBN = NEW.ISBN;
UPDATE MEMBER SET POINT = POINT + 1, AMOUNT_BOOK = AMOUNT_BOOK -1
WHERE SSN = $ID;
END IF;
IF NEW.RETURN_DATE > NEW.DUE_DATE THEN
UPDATE BOOK SET AVAILABLE = 1 
WHERE ISBN = NEW.ISBN;
UPDATE MEMBER SET POINT = POINT - 2, AMOUNT_BOOK = AMOUNT_BOOK -1
WHERE SSN = $ID;
set new.punish_date = new.return_date;
set new.fine = 0.5 * FIND_PRICE(NEW.ISBN);
END IF;
IF NEW.IS_DESTROY = 1 THEN
UPDATE BOOK SET AVAILABLE = 1 
WHERE ISBN = NEW.ISBN;
UPDATE MEMBER SET POINT = POINT - 3, AMOUNT_BOOK = AMOUNT_BOOK -1
WHERE SSN = $ID;
UPDATE BOOK SET DESTROYED = 1
WHERE ISBN = NEW.ISBN;
set new.punish_date = new.return_date;
set new.fine = 0.5 * FIND_PRICE(NEW.ISBN);
END IF;
IF NEW.IS_LOST = 1 THEN
UPDATE MEMBER SET POINT = POINT - 5, AMOUNT_BOOK = AMOUNT_BOOK -1
WHERE SSN = $ID;
UPDATE BOOK SET LOST = 1
WHERE ISBN = NEW.ISBN;
set new.punish_date = new.return_date;
set new.fine = FIND_PRICE(NEW.ISBN);
END IF;
IF $TEMP = 0 THEN 
INSERT INTO invalid_bill(BID, END_DATE)
VALUES(NEW.BID, NEW.RETURN_DATE);
DELETE FROM valid_bill WHERE BID = NEW.BID;
END IF;
END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `setup` BEFORE INSERT ON `book_rental` FOR EACH ROW BEGIN 
DECLARE $DUE_DATE DATE;
SET $DUE_DATE = (SELECT START_DATE FROM BILL WHERE(BID = NEW.BID));
SET $DUE_DATE = ADDDATE($DUE_DATE, 30 );
SET NEW.DUE_DATE = $DUE_DATE;
SET NEW.FEE = 0.3* FIND_PRICE(NEW.ISBN);
SET NEW.DEPOSIT = 50000;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `invalid_bill`
--

CREATE TABLE `invalid_bill` (
  `BID` int(9) NOT NULL,
  `END_DATE` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `invalid_bill`
--

INSERT INTO `invalid_bill` (`BID`, `END_DATE`) VALUES
(69, '2022-12-07'),
(75, '2022-12-08'),
(76, '2022-12-08'),
(77, '2022-12-08'),
(80, '2022-12-08'),
(89, '2022-12-12');

-- --------------------------------------------------------

--
-- Table structure for table `language`
--

CREATE TABLE `language` (
  `ISBN` varchar(13) NOT NULL,
  `LANGUAGE` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `language`
--

INSERT INTO `language` (`ISBN`, `LANGUAGE`) VALUES
('0001', ' VIE'),
('0001', 'ENG'),
('0002', ' KOR'),
('0002', 'JAP'),
('0003', ' BRA'),
('0003', 'FRA'),
('0004', ' FRA'),
('0004', ' VIE'),
('0004', 'ENG'),
('0005', ' BRA'),
('0005', ' CAM'),
('0005', 'FRA'),
('0006', ' LAO'),
('0006', ' VIE'),
('0006', 'ENG'),
('0007', ' VIE'),
('0007', 'ENG'),
('0008', ' KOR'),
('0008', 'JAP'),
('0009', ' BRA'),
('0009', 'FRA'),
('0010', ' VIE'),
('0010', 'ENG'),
('0011', ' CAM'),
('0011', ' VIE'),
('0011', 'ENG'),
('0012', ' VIE'),
('0012', 'ENG'),
('0013', ' VIE'),
('0013', 'ENG');

-- --------------------------------------------------------

--
-- Table structure for table `member`
--

CREATE TABLE `member` (
  `SSN` char(10) NOT NULL,
  `AMOUNT_BOOK` int(11) DEFAULT 0,
  `POINT` int(11) DEFAULT 20,
  `total_book` int(11) DEFAULT 5
) ;

--
-- Dumping data for table `member`
--

INSERT INTO `member` (`SSN`, `AMOUNT_BOOK`, `POINT`, `total_book`) VALUES
('M000000001', 6, 46, 5),
('M000000002', 6, 52, 5),
('M000000003', 7, 48, 5),
('M000000004', 0, 50, 5),
('M000000005', 5, 15, 5),
('M000000006', 5, 20, 5),
('M000000007', 2, 15, 5),
('M000000008', 0, 21, 5);

--
-- Triggers `member`
--
DELIMITER $$
CREATE TRIGGER `ADD_POINT` BEFORE UPDATE ON `member` FOR EACH ROW BEGIN
if new.point = 5 then 
set new.total_book = 3;
end if;
IF NEW.POINT = 10 THEN 
SET NEW.total_BOOK = 4;
END IF;
IF NEW.POINT = 20 THEN 
SET NEW.total_BOOK = 5;
END IF;
IF NEW.POINT = 30 THEN 
SET NEW.total_BOOK = 6;
END IF;
IF NEW.POINT = 40 THEN 
SET NEW.total_BOOK = 7;
END IF;

IF NEW.POINT = 50 THEN 
SET NEW.AMOUNT_BOOK = 8;
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `SSN` char(10) NOT NULL,
  `SALARY` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`SSN`, `SALARY`) VALUES
('S000000001', NULL),
('S000000002', NULL),
('S000000003', NULL),
('S000000004', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `subject_area`
--

CREATE TABLE `subject_area` (
  `ISBN` varchar(13) NOT NULL,
  `SUBJECT` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `subject_area`
--

INSERT INTO `subject_area` (`ISBN`, `SUBJECT`) VALUES
('0001', ' ENGLISH'),
('0001', 'MATH'),
('0002', 'SCIENCE'),
('0003', 'LITERATURE'),
('0004', ' ENGLISH'),
('0004', ' INFORMATION'),
('0004', 'MATH'),
('0005', ' MATH'),
('0005', ' PSYCHOLOGY'),
('0005', 'LITERATURE'),
('0006', ' ENGLISH'),
('0006', ' MOVIE'),
('0006', 'MATH'),
('0007', ' ENGLISH'),
('0007', 'MATH'),
('0008', ' ENGLISH'),
('0008', 'MATH'),
('0009', ' english'),
('0009', 'math'),
('0010', ' ENGLISH'),
('0010', 'MATH'),
('0011', ' ENGLISH'),
('0011', 'MATH'),
('0012', ' ENGLISH'),
('0012', 'MATH'),
('0013', ' ENGLISH'),
('0013', 'MATH');

-- --------------------------------------------------------

--
-- Table structure for table `valid_bill`
--

CREATE TABLE `valid_bill` (
  `BID` int(9) NOT NULL,
  `NOTICE_DATE` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `valid_bill`
--

INSERT INTO `valid_bill` (`BID`, `NOTICE_DATE`) VALUES
(88, '2023-01-03');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`SSN`),
  ADD UNIQUE KEY `USERNAME` (`USERNAME`),
  ADD UNIQUE KEY `EMAIL` (`EMAIL`),
  ADD UNIQUE KEY `PHONE` (`PHONE`);

--
-- Indexes for table `author`
--
ALTER TABLE `author`
  ADD PRIMARY KEY (`ISBN`,`author_name`);

--
-- Indexes for table `bill`
--
ALTER TABLE `bill`
  ADD PRIMARY KEY (`BID`),
  ADD KEY `STAFF_SSN` (`STAFF_SSN`),
  ADD KEY `MEMBER_SSN` (`MEMBER_SSN`);

--
-- Indexes for table `book`
--
ALTER TABLE `book`
  ADD PRIMARY KEY (`ISBN`);

--
-- Indexes for table `book_rental`
--
ALTER TABLE `book_rental`
  ADD PRIMARY KEY (`ISBN`,`BID`),
  ADD KEY `BID` (`BID`),
  ADD KEY `STAFF_SSN` (`STAFF_SSN`);

--
-- Indexes for table `invalid_bill`
--
ALTER TABLE `invalid_bill`
  ADD PRIMARY KEY (`BID`);

--
-- Indexes for table `language`
--
ALTER TABLE `language`
  ADD PRIMARY KEY (`ISBN`,`LANGUAGE`);

--
-- Indexes for table `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`SSN`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`SSN`);

--
-- Indexes for table `subject_area`
--
ALTER TABLE `subject_area`
  ADD PRIMARY KEY (`ISBN`,`SUBJECT`);

--
-- Indexes for table `valid_bill`
--
ALTER TABLE `valid_bill`
  ADD PRIMARY KEY (`BID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bill`
--
ALTER TABLE `bill`
  MODIFY `BID` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `author`
--
ALTER TABLE `author`
  ADD CONSTRAINT `author_ibfk_1` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`);

--
-- Constraints for table `bill`
--
ALTER TABLE `bill`
  ADD CONSTRAINT `bill_ibfk_1` FOREIGN KEY (`STAFF_SSN`) REFERENCES `staff` (`SSN`),
  ADD CONSTRAINT `bill_ibfk_2` FOREIGN KEY (`MEMBER_SSN`) REFERENCES `member` (`SSN`);

--
-- Constraints for table `book_rental`
--
ALTER TABLE `book_rental`
  ADD CONSTRAINT `book_rental_ibfk_1` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`),
  ADD CONSTRAINT `book_rental_ibfk_2` FOREIGN KEY (`BID`) REFERENCES `bill` (`BID`),
  ADD CONSTRAINT `book_rental_ibfk_3` FOREIGN KEY (`STAFF_SSN`) REFERENCES `staff` (`SSN`);

--
-- Constraints for table `invalid_bill`
--
ALTER TABLE `invalid_bill`
  ADD CONSTRAINT `invalid_bill_ibfk_1` FOREIGN KEY (`BID`) REFERENCES `bill` (`BID`);

--
-- Constraints for table `language`
--
ALTER TABLE `language`
  ADD CONSTRAINT `language_ibfk_1` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`);

--
-- Constraints for table `member`
--
ALTER TABLE `member`
  ADD CONSTRAINT `member_ibfk_1` FOREIGN KEY (`SSN`) REFERENCES `account` (`SSN`);

--
-- Constraints for table `staff`
--
ALTER TABLE `staff`
  ADD CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`SSN`) REFERENCES `account` (`SSN`);

--
-- Constraints for table `subject_area`
--
ALTER TABLE `subject_area`
  ADD CONSTRAINT `subject_area_ibfk_1` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`);

--
-- Constraints for table `valid_bill`
--
ALTER TABLE `valid_bill`
  ADD CONSTRAINT `valid_bill_ibfk_1` FOREIGN KEY (`BID`) REFERENCES `bill` (`BID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
