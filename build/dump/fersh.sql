-- MySQL dump 10.13  Distrib 5.6.19, for linux-glibc2.5 (x86_64)
--
-- Host: 127.0.0.1    Database: phalcon.local
-- ------------------------------------------------------
-- Server version	5.7.5-m15

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
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Category id',
  `title` varchar(255) DEFAULT NULL COMMENT 'Category title',
  `description` varchar(512) NOT NULL DEFAULT '' COMMENT 'Category description',
  `alias` varchar(64) NOT NULL DEFAULT '' COMMENT 'Category alias',
  `parent_id` tinyint(3) unsigned DEFAULT NULL COMMENT 'Parent category',
  `lft` smallint(5) unsigned DEFAULT NULL COMMENT 'Left padding',
  `rgt` smallint(5) unsigned DEFAULT NULL COMMENT 'Right padding',
  `sort` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort index',
  `date_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Create date',
  `date_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Update date',
  `visibility` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_alias` (`alias`),
  KEY `idx_rgt` (`rgt`),
  KEY `idx_lft` (`lft`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (103,'2323','<p>2323232323232322322323232323322323232323323323</p>','233232323',NULL,1,2,23,'2015-03-06 23:46:29','2015-03-06 21:46:29',1);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currency`
--

DROP TABLE IF EXISTS `currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currency` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Currency ID',
  `code` char(3) NOT NULL COMMENT 'Currency Code',
  `name` varchar(45) NOT NULL,
  `symbol` varchar(4) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_code` (`code`) COMMENT 'Unique code'
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currency`
--

