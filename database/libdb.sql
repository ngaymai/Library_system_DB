-- MariaDB dump 10.19  Distrib 10.4.25-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: libdb
-- ------------------------------------------------------
-- Server version	10.4.25-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account` (
  `SSN` char(10) NOT NULL,
  `USERNAME` varchar(255) NOT NULL,
  `EMAIL` varchar(255) NOT NULL,
  `PASSWORD` varchar(50) NOT NULL,
  `FULL_NAME` varchar(255) NOT NULL,
  `ADDRESS` varchar(255) NOT NULL,
  `PHONE` varchar(12) NOT NULL,
  `IS_STAFF` tinyint(1) DEFAULT 0,
  `create_date` date DEFAULT curdate(),
  PRIMARY KEY (`SSN`),
  UNIQUE KEY `USERNAME` (`USERNAME`),
  UNIQUE KEY `EMAIL` (`EMAIL`),
  UNIQUE KEY `PHONE` (`PHONE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES ('M000000001','bbb','nvb123@gmail.com','bbb123','Nguyen Van B','BBB','222222',0,'2022-12-07'),('M000000002','nvd','nvd@gmail.com','nnvd123','Nguyen Van D','DDD','444444',0,'2022-12-07'),('M000000003','nvf','nvf@gmail.com','nvf123','Nguyen Van F','FFF','666666',0,'2022-12-07'),('M000000004','nvg','nvg@gmail.com','nvg123','Nguyen Van G','GGG','777777',0,'2022-12-07'),('M000000005','nvh','nvh@gmail.com','nvh123','Nguyen Van H','HHH','101010',0,'2022-12-07'),('M000000006','nvj','nvj@gmail.com','nvj123','Nguyen Van J','JJJ','232323',0,'2022-12-08'),('M000000007','nvfi','nvfi@gmail.com','nvfi123','Nguyen Van Fi','fififi','888888',0,'2022-12-08'),('M000000008','thk','thk@gmail.com','thk123','Truong Hai K','hkhk','676767',0,'2022-12-12'),('S000000001','aaa','nva123@gmail.com','aaa123','Nguyen Van A','AAA','111111',1,'2022-12-07'),('S000000002','nvc','nvc@gmail.com','nvc123','Nguyen Van C','CCC','333333',1,'2022-12-07'),('S000000003','nve','nve@gmail.com','nve123','Nguyen Van E','EEE','555555',1,'2022-12-07'),('S000000004','nvt','nvt@gmail.com','nvt123','Nguyen Van T','ttt','331122',1,'2022-12-08');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TRIGGER_SSN` BEFORE INSERT ON `account` FOR EACH ROW 
BEGIN
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
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `INSERT_SSN` AFTER INSERT ON `account` FOR EACH ROW BEGIN
IF NEW.SSN LIKE 'S%' THEN
INSERT INTO staff(SSN)
VALUES(NEW.SSN);
ELSEIF NEW.SSN LIKE 'M%' THEN
INSERT INTO member(SSN)
VALUES(NEW.SSN);
END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `author` (
  `ISBN` varchar(13) NOT NULL,
  `author_name` varchar(255) NOT NULL,
  PRIMARY KEY (`ISBN`,`author_name`),
  CONSTRAINT `author_ibfk_1` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` VALUES ('0001',' Do Van C'),('0001',' Truong Thi B'),('0001','Hoang Thi A'),('0002',' Do Van F'),('0002','Truong Thi E'),('0003',' Do Van C'),('0003',' Truong Thi Y'),('0003','Hoang Thi R'),('0004',' Do Van P'),('0004',' Truong Thi B'),('0004','Hoang Thi H'),('0005',' Do Van C'),('0005',' Truong Thi Y'),('0005','Hoang Thi R'),('0006',' Do Van CO'),('0006',' Truong Thi K'),('0006','Hoang Thi R'),('0007',' Do Van C'),('0007',' Truong Thi Y'),('0007','Hoang Thi R'),('0008',' Do Van C'),('0008',' Truong Thi Y'),('0008','Hoang Thi R'),('0009',' Do Van C'),('0009',' Truong Thi Y'),('0009','Hoang Thi R'),('0010',' Do Van C'),('0010',' Truong Thi Y'),('0010','Hoang Thi R'),('0011','NGUYEN THI L'),('0012',' Do Van K'),('0012',' Truong Thi Z'),('0012','Hoang Thi I'),('0012','NGUYEN THI K'),('0013',' Ha Van T'),('0013',' Nguyen Trong N'),('0013','Truong Hai I');
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bill`
--

DROP TABLE IF EXISTS `bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bill` (
  `BID` int(9) NOT NULL AUTO_INCREMENT,
  `STAFF_SSN` char(10) NOT NULL,
  `MEMBER_SSN` char(10) NOT NULL,
  `start_date` date DEFAULT curdate(),
  PRIMARY KEY (`BID`),
  KEY `STAFF_SSN` (`STAFF_SSN`),
  KEY `MEMBER_SSN` (`MEMBER_SSN`),
  CONSTRAINT `bill_ibfk_1` FOREIGN KEY (`STAFF_SSN`) REFERENCES `staff` (`SSN`),
  CONSTRAINT `bill_ibfk_2` FOREIGN KEY (`MEMBER_SSN`) REFERENCES `member` (`SSN`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill`
