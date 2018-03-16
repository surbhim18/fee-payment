CREATE DATABASE  IF NOT EXISTS `feemgtsys` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `feemgtsys`;
-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: feemgtsys
-- ------------------------------------------------------
-- Server version	5.7.9-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `studentfeeinfo`
--

DROP TABLE IF EXISTS `studentfeeinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `studentfeeinfo` (
  `Cid` char(3) NOT NULL,
  `Year` int(4) NOT NULL,
  `Sid` int(4) NOT NULL,
  `FeeStatus` int(1) NOT NULL DEFAULT '0',
  `RefundStatus` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Cid`,`Year`,`Sid`),
  KEY `studentinfo_fk_Stcode_idx` (`Cid`,`Year`,`Sid`),
  CONSTRAINT `studentinfo_fk_Stcode` FOREIGN KEY (`Cid`, `Year`, `Sid`) REFERENCES `studentinfo` (`Cid`, `Year`, `Sid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studentfeeinfo`
--

LOCK TABLES `studentfeeinfo` WRITE;
/*!40000 ALTER TABLE `studentfeeinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `studentfeeinfo` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `feemgtsys`.`studentfeeinfo_BEFORE_INSERT` BEFORE INSERT ON `studentfeeinfo` FOR EACH ROW
BEGIN
	IF NEW.RefundStatus!=0 AND NEW.RefundStatus!=1
	THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Invalid Refund Status!';
	ELSEIF NEW.FeeStatus!=0 AND NEW.FeeStatus!=1
    THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Invalid Fee Status!';
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
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `feemgtsys`.`studentfeeinfo_BEFORE_UPDATE` BEFORE UPDATE ON `studentfeeinfo` FOR EACH ROW
BEGIN
	IF NEW.RefundStatus!=0 AND NEW.RefundStatus!=1
	THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Invalid Refund Status!';
	ELSEIF NEW.FeeStatus!=0 AND NEW.FeeStatus!=1
    THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Invalid Fee Status!';
	ELSEIF NEW.FeeStatus=0 AND NEW.RefundStatus=1
    THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Fee cannot be refunded';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-10-23  2:14:56