LOCK TABLES `currency` WRITE;
/*!40000 ALTER TABLE `currency` DISABLE KEYS */;
INSERT INTO `currency` VALUES (1,'USD','USA Dollar','$'),(2,'RUR','Российский рубль','руб.'),(3,'EUR','Euro','€'),(4,'UAH','Украинская гривна','₴'),(5,'GBP','British Pound','£'),(6,'JPY','Японская иена','¥');
/*!40000 ALTER TABLE `currency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engines`
--

DROP TABLE IF EXISTS `engines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engines` (
  `id` tinyint(2) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Engine ID',
  `name` varchar(45) NOT NULL COMMENT 'Engine name',
  `description` varchar(512) NOT NULL COMMENT 'Engine description',
  `host` varchar(45) DEFAULT NULL COMMENT 'identity host name',
  `code` char(3) NOT NULL COMMENT 'Engine short code',
  `token` varchar(255) DEFAULT NULL,
  `logo` varchar(255) NOT NULL DEFAULT '' COMMENT 'Engine logo',
  `currency_id` tinyint(3) unsigned DEFAULT NULL COMMENT 'Relation to `currency` table',
  `status` tinyint(1) NOT NULL COMMENT 'enabled/disabled',
  `date_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_code` (`code`) COMMENT 'Unique value of code',
  UNIQUE KEY `uni_host` (`host`),
  UNIQUE KEY `uni_token` (`token`),
  KEY `fk_currency_id` (`currency_id`),
  CONSTRAINT `fk_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 MAX_ROWS=10;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engines`
--

LOCK TABLES `engines` WRITE;
/*!40000 ALTER TABLE `engines` DISABLE KEYS */;
INSERT INTO `engines` VALUES (1,'Phalcon Shop','<p>This is the simple Phalcon Shop</p>','phalcon.local','PHL','232334454','logo-mysql-110x57.png',4,1,'2015-01-03 02:27:22','2015-03-21 12:50:11'),(10,'eBay','<p>ebay Description2</p>','ebay.com','EBY','','eBay-Logo.gif',1,2,'2015-03-06 12:24:17','2015-03-06 21:23:31');
/*!40000 ALTER TABLE `engines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engines_categories_rel`
--

DROP TABLE IF EXISTS `engines_categories_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engines_categories_rel` (
  `engine_id` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT 'to engines.id rel',
  `category_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'to categories.id rel',
  PRIMARY KEY (`engine_id`,`category_id`),
  KEY `idx_category_id` (`category_id`),
  KEY `idx_engine_id` (`engine_id`),
  CONSTRAINT `fk_category_id` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engines_categories_rel`
--

LOCK TABLES `engines_categories_rel` WRITE;
/*!40000 ALTER TABLE `engines_categories_rel` DISABLE KEYS */;
INSERT INTO `engines_categories_rel` VALUES (1,103);
/*!40000 ALTER TABLE `engines_categories_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `errors`
--

DROP TABLE IF EXISTS `errors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `errors` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Error ID',
  `code` varchar(65) NOT NULL DEFAULT '' COMMENT 'Error Code',
  `description` text NOT NULL COMMENT 'Description',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_code` (`code`) COMMENT 'Unique code'
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `errors`
--

LOCK TABLES `errors` WRITE;
/*!40000 ALTER TABLE `errors` DISABLE KEYS */;
INSERT INTO `errors` VALUES (1,'RECORDS_NOT_FOUND','Means that the requested record does not exist'),(2,'FILTERS_IS_NOT_SUPPORT','Means that you can not use this filter in the query string'),(3,'LANGUAGE_IS_NOT_SUPPORT','Means that you specify the localization is not used in our system'),(4,'EMPTY_PARAMETER_IN_URI','Means that you can not use the argument of the query string without its value'),(5,'INVALID_COLUMNS','Means that in a query, you can not do the sample for the specified fields'),(6,'INVALID_REQUIRED_FIELDS','Means that in a query, you must use the specified fields'),(7,'LONG_REQUEST','Means that the query string is too big for the request'),(8,'CONTENT_IS_NOT_SUPPORT','Means that you requested content type is not supported in the system'),(9,'AUTH_ACCESS_REQUIRED','Means that the requested resource requires authorization by token'),(10,'ACCESS_DENIED','Means that the need for the requested resource rights that you do not have'),(11,'UNAUTHORIZED_REQUEST','Means that the server rejected your request because you are not using the correct data authorization\n'),(12,'USER_NOT_FOUND','Means that the user you have requested the system does not have'),(13,'USER_EXIST','Means that you are trying to add a user to a system that already exists in'),(14,'LOGIN_REQUIRED','Means that the login is absolutely necessary'),(15,'PASSWORD_REQUIRED','Means that the password is absolutely necessary'),(16,'LOGIN_MAX_INVALID','Means that the login is too large'),(17,'LOGIN_MIX_INVALID','Means that the login is too small'),(18,'NAME_MAX_INVALID','Means that the name is too large'),(19,'NAME_MIN_INVALID','Means that the name is too small'),(20,'LOGIN_FORMAT_INVALID','Means that the login have not correct format. Note the error message and bring it to the specified format'),(21,'FIELD_IS_REQUIRED','Means that you may have missed the parameters that are necessary to update or add records');
/*!40000 ALTER TABLE `errors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL,
  `type` tinyint(3) unsigned NOT NULL,
  `content` varchar(512) NOT NULL,
  `created_at` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=ARCHIVE AUTO_INCREMENT=201 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
INSERT INTO `logs` VALUES (1,'Rest',4,'Не верный токен авторизации! Войдите снова IP: 127.0.0.1',1426942315),(2,NULL,2,'Not Found\n              IP: 127.0.0.1\n              URI: /api/vererer',1427794318),(3,NULL,2,'Not Found\n              IP: 127.0.0.1\n              URI: /api/vererer',1427794359),(4,'Global',2,'Not Found\n              IP: 127.0.0.1\n              URI: /api/vererer',1427794513),(5,'Global',2,'Not Found\n              IP: 127.0.0.1\n              URI: /api/errors',1427795804),(6,'Global',2,'Not Found\n              IP: 127.0.0.1\n              URI: /api/errors',1427795806),(7,'Global',2,'Not Found\n              IP: 127.0.0.1\n              URI: /api/errors',1427795807),(8,'Global',2,'Not Found\n              IP: 127.0.0.1\n              URI: /api/errors',1427795847),(9,'Global',2,'Not Found\n              IP: 127.0.0.1\n              URI: /api/errors',1427795848),(10,'Global',2,'Not Found\n              IP: 127.0.0.1\n              URI: /api/errors',1427795848),(11,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              URI: /api/v1/errors',1427795855),(12,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              URI: /api/v1/errors',1427795856),(13,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              URI: /api/v1/logs',1427796167),(14,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              URI: /api/v1/errors/1354',1427796496),(15,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              URI: /api/v1/error',1427796559),(16,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              URI: /api/v1/errors/?sdsds',1427796565),(17,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              URI: /api/v1/errors/?locale=45',1427796649),(18,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              URI: /api/v1/errors/?locale=',1427796718),(19,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: /api/v1/errors/?columns=',1427796728),(20,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              URI: http/api/v1/errors?23',1427797074),(21,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/errors?23',1427797106),(22,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/errors?343',1427797327),(23,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/errors?343',1427797423),(24,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/errors?343',1427797435),(25,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/errors?343',1427797517),(26,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/errors?343',1427797551),(27,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/errors?343',1427797573),(28,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/errors?columns=id,ere',1427797649),(29,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/errors/324',1427797682),(30,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/sign',1427797732),(31,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/sign',1427797753),(32,'Rest',2,'Conflict\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/sign',1427797775),(33,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/sign',1427797814),(34,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/sign',1427798173),(35,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/sign',1427798294),(36,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/sign',1427798336),(37,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/errors?code=LOGIN_FORMAT_INVALID',1427798343),(38,'Rest',1,'Argument 1 passed to Application\\Services\\Mappers\\ErrorMapper::getError() must be of the type array, null given, called in /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestExceptionHandler.php on line 140 and defined File: /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/ErrorMapper.php Line:36',1427798828),(39,'Rest',1,'Call to a member function count() on a non-object File: /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/ErrorMapper.php Line:39',1427798876),(40,'Rest',1,'Undefined index: data File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestExceptionHandler.php Line:139',1427798904),(41,'Rest',1,'Undefined index: data File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestExceptionHandler.php Line:139',1427798924),(42,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/logs?full',1427798935),(43,'Rest',1,'Call to a member function getId() on a non-object File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestExceptionHandler.php Line:141',1427799061),(44,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/logs?full',1427799094),(45,'Rest',1,'Call to a member function count() on a non-object File: /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/ErrorMapper.php Line:39',1427799126),(46,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/errors/?columns=23',1427799140),(47,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/errors/?columns=23',1427799213),(48,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/errors/?columns=23',1427799325),(49,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/errors/?columns=23',1427799353),(50,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/errors/?columns=23',1427799400),(51,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/errors/?columns=23',1427799422),(52,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/errors/?columns=23',1427799430),(53,'Rest',1,'Argument 1 passed to Application\\Modules\\Rest\\Exceptions\\BadRequestException::__construct() must be of the type array, string given, called in /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/UserMapper.php on line 86 and defined File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Exceptions/BadRequestException.php Line:37',1427799692),(54,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/pages?columns=id%2Ctitle%2Cwrong',1427799692),(55,'Rest',1,'Call to a member function count() on a non-object File: /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/ErrorMapper.php Line:39',1427799693),(56,'Rest',1,'Call to a member function count() on a non-object File: /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/ErrorMapper.php Line:39',1427799693),(57,'Rest',1,'Call to a member function count() on a non-object File: /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/ErrorMapper.php Line:39',1427799693),(58,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/undefined/page',1427799693),(59,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/sign',1427799693),(60,'Rest',1,'Call to a member function count() on a non-object File: /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/ErrorMapper.php Line:39',1427799693),(61,'Rest',1,'Call to a member function count() on a non-object File: /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/ErrorMapper.php Line:39',1427799765),(62,'Rest',1,'Argument 1 passed to Application\\Modules\\Rest\\Exceptions\\BadRequestException::__construct() must be of the type array, string given, called in /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/UserMapper.php on line 86 and defined File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Exceptions/BadRequestException.php Line:37',1427799860),(63,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/pages?columns=id%2Ctitle%2Cwrong',1427799860),(64,'Rest',1,'Call to a member function count() on a non-object File: /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/ErrorMapper.php Line:39',1427799860),(65,'Rest',2,'Request URI Too Long\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/pages?columns=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',1427799861),(66,'Rest',1,'Call to a member function count() on a non-object File: /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/ErrorMapper.php Line:39',1427799861),(67,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/undefined/page',1427799861),(68,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/sign',1427799861),(69,'Rest',1,'Call to a member function count() on a non-object File: /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/ErrorMapper.php Line:39',1427799861),(70,'Rest',1,'Argument 1 passed to Application\\Modules\\Rest\\Exceptions\\BadRequestException::__construct() must be of the type array, string given, called in /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/UserMapper.php on line 86 and defined File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Exceptions/BadRequestException.php Line:37',1427799923),(71,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/pages?columns=id%2Ctitle%2Cwrong',1427799923),(72,'Rest',1,'Call to a member function count() on a non-object File: /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/ErrorMapper.php Line:39',1427799923),(73,'Rest',2,'Request URI Too Long\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/pages?columns=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',1427799923),(74,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/users',1427799923),(75,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/undefined/page',1427799923),(76,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/sign',1427799923),(77,'Rest',1,'Call to a member function count() on a non-object File: /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/ErrorMapper.php Line:39',1427799923),(78,'Rest',1,'Argument 1 passed to Application\\Modules\\Rest\\Exceptions\\BadRequestException::__construct() must be of the type array, string given, called in /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/UserMapper.php on line 86 and defined File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Exceptions/BadRequestException.php Line:37',1427800034),(79,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/pages?columns=id%2Ctitle%2Cwrong',1427800034),(80,'Rest',2,'Forbidden\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/users',1427800034),(81,'Rest',2,'Request URI Too Long\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/pages?columns=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',1427800034),(82,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/users',1427800034),(83,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/undefined/page',1427800034),(84,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/sign',1427800034),(85,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/users',1427800034),(86,'Rest',1,'Argument 1 passed to Application\\Modules\\Rest\\Exceptions\\BadRequestException::__construct() must be of the type array, string given, called in /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/UserMapper.php on line 86 and defined File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Exceptions/BadRequestException.php Line:37',1427800214),(87,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/pages?columns=id%2Ctitle%2Cwrong',1427800214),(88,'Rest',2,'Forbidden\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/users',1427800214),(89,'Rest',2,'Request URI Too Long\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/pages?columns=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',1427800214),(90,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/users',1427800214),(91,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/undefined/page',1427800215),(92,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/sign',1427800215),(93,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/users',1427800215),(94,'Rest',1,'Call to a member function count() on a non-object File: /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/ErrorMapper.php Line:39',1427800227),(95,'Rest',1,'Call to a member function count() on a non-object File: /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/ErrorMapper.php Line:39',1427800303),(96,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/sign',1427800733),(97,'Rest',1,'Argument 1 passed to Application\\Modules\\Rest\\Exceptions\\BadRequestException::__construct() must be of the type array, string given, called in /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/UserMapper.php on line 86 and defined File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Exceptions/BadRequestException.php Line:37',1427800804),(98,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/pages?columns=id%2Ctitle%2Cwrong',1427800804),(99,'Rest',2,'Forbidden\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/users',1427800804),(100,'Rest',2,'Request URI Too Long\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/pages?columns=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',1427800804),(101,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/users',1427800804),(102,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/undefined/page',1427800804),(103,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/sign',1427800804),(104,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/users',1427800804),(105,'Rest',1,'Argument 1 passed to Application\\Modules\\Rest\\Exceptions\\BadRequestException::__construct() must be of the type array, string given, called in /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/UserMapper.php on line 86 and defined File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Exceptions/BadRequestException.php Line:37',1427800828),(106,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/pages?columns=id%2Ctitle%2Cwrong',1427801046),(107,'Rest',2,'Forbidden\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/users',1427801047),(108,'Rest',2,'Request URI Too Long\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/pages?columns=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',1427801047),(109,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/users',1427801047),(110,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/undefined/page',1427801047),(111,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/sign',1427801047),(112,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/users',1427801047),(113,'Rest',2,'Conflict\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/sign',1427801329),(114,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/sign',1427804468),(115,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/sign/37',1427804663),(116,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/sign/37',1427805690),(117,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/users',1427805696),(118,'Rest',2,'Conflict\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/sign',1427805884),(119,'Rest',2,'Conflict\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/sign',1427806026),(120,'Rest',1,'Call to a member function count() on a non-object File: /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/ErrorMapper.php Line:39',1427806042),(121,'Rest',1,'Call to a member function count() on a non-object File: /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/ErrorMapper.php Line:39',1427806045),(122,'Rest',1,'Undefined index: /api/v1/pages File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Validators/ResultSetValidator.php Line:131',1427806239),(123,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/users/45',1427812259),(124,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/pages?columns=id%2Ctitle%2Cwrong',1427816585),(125,'Rest',2,'Forbidden\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/users',1427816585),(126,'Rest',2,'Request URI Too Long\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/pages?columns=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',1427816586),(127,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/users',1427816586),(128,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/undefined/page',1427816586),(129,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/sign',1427816586),(130,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/users',1427816586),(131,'Rest',1,'Cannot redeclare Application\\Services\\Mappers\\EngineMapper::getInstance() File: /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/EngineMapper.php Line:123',1427816883),(132,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/sign',1427817091),(133,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/sign',1427817146),(134,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/pages?columns=id%2Ctitle%2Cwrong',1427817157),(135,'Rest',2,'Forbidden\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/users',1427817157),(136,'Rest',2,'Request URI Too Long\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/pages?columns=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',1427817157),(137,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/users',1427817157),(138,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/undefined/page',1427817157),(139,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/sign',1427817157),(140,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/users',1427817157),(141,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/sign',1427817242),(142,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/sign',1427817264),(143,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/sign',1427817274),(144,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/sign',1427817280),(145,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/sign',1427817291),(146,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/sign',1427817342),(147,'Rest',1,'Undefined index: message File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestService.php Line:195',1427821561),(148,'Rest',1,'Undefined index: message File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestService.php Line:195',1427821563),(149,'Rest',1,'Undefined index: message File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestService.php Line:195',1427821564),(150,'Rest',1,'Undefined index: message File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestService.php Line:195',1427821564),(151,'Rest',1,'Maximum function nesting level of \'100\' reached, aborting! File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestService.php Line:87',1427822007),(152,'Rest',1,'Call to a member function count() on a non-object File: /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/ErrorMapper.php Line:39',1427822324),(153,'Rest',1,'Call to a member function count() on a non-object File: /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/ErrorMapper.php Line:39',1427822604),(154,'Rest',1,'Call to a member function count() on a non-object File: /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/ErrorMapper.php Line:39',1427822606),(155,'Rest',1,'Call to a member function count() on a non-object File: /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/ErrorMapper.php Line:39',1427822608),(156,'Rest',1,'Call to a member function count() on a non-object File: /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/ErrorMapper.php Line:39',1427822608),(157,'Rest',1,'Call to a member function count() on a non-object File: /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/ErrorMapper.php Line:39',1427822609),(158,'Rest',1,'Call to a member function count() on a non-object File: /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/ErrorMapper.php Line:39',1427822609),(159,'Rest',1,'Call to a member function count() on a non-object File: /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/ErrorMapper.php Line:39',1427822609),(160,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/sign',1427822654),(161,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/sign',1427822775),(162,'Rest',1,'Argument 1 passed to Application\\Modules\\Rest\\Services\\RestValidatorCollectionService::filterParams() must be of the type array, null given, called in /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestValidatorCollectionService.php on line 70 and defined File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestValidatorCollectionService.php Line:94',1427822784),(163,'Rest',1,'Argument 1 passed to Application\\Modules\\Rest\\Services\\RestValidatorCollectionService::filterParams() must be of the type array, null given, called in /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestValidatorCollectionService.php on line 70 and defined File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestValidatorCollectionService.php Line:94',1427822786),(164,'Rest',1,'Argument 1 passed to Application\\Modules\\Rest\\Services\\RestValidatorCollectionService::filterParams() must be of the type array, null given, called in /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestValidatorCollectionService.php on line 70 and defined File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestValidatorCollectionService.php Line:94',1427822787),(165,'Rest',1,'Argument 1 passed to Application\\Modules\\Rest\\Services\\RestValidatorCollectionService::filterParams() must be of the type array, null given, called in /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestValidatorCollectionService.php on line 70 and defined File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestValidatorCollectionService.php Line:94',1427822802),(166,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/sign',1427822912),(167,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/pages?columns=id%2Ctitle%2Cwrong',1427822953),(168,'Rest',2,'Forbidden\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/users',1427822953),(169,'Rest',2,'Request URI Too Long\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/pages?columns=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',1427822953),(170,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/users',1427822953),(171,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/undefined/page',1427822953),(172,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/sign',1427822953),(173,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              URI: http://phalcon.local//api/v1/users',1427822953),(174,'Rest',1,'PHP Startup: Unable to load dynamic library \'/usr/lib/php5/20121212/phalcon.so\' - /usr/lib/php5/20121212/phalcon.so: undefined symbol: php_json_decode_ex File: Unknown Line:0',1427836058),(175,'Rest',2,'Conflict\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/sign',1427836062),(176,'Rest',1,'PHP Startup: Unable to load dynamic library \'/usr/lib/php5/20121212/phalcon.so\' - /usr/lib/php5/20121212/phalcon.so: undefined symbol: php_json_decode_ex File: Unknown Line:0',1427836062),(177,'Rest',2,'Conflict\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/sign',1427836070),(178,'Rest',1,'Undefined index: line File: /var/www/phalcon.local/Application/Helpers/Format.php Line:40',1427836460),(179,'Rest',2,'Conflict\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/sign',1427836492),(180,'Rest',2,'Conflict\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/sign',1427836505),(181,'Rest',1,'Undefined index: line File: /var/www/phalcon.local/Application/Helpers/Format.php Line:40',1427836513),(182,'Rest',1,'Undefined index: line File: /var/www/phalcon.local/Application/Helpers/Format.php Line:40',1427836608),(183,'Rest',1,'Undefined index: line File: /var/www/phalcon.local/Application/Helpers/Format.php Line:40',1427836882),(184,'Rest',1,'Undefined index: line File: /var/www/phalcon.local/Application/Helpers/Format.php Line:40',1427836911),(185,'Rest',1,'Undefined index: line File: /var/www/phalcon.local/Application/Helpers/Format.php Line:40',1427836963),(186,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/undefined/page',1427836973),(187,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/logs',1427836977),(188,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/users',1427836987),(189,'Rest',1,'Undefined index: line File: /var/www/phalcon.local/Application/Helpers/Format.php Line:40',1427836992),(190,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/sign',1427837315),(191,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/sign?login=stanisosddsdsv@gmail.com&password=stanisov@gmail.com',1427837366),(192,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/sign',1427837400),(193,'Rest',1,'Undefined index: line File: /var/www/phalcon.local/Application/Helpers/Format.php Line:40',1427837405),(194,'Rest',2,'SQLSTATE[42S22]: Column not found: 1054 Unknown column \'idq\' in \'where clause\'\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/sign',1427837687),(195,'Rest',1,'Call to a member function count() on a non-object File: /var/www/phalcon.local/Application/Services/Mappers/ErrorMapper.php Line:39',1427838355),(196,'Rest',1,'Call to a member function count() on a non-object File: /var/www/phalcon.local/Application/Modules/Rest/Validators/ResultSetValidator.php Line:150',1427838584),(197,'Rest',1,'Argument 1 passed to Application\\Modules\\Rest\\Exceptions\\BadRequestException::__construct() must be of the type array, string given, called in /var/www/phalcon.local/Application/Aware/ModelCrudAbstract.php on line 94 and defined File: /var/www/phalcon.local/Application/Modules/Rest/Exceptions/BadRequestException.php Line:37',1427838663),(198,'Rest',1,'Argument 1 passed to Application\\Modules\\Rest\\Exceptions\\BadRequestException::__construct() must be of the type array, string given, called in /var/www/phalcon.local/Application/Aware/ModelCrudAbstract.php on line 94 and defined File: /var/www/phalcon.local/Application/Modules/Rest/Exceptions/BadRequestException.php Line:37',1427838668),(199,'Rest',1,'Argument 1 passed to Application\\Modules\\Rest\\Exceptions\\BadRequestException::__construct() must be of the type array, string given, called in /var/www/phalcon.local/Application/Aware/ModelCrudAbstract.php on line 94 and defined File: /var/www/phalcon.local/Application/Modules/Rest/Exceptions/BadRequestException.php Line:37',1427838669),(200,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              URI: http://phalcon.local/api/v1/sign',1427838970);
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pages` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'Title of page',
  `content` text NOT NULL COMMENT 'HTML content',
  `alias` varchar(32) NOT NULL DEFAULT '' COMMENT 'URL slug',
  `date_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Create date',
  `date_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Update date',
  PRIMARY KEY (`id`),
  FULLTEXT KEY `ful_content` (`content`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES (1,'About','<p>This is about page content. I am edit storage text. EDITED2</p>','/pages/about','2015-01-22 00:30:05','2015-03-23 10:26:25'),(2,'Agreement','This is agreement page content','/pages/agreement','2015-01-22 00:32:41','2015-03-23 10:26:27'),(4,'Contacts','<p>This is contacs page content. EDITED</p>','/pages/contacts','2015-01-22 00:34:22','2015-03-23 10:26:30'),(5,'Help','<p>This is the help page</p>','/pages/help','2015-01-22 02:53:07','2015-03-23 10:26:32');
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_access`
--

DROP TABLE IF EXISTS `user_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_access` (
  `user_id` int(11) unsigned NOT NULL,
  `token` varchar(255) NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `user_access_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_access`
--

LOCK TABLES `user_access` WRITE;
/*!40000 ALTER TABLE `user_access` DISABLE KEYS */;
INSERT INTO `user_access` VALUES (10,'$2a$08$92O2QYDuGCXoKtUz2Pf8mOiq0aYDLRBGteX2m7S.uraQ1VgQdIehi','2015-04-07 17:29:13'),(11,'$2a$08$pvwjzQ.5C2L3ZLAjpZaldu7XMaSpoyQ.anlai/b/SHwslujzUAFNG','2015-04-07 17:29:13'),(12,'78df0928b91ec774abb2a651d8c1ffab','2015-03-01 13:37:59'),(13,'c26e866b05c4b60b48968a55154187da','2015-02-15 14:36:58'),(14,'e95b8b637146bc43325c9df2fd1a0ab4','2015-03-16 05:45:43'),(15,'3928c95e57ec4b61d2af55b36cfd6e01','2015-03-16 05:48:23'),(16,'643bd3a1ce3090d14f9a59d0c45ad354','2015-03-16 05:51:12'),(17,'1c94392e83ea494e4060b6a3ac651e6c','2015-03-16 05:54:21'),(18,'685c2403f2e977a5e02f8ed36c0e22d0','2015-03-16 05:55:23'),(19,'283108b3ee610cef11e51aa12cb697fc','2015-03-16 05:57:00'),(20,'27906fadb0f3bdade5a0cb8d3846611c','2015-03-16 05:59:14'),(21,'70accea75c068e1ed0e9adc4aa99acd9','2015-03-16 06:03:03'),(22,'6b67c6230eb9d646d583a29d19292bd8','2015-03-16 06:34:23'),(23,'ffbd44b314d83a442a49c56ef9f74af7','2015-03-16 07:01:05'),(24,'627761113ed88e4a56eb6189def3e651','2015-03-16 07:02:25'),(25,'f222918ddb53cc11d5905c45c865dc78','2015-03-16 07:04:33'),(26,'073626d8d6b3bacd3c4ad040406979d6','2015-03-16 07:05:48'),(30,'632a7cc5792dfe4c57106bd821402bf4','2015-03-16 07:20:57'),(31,'3fe372c2f39619966384ab84f6894518','2015-03-16 07:43:18'),(32,'210056b2ac1fc6071520c0c0b2b5f979','2015-03-19 02:13:37'),(33,'d2516319f860cd17283f8ffae47d47f6','2015-03-16 21:57:41'),(34,'$2a$08$PbKDhDPHitTnswhak8W//exO4CLiefSt3aR72pNWKXO0WJ.jFfpni','2015-04-07 11:23:17'),(35,'$2a$08$/PFLE8I5mYUj.HIoGfs6luEiVn9zTrPmUYgHiqqnUWmwXzEmgDAxy','2015-04-07 11:24:06'),(36,'$2a$08$6EupB84BZeBK6BZLQSjTXecMQ/Eg.dYNo962d9eYn7zrpxibK85/O','2015-04-07 12:21:21'),(37,'$2a$08$wN//uhFgWnchQAdiKOp9eO7pM5GlNm2x3pZHgBNT7yYPnkWZcAepS','2015-04-07 12:24:12'),(38,'$2a$08$aLsi3TaKmFFJc5Y4VCmwbe4esiRRwtYRhEfDyYg3SPw9qXnd9U/b2','2015-04-07 14:27:55'),(39,'$2a$08$MLfJr8pGzNos5CrzDrrDeusE5ZH.11BsQbM7AhOcwZ/Qo3bL3Wt4.','2015-04-07 14:28:30'),(40,'$2a$08$qnFlgvZtNBy..anoepICP.9QygytLA81CvQxbbg5Yji/qq01ONDn2','2015-04-07 14:28:54'),(41,'$2a$08$jaDg1uGBGroRkSI17umX8.Ua.gbEIsgDMbmGNd4Bm4rv/XDwXAZ9W','2015-04-07 14:29:12'),(42,'$2a$08$9CUJ6aCg7rn9kDAOF/vmje/VhnpnkbKzyGKKsd2hjFUa1VOG5l3Km','2015-04-07 14:29:46'),(43,'$2a$08$iwFwFqt4HefevArgr8lJNev1Zx8tE8idLs96p8VDi9G5Sa3ORU8cu','2015-04-07 14:30:15'),(44,'$2a$08$d8kuBcJHjU/ZeMcD.0ln8utB4t2nJD09kW65pBnejn1nml69DLX1O','2015-04-07 14:30:47'),(45,'$2a$08$1iONIkKmmbz63VktW3O4nOpm/szsn682DH39qPRE8SwkAyPh92Zbu','2015-04-07 14:30:53'),(46,'$2a$08$JofjRtUGBnSvd6OyJRFdF.Eh764wWyFNCEuaFKxmgy9XzmRaetFJu','2015-04-07 15:43:05'),(47,'$2a$08$HgQqN2FJfaifmm2HhiCmV.ZCyABm5yqqLVCFyXMjtVBU43c6tmOVy','2015-04-07 15:52:37'),(48,'$2a$08$/12JHmfWhs9IZJQu9BMiEOukEFxabPNifRhmbTr7A667MLR/F3t/y','2015-04-07 17:29:13'),(49,'$2a$08$kh.3Ej.yqyvM5PcE0NLsdOr1d8NVmjOsTYBxIDT.e8wB7srMxCXXq','2015-04-08 00:07:38'),(50,'$2a$08$H/QpOznNOsZnF6wJYdTEueIeZCrPsKk4iFE9Jmv6trFfM4FBZV.Ia','2015-04-08 00:15:13'),(51,'$2a$08$3Nw17yjWTLiSD.rAlzbLoOqk/J1gG7SnII.bmfDFPdWAm8h0IlA8u','2015-04-08 00:16:48');
/*!40000 ALTER TABLE `user_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_roles` (
  `id` tinyint(1) unsigned NOT NULL,
  `name` varchar(45) DEFAULT NULL COMMENT 'User Roles table',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 MAX_ROWS=5;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` VALUES (0,'User'),(1,'Admin');
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'User ID',
  `login` varchar(40) NOT NULL DEFAULT '' COMMENT 'User login',
  `name` varchar(40) NOT NULL DEFAULT '' COMMENT 'User name',
  `surname` varchar(40) NOT NULL DEFAULT '' COMMENT 'User surname',
  `password` varchar(150) NOT NULL DEFAULT '' COMMENT 'Password hash',
  `role` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `state` enum('0','1','2') NOT NULL DEFAULT '0' COMMENT 'Activity state, 0 - disabled, 1 - active, 2 - banned',
  `rating` decimal(10,0) unsigned NOT NULL DEFAULT '0' COMMENT 'User rating',
  `ip` int(10) unsigned NOT NULL COMMENT 'IP addres',
  `ua` varchar(255) NOT NULL COMMENT 'User agent',
  `date_registration` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Registration date',
  `date_lastvisit` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last visit date',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_login` (`login`),
  KEY `idx_state` (`state`),
  KEY `idx_role` (`role`) USING BTREE,
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role`) REFERENCES `user_roles` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COMMENT='Common users table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (10,'stanisov@gmail.com','Stanislav','','$2a$08$iEW6wG7tgQzcw1L9TG9Iw.HXvo6HgYCuovp7x2i3aYQc5c3hLGBQi',1,'0',0,2130706433,'Symfony2 BrowserKit','2015-02-02 12:30:28','2015-03-31 21:34:30'),(11,'user@gmail.com','stanisovw@gmail.com','','$2a$08$n9WNEktlDCbVqPZ8faZzVOvPuoi4XZr2beSusccYt6GKpatmPsTT2',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-02-21 04:31:14','2015-03-31 14:29:13'),(12,'stanisov2@gmail.com','stanisov2@gmail.com','','$2a$08$WLHJJKcAFndE7mtuqcEYeOaIIjcGikfK1zNjGAGcmDiWEU.ya9mSy',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.111 Safari/537.36','2015-02-22 13:37:59','2015-02-22 11:37:59'),(13,'stanisov3@gmail.com','stanisov3@gmail.com','','$2a$08$ffWFo.DHPzZC1El/tlDfb.e4v6eG1/UgtacL/adtjCAf0wXcRqbNK',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.111 Safari/537.36','2015-02-22 14:36:52','2015-02-22 12:36:52'),(14,'stanisov4@gmail.com','dcdcdcdcdc','','wwwwww',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 05:45:43','2015-03-09 03:45:43'),(15,'sdsdsdsd@sdsdsd.ua','sssssss','','sssssss',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 05:48:23','2015-03-09 03:48:23'),(16,'qstanisov@gmail.com','qqqqqq','','qqqqqq',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 05:51:12','2015-03-09 03:51:12'),(17,'ssss@mail.ua','ssss@mail.ua','','ssss@mail.ua',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 05:54:21','2015-03-09 03:54:21'),(18,'sss2@mail.ua','ssss@mail.ua','','ssss@mail.ua',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 05:55:23','2015-03-09 03:55:23'),(19,'stanisov44@gmail.com','stanisov4@gmail.com','','stanisov4@gmail.com',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 05:57:00','2015-03-09 03:57:00'),(20,'sssdsd2@msdsd.uA','sssdsd2@msdsd.uA','','sssdsd2@msdsd.uA',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 05:59:14','2015-03-09 03:59:14'),(21,'asasas@mail.fj','asasas@mail.fj','','asasas@mail.fj',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 06:03:03','2015-03-09 04:03:03'),(22,'asasa@sdsdsd.er','asasa@sdsdsd.er','','asasa@sdsdsd.er',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 06:34:23','2015-03-09 04:34:23'),(23,'asassfdf@sds.ua','asassfdf@sds.ua','','$2a$08$yWl8VCT1yCfkac8a5gVfeuLnLnAlmpobG7euC6w2BV85NaJjEBrym',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 07:01:05','2015-03-09 05:01:05'),(24,'credential@sdsdsd.ua','$credential@sdsdsd.ua','','$2a$08$70SWdTIlqfBx.59c1GpvQORFGOrj5H6p83BQbCBUABjJcoEa6O8mi',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 07:02:25','2015-03-09 05:02:25'),(25,'stanisovddddd@mail.ewe','stanisovddddd@mail.ewe','','$2a$08$y4P38MNLvUl3k3L0OmF6LeYd0N1bA4pGKEkO54fuOxjzYuKSO7Nv2',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 07:04:33','2015-03-09 05:04:33'),(26,'sdsfgfgfl@ksds.ua','sdsfgfgfl@ksds.ua','','$2a$08$XRFx3poEIMT7wn0dKoMiyeSNynu/BAfgAQbbG95LL0G4Psp/QOHQ2',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 07:05:48','2015-03-09 05:05:48'),(27,'dsdsffgfg@mail.cu','dsdsffgfg@mail.cu','','$2a$08$XdG3lDu.o0XVRN/lOp0zyOyDGxY/TDLmtVjO7GwJQMqTioU8.HKG.',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 07:07:36','2015-03-09 05:07:36'),(28,'gfhgfh@dfdfd.ia','gfhgfh@dfdfd.ia','','$2a$08$WiKNINxRZGHm8cD1esGtieRfNnqA2PgaGi729KPvDBhnazoah/O.e',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 07:14:58','2015-03-09 05:14:58'),(29,'rer@erer2.ua','rer@erer','','$2a$08$eW3FlhO32GSrTgclk3evQOUMzdBx0VqTTBYIxAuRUGFJ6tszn6FLO',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 07:17:51','2015-03-09 05:17:51'),(30,'fdsgf@asdsa.ua','fdsgf@asdsa.ua','','$2a$08$QNBEocj/fytqlnM2x3qNkeiRh2uRnLnCgEz2eKr9gZZ4ahKJP6sSC',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 07:20:57','2015-03-09 05:20:57'),(31,'ddffff@mail.ru','ddffff@mail.ru','','$2a$08$vzeuVMFudlFKdi/wERuR4Ov4Dy6BH8Zn2Qf1IDnGburGzsLWQaYUe',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 07:22:46','2015-03-09 05:22:46'),(32,'ddffff@mail.ru2','ddffff@mail.ru2','','$2a$08$G1DYLGCUb14lr5hNy/e83uOPYK3VlRmpAXPDiDcSXNUi1VLjdPQJe',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 07:43:32','2015-03-12 00:13:37'),(33,'ddffff@mail.ru22','ddffff@mail.ru22','','$2a$08$V.SUyESC46HEmOtvmEXRLeiX.6TLxYcClLR93x42KkNT/m2AQy8rS',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 07:45:37','2015-03-09 05:45:37'),(34,'stanisovwewwew@gmail.com','stanisov@gmail.com','','$2a$08$M.NVYcQeTbp7NBNwR4qTdOKmg.0KYBriIvmhpT/M2Aiz52aEP1.7C',0,'0',0,2130706433,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36','2015-03-31 14:23:17','2015-03-31 11:23:17'),(35,'1980634175@1469152825.com','CodeceptionTester','','$2a$08$I1Mq.lVWgM7ScFnLIdSnTOR4qq0xw.EOUX1PYqWIy.MSBg.UDa5Om',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-03-31 14:24:06','2015-03-31 11:24:06'),(36,'stanisov2@wewgmail.com','stanisov@gmail.com','','$2a$08$7JjHP0/vp9zGGDbKnl3dZOGA9l3syPjR1nm0KTvL.bYc5EpjLltqq',0,'0',0,2130706433,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36','2015-03-31 15:21:21','2015-03-31 12:21:21'),(37,'stanis2ov2@wewgmail.com','stanisov@gmail.com','','$2a$08$J0UJFK2p9ZHpJPLYRIjHTO68LtqoTUuXxrojOf92HlCYDR1ru.wCS',0,'0',0,2130706433,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36','2015-03-31 15:24:12','2015-03-31 12:24:12'),(38,'stanisov232@wewgmail.com','stanisov@gmail.com','','$2a$08$e7wSzmRRlAIs.9SIWuuMr.TaPJ8wgF09dtwdFLPaoboqb7C1OwSIK',0,'0',0,2130706433,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36','2015-03-31 17:27:55','2015-03-31 14:27:55'),(39,'stanisov2232@wewgmail.com','stanisov@gmail.com','','$2a$08$gsPEBHk0HJH/meaJgdE2keAL/rgXwfWZLvK2g5nWAKI4kEYWtfzXG',0,'0',0,2130706433,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36','2015-03-31 17:28:30','2015-03-31 14:28:30'),(40,'stanisov22232@wewgmail.com','stanisov@gmail.com','','$2a$08$ydcK5r5tWRE967qyGcmjDeFGJHdyPOMlVFJaVknqcuz6J0OpZ25Am',0,'0',0,2130706433,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36','2015-03-31 17:28:54','2015-03-31 14:28:54'),(41,'stanis1ov22232@wewgmail.com','stanisov@gmail.com','','$2a$08$Ixua.kzkRevn5/9nqOLwXeYNOohodv3QthiolVYU3vJ5qy2Xu2B/W',0,'0',0,2130706433,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36','2015-03-31 17:29:12','2015-03-31 14:29:12'),(42,'stanis1ov22232@we3wgmail.com','stanisov@gmail.com','','$2a$08$zRmkBEq5mZYBPLcUlgHxZeE3jMt8HkYr7rzEJPk10L3dAtR8YJuWO',0,'0',0,2130706433,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36','2015-03-31 17:29:46','2015-03-31 14:29:46'),(43,'stnis1ov22232@we3wgmail.com','stanisov@gmail.com','','$2a$08$5LdfVKXBdATLpQHVzwt4JO95oK/4LaWAGjBD1QQS7TwODChbQUZZO',0,'0',0,2130706433,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36','2015-03-31 17:30:15','2015-03-31 14:30:15'),(44,'stnis1ov222332@we3wgmail.com','stanisov@gmail.com','','$2a$08$2BJmgPcoKaIL31sgGYAgXuiWqr4qrgtEHXFm1sD0qauyQh2EirgY.',0,'0',0,2130706433,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36','2015-03-31 17:30:47','2015-03-31 14:30:47'),(45,'stnis12ov222332@we3wgmail.com','stanisov@gmail.com','','$2a$08$dCRUlbFlG0u7bP6gH7MTm.mDHo/nArE.ZkeSYx3PbVMDRsKSPfLD6',0,'0',0,2130706433,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36','2015-03-31 17:30:53','2015-03-31 14:30:53'),(46,'1356546924@38359461.com','CodeceptionTester','','$2a$08$bk3I53NsgEcl8cHhaovcZukQNXDrduPsXkhKnrytuTA9gDmBUTfNC',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-03-31 18:43:05','2015-03-31 15:43:05'),(47,'1503413079@1472169146.com','CodeceptionTester','','$2a$08$ex20i7n9dS8vu2UrNNkDieTRFB47VLZo.n/Eu7igaqJQ.8Q3vvKPC',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-03-31 18:52:37','2015-03-31 15:52:37'),(48,'151669929@625129123.com','CodeceptionTester','','$2a$08$Qn7JisY1iboqIFO7BPH.gOo4DbaggKld0nFe.jcdJTSid.B1fjGoK',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-03-31 20:29:13','2015-03-31 17:29:13'),(49,'test@mail.ruww','StanislavTester','','$2a$08$zj5uVbwNahlGr9Y5lXr2x.4GYcT0Yh69srrYw69BkBeSs7fB7ng6S',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-04-01 00:07:38','2015-03-31 21:07:38'),(50,'teqqst@mail.ruww','StanislavTesqter','','$2a$08$09KhAvZOmEfmwT3cwj8S5.AHf6L9ncHT88VXFg2ZORT.rT7tsD5DO',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-04-01 00:15:13','2015-03-31 21:15:13'),(51,'testuser@qmail.ru','StanislavTester','','$2a$08$jixQpjJtU69X6QUQYk1wP.hESGHGsUZqBe4LKB7DEZ2x4GpttXk1G',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-04-01 00:16:48','2015-03-31 21:16:48');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'phalcon.local'
--

--
-- Dumping routines for database 'phalcon.local'
--
/*!50003 DROP FUNCTION IF EXISTS `REBUILD_TREE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `REBUILD_TREE`() RETURNS int(11)
    MODIFIES SQL DATA
    DETERMINISTIC
BEGIN
    -- Изначально сбрасываем все границы в NULL
    UPDATE categories t SET lft = NULL, rgt = NULL;
    
    -- Устанавливаем границы корневым элементам
    SET @i := 0;
    UPDATE categories t SET lft = (@i := @i + 1), rgt = (@i := @i + 1)
    WHERE t.parent_id IS NULL;

    forever: LOOP
        -- Находим элемент с минимальной правой границей -- самый левый в дереве
        SET @parent_id := NULL;
        SELECT t.id, t.rgt FROM categories t, categories tc
        WHERE t.id = tc.parent_id AND tc.lft IS NULL AND t.rgt IS NOT NULL
        ORDER BY t.rgt LIMIT 1 INTO @parent_id, @parent_right;

        -- Выходим из бесконечности, когда у нас уже нет незаполненных элементов
        IF @parent_id IS NULL THEN LEAVE forever; END IF;

        -- Сохраняем левую границу текущего ряда
        SET @current_left := @parent_right;

        -- Вычисляем максимальную правую границу текущего ряда
        SELECT @current_left + COUNT(*) * 2 FROM categories
        WHERE parent_id = @parent_id INTO @parent_right;

        -- Вычисляем длину текущего ряда
        SET @current_length := @parent_right - @current_left;

        -- Обновляем правые границы всех элементов, которые правее
        UPDATE categories t SET rgt = rgt + @current_length
        WHERE rgt >= @current_left ORDER BY rgt;

        -- Обновляем левые границы всех элементов, которые правее
        UPDATE categories t SET lft = lft + @current_length
        WHERE lft > @current_left ORDER BY lft;

        -- И только сейчас обновляем границы текущего ряда
        SET @i := (@current_left - 1);
        UPDATE categories t SET lft = (@i := @i + 1), rgt = (@i := @i + 1)
        WHERE parent_id = @parent_id ORDER BY id;
    END LOOP;

    -- Возвращаем самый самую правую границу для дальнейшего использования
    RETURN (SELECT MAX(rgt) FROM categories t);
END ;;
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

-- Dump completed on 2015-04-01  3:28:04