--

LOCK TABLES `bill` WRITE;
/*!40000 ALTER TABLE `bill` DISABLE KEYS */;
INSERT INTO `bill` VALUES (58,'S000000001','M000000001','2022-12-07'),(69,'S000000001','M000000002','2022-12-07'),(75,'S000000002','M000000001','2022-08-30'),(76,'S000000002','M000000003','2022-08-30'),(77,'S000000002','M000000005','2022-12-08'),(78,'S000000001','M000000005','2022-12-08'),(79,'S000000001','M000000006','2022-12-08'),(80,'S000000001','M000000007','2022-12-08'),(88,'S000000001','M000000007','2022-12-11'),(89,'S000000002','M000000008','2022-12-12');
/*!40000 ALTER TABLE `bill` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_member` BEFORE INSERT ON `bill` FOR EACH ROW BEGIN
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
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER insert_validbill AFTER INSERT ON bill
FOR EACH ROW
BEGIN
INSERT INTO valid_bill(BID, NOTICE_DATE)
VALUES(NEW.BID, ADDDATE(NEW.START_DATE,23));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book` (
  `ISBN` varchar(13) NOT NULL,
  `title` varchar(255) NOT NULL,
  `edition` int(11) DEFAULT NULL,
  `PRICE` decimal(10,2) DEFAULT NULL,
  `available` tinyint(1) DEFAULT 1,
  `destroyed` tinyint(1) DEFAULT 0,
  `lost` tinyint(1) DEFAULT 0,
  `hired` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`ISBN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES ('0001','AAA',1,200000.00,0,0,0,1),('0002','BBBB',2,300000.00,1,1,0,1),('0003','CCC',2,400000.00,0,0,0,1),('0004','DDD',2,500000.00,0,0,1,1),('0005','EEE',3,1000000.00,1,0,0,0),('0006','FFFF',4,2000000.00,1,0,0,0),('0007','aaaa',2,200000.00,1,0,0,1),('0008','rrrr',2,200000.00,0,0,1,1),('0009','uyuy',1,300000.00,1,0,0,1),('0010','yyyy',4,200000.00,1,0,0,1),('0011','ererer',2,200000.00,0,0,0,1),('0012','auauau',4,3000000.00,0,0,0,1),('0013','newtest',8,3000000.00,1,0,0,1);
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_rental`
--

DROP TABLE IF EXISTS `book_rental`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
  `IS_DESTROY` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`ISBN`,`BID`),
  KEY `BID` (`BID`),
  KEY `STAFF_SSN` (`STAFF_SSN`),
  CONSTRAINT `book_rental_ibfk_1` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`),
  CONSTRAINT `book_rental_ibfk_2` FOREIGN KEY (`BID`) REFERENCES `bill` (`BID`),
  CONSTRAINT `book_rental_ibfk_3` FOREIGN KEY (`STAFF_SSN`) REFERENCES `staff` (`SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_rental`
--

LOCK TABLES `book_rental` WRITE;
/*!40000 ALTER TABLE `book_rental` DISABLE KEYS */;
INSERT INTO `book_rental` VALUES ('0001',58,'2023-01-06',50000.00,60000.00,NULL,NULL,0,'2022-12-07','S000000001',0,0),('0001',78,'2023-01-22',50000.00,60000.00,NULL,NULL,0,NULL,NULL,0,0),('0002',58,'2023-01-06',50000.00,90000.00,150000.00,'2022-12-07',0,'2022-12-07','S000000001',0,1),('0003',69,'2023-01-06',50000.00,120000.00,NULL,NULL,0,'2022-12-07','S000000001',0,0),('0003',79,'2023-01-07',50000.00,120000.00,NULL,NULL,0,NULL,NULL,0,0),('0004',69,'2023-01-06',50000.00,150000.00,NULL,NULL,0,'2022-12-07','S000000001',0,0),('0004',80,'2023-01-07',50000.00,150000.00,500000.00,'2022-12-08',0,'2022-12-08','S000000001',1,0),('0007',75,'2022-11-03',50000.00,60000.00,100000.00,'2022-12-08',0,'2022-12-08','S000000002',0,0),('0008',77,'2023-01-07',50000.00,60000.00,200000.00,'2022-12-08',0,'2022-12-08','S000000002',1,0),('0010',76,'2022-11-03',50000.00,60000.00,100000.00,'2022-12-08',0,'2022-12-08','S000000002',0,0),('0011',88,'2023-01-10',50000.00,60000.00,NULL,NULL,0,NULL,NULL,0,0),('0012',88,'2023-01-10',50000.00,900000.00,NULL,NULL,0,NULL,NULL,0,0),('0013',89,'2023-01-26',50000.00,900000.00,NULL,NULL,1,'2022-12-12','S000000002',0,0);
/*!40000 ALTER TABLE `book_rental` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `setup` BEFORE INSERT ON `book_rental` FOR EACH ROW BEGIN 
DECLARE $DUE_DATE DATE;
SET $DUE_DATE = (SELECT START_DATE FROM BILL WHERE(BID = NEW.BID));
SET $DUE_DATE = ADDDATE($DUE_DATE, 30 );
SET NEW.DUE_DATE = $DUE_DATE;
SET NEW.FEE = 0.3* FIND_PRICE(NEW.ISBN);
SET NEW.DEPOSIT = 50000;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_BOOK` BEFORE INSERT ON `book_rental` FOR EACH ROW BEGIN
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
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER _UPDATE AFTER INSERT ON book_rental 
FOR EACH ROW
BEGIN
DECLARE $ID CHAR(10);
SELECT M.SSN INTO $ID FROM MEMBER M, BILL B 
	WHERE B.BID = NEW.BID AND B.MEMBER_SSN = M.SSN;
UPDATE MEMBER SET AMOUNT_BOOK = AMOUNT_BOOK +1 
	WHERE SSN = $ID;
UPDATE BOOK SET AVAILABLE = 0 
	WHERE ISBN = NEW.ISBN;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER EXTEND before UPDATE on book_rental
for each row
BEGIN
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
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `return_book` BEFORE UPDATE ON `book_rental` FOR EACH ROW BEGIN
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
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `invalid_bill`
--

DROP TABLE IF EXISTS `invalid_bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invalid_bill` (
  `BID` int(9) NOT NULL,
  `END_DATE` date DEFAULT NULL,
  PRIMARY KEY (`BID`),
  CONSTRAINT `invalid_bill_ibfk_1` FOREIGN KEY (`BID`) REFERENCES `bill` (`BID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invalid_bill`
--

LOCK TABLES `invalid_bill` WRITE;
/*!40000 ALTER TABLE `invalid_bill` DISABLE KEYS */;
INSERT INTO `invalid_bill` VALUES (69,'2022-12-07'),(75,'2022-12-08'),(76,'2022-12-08'),(77,'2022-12-08'),(80,'2022-12-08'),(89,'2022-12-12');
/*!40000 ALTER TABLE `invalid_bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language`
--

DROP TABLE IF EXISTS `language`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `language` (
  `ISBN` varchar(13) NOT NULL,
  `LANGUAGE` varchar(50) NOT NULL,
  PRIMARY KEY (`ISBN`,`LANGUAGE`),
  CONSTRAINT `language_ibfk_1` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language`
--

LOCK TABLES `language` WRITE;
/*!40000 ALTER TABLE `language` DISABLE KEYS */;
INSERT INTO `language` VALUES ('0001',' VIE'),('0001','ENG'),('0002',' KOR'),('0002','JAP'),('0003',' BRA'),('0003','FRA'),('0004',' FRA'),('0004',' VIE'),('0004','ENG'),('0005',' BRA'),('0005',' CAM'),('0005','FRA'),('0006',' LAO'),('0006',' VIE'),('0006','ENG'),('0007',' VIE'),('0007','ENG'),('0008',' KOR'),('0008','JAP'),('0009',' BRA'),('0009','FRA'),('0010',' VIE'),('0010','ENG'),('0011',' CAM'),('0011',' VIE'),('0011','ENG'),('0012',' VIE'),('0012','ENG'),('0013',' VIE'),('0013','ENG');
/*!40000 ALTER TABLE `language` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member` (
  `SSN` char(10) NOT NULL,
  `AMOUNT_BOOK` int(11) DEFAULT 0,
  `POINT` int(11) DEFAULT 20,
  `total_book` int(11) DEFAULT 5,
  PRIMARY KEY (`SSN`),
  CONSTRAINT `member_ibfk_1` FOREIGN KEY (`SSN`) REFERENCES `account` (`SSN`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`POINT` >= 0),
  CONSTRAINT `CONSTRAINT_2` CHECK (`total_book` >= 0 and `total_book` <= 8),
  CONSTRAINT `CONSTRAINT_3` CHECK (`total_book` >= 0 and `total_book` <= 8),
  CONSTRAINT `CONSTRAINT_4` CHECK (`AMOUNT_BOOK` >= 0 and `AMOUNT_BOOK` <= 8)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES ('M000000001',6,46,5),('M000000002',6,52,5),('M000000003',7,48,5),('M000000004',0,50,5),('M000000005',5,15,5),('M000000006',5,20,5),('M000000007',2,15,5),('M000000008',0,21,5);
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ADD_POINT` BEFORE UPDATE ON `member` FOR EACH ROW BEGIN
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
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff` (
  `SSN` char(10) NOT NULL,
  `SALARY` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`SSN`),
  CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`SSN`) REFERENCES `account` (`SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES ('S000000001',NULL),('S000000002',NULL),('S000000003',NULL),('S000000004',NULL);
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subject_area`
--

DROP TABLE IF EXISTS `subject_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subject_area` (
  `ISBN` varchar(13) NOT NULL,
  `SUBJECT` varchar(255) NOT NULL,
  PRIMARY KEY (`ISBN`,`SUBJECT`),
  CONSTRAINT `subject_area_ibfk_1` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject_area`
--

LOCK TABLES `subject_area` WRITE;
/*!40000 ALTER TABLE `subject_area` DISABLE KEYS */;
INSERT INTO `subject_area` VALUES ('0001',' ENGLISH'),('0001','MATH'),('0002','SCIENCE'),('0003','LITERATURE'),('0004',' ENGLISH'),('0004',' INFORMATION'),('0004','MATH'),('0005',' MATH'),('0005',' PSYCHOLOGY'),('0005','LITERATURE'),('0006',' ENGLISH'),('0006',' MOVIE'),('0006','MATH'),('0007',' ENGLISH'),('0007','MATH'),('0008',' ENGLISH'),('0008','MATH'),('0009',' english'),('0009','math'),('0010',' ENGLISH'),('0010','MATH'),('0011',' ENGLISH'),('0011','MATH'),('0012',' ENGLISH'),('0012','MATH'),('0013',' ENGLISH'),('0013','MATH');
/*!40000 ALTER TABLE `subject_area` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `valid_bill`
--

DROP TABLE IF EXISTS `valid_bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `valid_bill` (
  `BID` int(9) NOT NULL,
  `NOTICE_DATE` date NOT NULL,
  PRIMARY KEY (`BID`),
  CONSTRAINT `valid_bill_ibfk_1` FOREIGN KEY (`BID`) REFERENCES `bill` (`BID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `valid_bill`
--

LOCK TABLES `valid_bill` WRITE;
/*!40000 ALTER TABLE `valid_bill` DISABLE KEYS */;
INSERT INTO `valid_bill` VALUES (88,'2023-01-03');
/*!40000 ALTER TABLE `valid_bill` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-13 14:06:38
