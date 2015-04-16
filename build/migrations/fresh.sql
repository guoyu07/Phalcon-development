# ************************************************************
# Sequel Pro SQL dump
# Версия 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Адрес: 127.0.0.1 (MySQL 5.6.22)
# Схема: phalcon.local
# Время создания: 2015-04-16 09:35:50 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Дамп таблицы categories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categories`;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;

INSERT INTO `categories` (`id`, `title`, `description`, `alias`, `parent_id`, `lft`, `rgt`, `sort`, `date_create`, `date_update`, `visibility`)
VALUES
	(103,'2323','<p>2323232323232322322323232323322323232323323323</p>','233232323',NULL,1,2,23,'2015-03-06 23:46:29','2015-03-06 23:46:29',1);

/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;


# Дамп таблицы currency
# ------------------------------------------------------------

DROP TABLE IF EXISTS `currency`;

CREATE TABLE `currency` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Currency ID',
  `code` char(3) NOT NULL COMMENT 'Currency Code',
  `name` varchar(45) NOT NULL,
  `symbol` varchar(4) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_code` (`code`) COMMENT 'Unique code'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `currency` WRITE;
/*!40000 ALTER TABLE `currency` DISABLE KEYS */;

INSERT INTO `currency` (`id`, `code`, `name`, `symbol`)
VALUES
	(1,'USD','USA Dollar','$'),
	(2,'RUR','Российский рубль','руб.'),
	(3,'EUR','Euro','€'),
	(4,'UAH','Украинская гривна','₴'),
	(5,'GBP','British Pound','£'),
	(6,'JPY','Японская иена','¥');

/*!40000 ALTER TABLE `currency` ENABLE KEYS */;
UNLOCK TABLES;


# Дамп таблицы engines
# ------------------------------------------------------------

DROP TABLE IF EXISTS `engines`;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 MAX_ROWS=10;

LOCK TABLES `engines` WRITE;
/*!40000 ALTER TABLE `engines` DISABLE KEYS */;

INSERT INTO `engines` (`id`, `name`, `description`, `host`, `code`, `token`, `logo`, `currency_id`, `status`, `date_create`, `date_update`)
VALUES
	(1,'Phalcon Shop','<p>This is the simple Phalcon Shop</p>','phalcon.local','PHL','232334454','logo-mysql-110x57.png',4,1,'2015-01-03 02:27:22','2015-03-21 14:50:11'),
	(10,'eBay','<p>ebay Description2</p>','ebay.com','EBY','','eBay-Logo.gif',1,2,'2015-03-06 12:24:17','2015-03-06 23:23:31');

/*!40000 ALTER TABLE `engines` ENABLE KEYS */;
UNLOCK TABLES;


# Дамп таблицы engines_categories_rel
# ------------------------------------------------------------

DROP TABLE IF EXISTS `engines_categories_rel`;

CREATE TABLE `engines_categories_rel` (
  `engine_id` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT 'to engines.id rel',
  `category_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'to categories.id rel',
  PRIMARY KEY (`engine_id`,`category_id`),
  KEY `idx_category_id` (`category_id`),
  KEY `idx_engine_id` (`engine_id`),
  CONSTRAINT `fk_category_id` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `engines_categories_rel` WRITE;
/*!40000 ALTER TABLE `engines_categories_rel` DISABLE KEYS */;

INSERT INTO `engines_categories_rel` (`engine_id`, `category_id`)
VALUES
	(1,103);

/*!40000 ALTER TABLE `engines_categories_rel` ENABLE KEYS */;
UNLOCK TABLES;


# Дамп таблицы errors
# ------------------------------------------------------------

DROP TABLE IF EXISTS `errors`;

CREATE TABLE `errors` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Error ID',
  `code` varchar(65) NOT NULL DEFAULT '' COMMENT 'Error Code',
  `description` text NOT NULL COMMENT 'Description',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_code` (`code`) COMMENT 'Unique code'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `errors` WRITE;
/*!40000 ALTER TABLE `errors` DISABLE KEYS */;

INSERT INTO `errors` (`id`, `code`, `description`)
VALUES
	(1,'RECORDS_NOT_FOUND','Means that the requested record does not exist'),
	(2,'FILTERS_IS_NOT_SUPPORT','Means that you can not use this filter in the query string'),
	(3,'LANGUAGE_IS_NOT_SUPPORT','Means that you specify the localization is not used in our system'),
	(4,'EMPTY_PARAMETER_IN_URI','Means that you can not use the argument of the query string without its value'),
	(5,'INVALID_COLUMNS','Means that in a query, you can not do the sample for the specified fields'),
	(6,'INVALID_REQUIRED_FIELDS','Means that in a query, you must use the specified fields'),
	(7,'LONG_REQUEST','Means that the query string is too big for the request'),
	(8,'CONTENT_IS_NOT_SUPPORT','Means that you requested content type is not supported in the system'),
	(9,'AUTH_ACCESS_REQUIRED','Means that the requested resource requires authorization by token'),
	(10,'ACCESS_DENIED','Means that the need for the requested resource rights that you do not have'),
	(11,'UNAUTHORIZED_REQUEST','Means that the server rejected your request because you are not using the correct data authorization\n'),
	(12,'USER_NOT_FOUND','Means that the user you have requested the system does not have'),
	(13,'USER_EXIST','Means that you are trying to add a user to a system that already exists in'),
	(14,'LOGIN_REQUIRED','Means that the login is absolutely necessary'),
	(15,'PASSWORD_REQUIRED','Means that the password is absolutely necessary'),
	(16,'LOGIN_MAX_INVALID','Means that the login is too large'),
	(17,'LOGIN_MIX_INVALID','Means that the login is too small'),
	(18,'NAME_MAX_INVALID','Means that the name is too large'),
	(19,'NAME_MIN_INVALID','Means that the name is too small'),
	(20,'LOGIN_FORMAT_INVALID','Means that the login have not correct format. Note the error message and bring it to the specified format'),
	(21,'FIELD_IS_REQUIRED','Means that you may have missed the parameters that are necessary to update or add records'),
	(22,'RECOVERY_ACCESS_FAILED','Fail restore user access. May be service temporary unavailable. Try again later');

/*!40000 ALTER TABLE `errors` ENABLE KEYS */;
UNLOCK TABLES;


# Дамп таблицы logs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `logs`;

CREATE TABLE `logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL,
  `type` tinyint(3) unsigned NOT NULL,
  `content` varchar(512) NOT NULL,
  `created_at` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=ARCHIVE DEFAULT CHARSET=utf8;

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;

INSERT INTO `logs` (`id`, `name`, `type`, `content`, `created_at`)
VALUES
	(1,'Rest',1,'Expected response code 235 but got code \"535\", with message \"535-5.7.8 Username and Password not accepted. Learn more at\r\n535 5.7.8 http://support.google.com/mail/bin/answer.py?answer=14257 a7sm322881lbc.48 - gsmtp\r\n\"',1427962296),
	(2,'Rest',1,'Call to a member function count() on a non-object File: /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/ErrorMapper.php Line:39',1427962296),
	(3,'Rest',1,'Expected response code 235 but got code \"535\", with message \"535-5.7.8 Username and Password not accepted. Learn more at\r\n535 5.7.8 http://support.google.com/mail/bin/answer.py?answer=14257 gh10sm91695lbc.15 - gsmtp\r\n\"',1427962299),
	(4,'Rest',1,'Call to a member function count() on a non-object File: /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/ErrorMapper.php Line:39',1427962299),
	(5,'Rest',1,'Expected response code 235 but got code \"535\", with message \"535-5.7.8 Username and Password not accepted. Learn more at\r\n535 5.7.8 http://support.google.com/mail/bin/answer.py?answer=14257 t9sm890304laz.21 - gsmtp\r\n\"',1427962308),
	(6,'Rest',1,'Call to a member function count() on a non-object File: /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/ErrorMapper.php Line:39',1427962308),
	(7,'Rest',1,'Expected response code 235 but got code \"535\", with message \"535-5.7.8 Username and Password not accepted. Learn more at\r\n535 5.7.8 http://support.google.com/mail/bin/answer.py?answer=14257 us1sm889741lbc.1 - gsmtp\r\n\"',1427962469),
	(8,'Rest',2,'Unprocessable Entity\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1427962469),
	(9,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=id%2Ctitle%2Cwrong',1427962501),
	(10,'Rest',2,'Forbidden\n              IP: 127.0.0.1\n              Refer: http://phalcon.local/api/v1/sign?login=user%40gmail.com&password=user%40gmail.com\n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1427962501),
	(11,'Rest',2,'Request URI Too Long\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',1427962501),
	(12,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1427962501),
	(13,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/undefined/page',1427962501),
	(14,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/sign',1427962501),
	(15,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1427962501),
	(16,'Rest',1,'Expected response code 235 but got code \"535\", with message \"535-5.7.8 Username and Password not accepted. Learn more at\r\n535 5.7.8 http://support.google.com/mail/bin/answer.py?answer=14257 q7sm895909lag.6 - gsmtp\r\n\"',1427962834),
	(17,'Rest',2,'Unprocessable Entity\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1427962834),
	(18,'Rest',1,'Call to a member function count() on a non-object File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Validators/ResultSetValidator.php Line:150',1427963790),
	(19,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov@gmail.com&password=stanisov@gmail.com',1427965101),
	(20,'Rest',1,'Call to a member function count() on a non-object File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Validators/ResultSetValidator.php Line:150',1427965492),
	(21,'Rest',1,'Undefined index: limit File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestService.php Line:184',1427965507),
	(22,'Rest',1,'Undefined index: limit File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestService.php Line:184',1427965571),
	(23,'Rest',1,'Undefined index: message File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestService.php Line:195',1427965682),
	(24,'Rest',1,'Undefined index: limit File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestService.php Line:184',1427965709),
	(25,'Rest',1,'Undefined index: limit File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestService.php Line:184',1427965737),
	(26,'Rest',1,'Undefined index: limit File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestService.php Line:184',1427965758),
	(27,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=stanisov%40gmail.com',1427966828),
	(28,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=stanisov%40gmail.com',1427966828),
	(29,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=stanisov%40gmail.com',1427966828),
	(30,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=id%2Ctitle%2Cwrong',1427966828),
	(31,'Rest',2,'Forbidden\n              IP: 127.0.0.1\n              Refer: http://phalcon.local/api/v1/sign?login=user%40gmail.com&password=user%40gmail.com\n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1427966828),
	(32,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=stanisov%40gmail.com',1427966828),
	(33,'Rest',2,'Request URI Too Long\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',1427966828),
	(34,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1427966828),
	(35,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/undefined/page',1427966828),
	(36,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/sign',1427966828),
	(37,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1427966828),
	(38,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=stanisov%40gmail.com',1427966829),
	(39,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=stanisov%40gmail.com',1427966829),
	(40,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1427966879),
	(41,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1427966919),
	(42,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=id%2Ctitle%2Cwrong',1427966960),
	(43,'Rest',2,'Forbidden\n              IP: 127.0.0.1\n              Refer: http://phalcon.local/api/v1/sign?login=user%40gmail.com&password=user%40gmail.com\n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1427966960),
	(44,'Rest',2,'Request URI Too Long\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',1427966961),
	(45,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1427966961),
	(46,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/undefined/page',1427966961),
	(47,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/sign',1427966961),
	(48,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1427966961),
	(49,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=id%2Ctitle%2Cwrong',1427966986),
	(50,'Rest',2,'Forbidden\n              IP: 127.0.0.1\n              Refer: http://phalcon.local/api/v1/sign?login=user%40gmail.com&password=user%40gmail.com\n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1427966986),
	(51,'Rest',2,'Request URI Too Long\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',1427966987),
	(52,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1427966987),
	(53,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/undefined/page',1427966987),
	(54,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/sign',1427966987),
	(55,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1427966987),
	(56,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=id%2Ctitle%2Cwrong',1427967270),
	(57,'Rest',2,'Forbidden\n              IP: 127.0.0.1\n              Refer: http://phalcon.local/api/v1/sign?login=user%40gmail.com&password=user%40gmail.com\n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1427967270),
	(58,'Rest',2,'Request URI Too Long\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',1427967270),
	(59,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1427967270),
	(60,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/undefined/page',1427967270),
	(61,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/sign',1427967270),
	(62,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1427967270),
	(63,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=id%2Ctitle%2Cwrong',1427973483),
	(64,'Rest',2,'Forbidden\n              IP: 127.0.0.1\n              Refer: http://phalcon.local/api/v1/sign?login=user%40gmail.com&password=user%40gmail.com\n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1427973483),
	(65,'Rest',2,'Request URI Too Long\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',1427973484),
	(66,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1427973484),
	(67,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/undefined/page',1427973484),
	(68,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/sign',1427973484),
	(69,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1427973484),
	(70,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1427973633),
	(71,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: DELETE\n              URI: http://phalcon.local/api/v1/sign/1',1427973713),
	(72,'Rest',1,'Undefined class constant \'REQUEST_KEY\' File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Aware/RestSecurityProvider.php Line:140',1427973842),
	(73,'Rest',1,'Undefined class constant \'REQUEST_KEY\' File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Aware/RestSecurityProvider.php Line:140',1427973843),
	(74,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=id%2Ctitle%2Cwrong',1427973846),
	(75,'Rest',1,'Undefined class constant \'REQUEST_KEY\' File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Aware/RestSecurityProvider.php Line:140',1427973846),
	(76,'Rest',1,'Undefined class constant \'REQUEST_KEY\' File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Aware/RestSecurityProvider.php Line:140',1427973846),
	(77,'Rest',2,'Request URI Too Long\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',1427973846),
	(78,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1427973846),
	(79,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/undefined/page',1427973846),
	(80,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/sign',1427973846),
	(81,'Rest',1,'Undefined class constant \'REQUEST_KEY\' File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Aware/RestSecurityProvider.php Line:140',1427973846),
	(82,'Rest',1,'Undefined class constant \'REQUEST_KEY\' File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Aware/RestSecurityProvider.php Line:140',1427973846),
	(83,'Rest',1,'Undefined class constant \'REQUEST_KEY\' File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Aware/RestSecurityProvider.php Line:140',1427973846),
	(84,'Rest',1,'Undefined class constant \'REQUEST_KEY\' File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Aware/RestSecurityProvider.php Line:140',1427973903),
	(85,'Rest',1,'Undefined class constant \'REQUEST_KEY\' File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Aware/RestSecurityProvider.php Line:140',1427973905),
	(86,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=id%2Ctitle%2Cwrong',1427973937),
	(87,'Rest',2,'Forbidden\n              IP: 127.0.0.1\n              Refer: http://phalcon.local/api/v1/sign?login=user%40gmail.com&password=user%40gmail.com\n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1427973937),
	(88,'Rest',2,'Request URI Too Long\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',1427973937),
	(89,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1427973937),
	(90,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/undefined/page',1427973937),
	(91,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/sign',1427973937),
	(92,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1427973937),
	(93,'Rest',1,'Undefined class constant \'REQUEST_KEY\' File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Aware/RestSecurityProvider.php Line:164',1427973971),
	(94,'Rest',1,'Undefined class constant \'REQUEST_KEY\' File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Aware/RestSecurityProvider.php Line:164',1427973971),
	(95,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=id%2Ctitle%2Cwrong',1427973973),
	(96,'Rest',1,'Undefined class constant \'REQUEST_KEY\' File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Aware/RestSecurityProvider.php Line:164',1427973974),
	(97,'Rest',1,'Undefined class constant \'REQUEST_KEY\' File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Aware/RestSecurityProvider.php Line:164',1427973974),
	(98,'Rest',2,'Request URI Too Long\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',1427973974),
	(99,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1427973974),
	(100,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/undefined/page',1427973974),
	(101,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/sign',1427973974),
	(102,'Rest',1,'Undefined class constant \'REQUEST_KEY\' File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Aware/RestSecurityProvider.php Line:164',1427973974),
	(103,'Rest',1,'Undefined class constant \'REQUEST_KEY\' File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Aware/RestSecurityProvider.php Line:164',1427973974),
	(104,'Rest',1,'Undefined class constant \'REQUEST_KEY\' File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Aware/RestSecurityProvider.php Line:164',1427973974),
	(105,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: DELETE\n              URI: http://phalcon.local/api/v1/sign/1',1427974056),
	(106,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: DELETE\n              URI: http://phalcon.local/api/v1/sign/1',1427974131),
	(107,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: DELETE\n              URI: http://phalcon.local/api/v1/sign/1',1427974165),
	(108,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: POST\n              URI: http://phalcon.local/api/v1/sign',1427974592),
	(109,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/users/73',1427974659),
	(110,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/users/73',1427974700),
	(111,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/users/73',1427974714),
	(112,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1427974790),
	(113,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1427974796),
	(114,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov@gmail.com&password=serer',1427974841),
	(115,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov@gmail.com',1427974917),
	(116,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisoewv@gmail.com',1427975011),
	(117,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisoewv@gmail.com@password=weewew',1427975020),
	(118,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisoewv@gmail.com&password=weewew',1427975028),
	(119,'Rest',2,'Column \'id\' doesn\'t belong to any of the selected models (1), when preparing: SELECT [Application\\Models\\UserAccess].* FROM [Application\\Models\\UserAccess] WHERE id = ?0\n              IP: 127.0.0.1\n              Refer: \n              Method: DELETE\n              URI: http://phalcon.local/api/v1/sign/1',1427981585),
	(120,'Rest',1,'syntax error, unexpected \';\' File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestSecurityService.php Line:150',1427981653),
	(121,'Rest',1,'syntax error, unexpected \';\' File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestSecurityService.php Line:151',1427981665),
	(122,'Rest',1,'syntax error, unexpected \';\' File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestSecurityService.php Line:151',1427981674),
	(123,'Rest',2,'SQLSTATE[42000]: Syntax error or access violation: 1064 You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \':0\' at line 1\n              IP: 127.0.0.1\n              Refer: \n              Method: DELETE\n              URI: http://phalcon.local/api/v1/sign/1',1427981732),
	(124,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: DELETE\n              URI: http://phalcon.local/api/v1/sign/11',1427982424),
	(125,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: DELETE\n              URI: http://phalcon.local/api/v1/sign/13',1427982710),
	(126,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: DELETE\n              URI: http://phalcon.local/api/v1/sign/13',1427982711),
	(127,'Rest',1,'syntax error, unexpected \';\' File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestSecurityService.php Line:264',1427983503),
	(128,'Rest',1,'Call to undefined method Application\\Modules\\Rest\\Services\\RestSecurityService::getSmsService() File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestSecurityService.php Line:287',1427983855),
	(129,'Rest',1,'Call to undefined method SMSFactory\\Sender::debug() File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestSecurityService.php Line:286',1427984305),
	(130,'Rest',1,'Array to string conversion File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestSecurityService.php Line:284',1427984834),
	(131,'Rest',1,'Array to string conversion File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestSecurityService.php Line:284',1427984856),
	(132,'Rest',1,'Array to string conversion File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestSecurityService.php Line:284',1427984870),
	(133,'Rest',1,'Call to a member function getContent() on a non-object File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestSecurityService.php Line:287',1427984950),
	(134,'Rest',1,'Call to a member function getContent() on a non-object File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestSecurityService.php Line:287',1427985033),
	(135,'Rest',1,'Call to a member function count() on a non-object File: /Users/stanislavmenshykh/phalcon.local/Application/Services/Mappers/ErrorMapper.php Line:39',1427985155),
	(136,'Rest',2,'View \'/Users/stanislavmenshykh/phalcon.local/public/../Application/Modules/Rest/views/PHL/notifies/restore_password_emailrestore_password_email\' was not found in the views directory\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1427985344),
	(137,'Rest',1,'syntax error, unexpected \';\' File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestSecurityService.php Line:287',1427987509),
	(138,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: DELETE\n              URI: http://phalcon.local/api/v1/sign/12',1427987637),
	(139,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/users',1427987877),
	(140,'Rest',1,'Undefined index: line File: /Users/stanislavmenshykh/phalcon.local/Application/Helpers/Format.php Line:41',1427988369),
	(141,'Rest',1,'Undefined index: line File: /Users/stanislavmenshykh/phalcon.local/Application/Helpers/Format.php Line:41',1427988389),
	(142,'Global',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://api.phalcon.local/',1428050556),
	(143,'Global',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://api.phalcon.local/errors',1428050562),
	(144,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://api.phalcon.local/api/v1/errors',1428050580),
	(145,'Rest',1,'Only variables should be passed by reference File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/Nexmo.php Line:84',1428325542),
	(146,'Rest',2,'You have exceeded the submission capacity allowed on this account, please back-off and retry\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1428325843),
	(147,'Rest',1,'Illegal string offset \'status\' File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/Nexmo.php Line:85',1428325843),
	(148,'Rest',1,'Illegal string offset \'status\' File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/Nexmo.php Line:83',1428325855),
	(149,'Rest',1,'Illegal string offset \'status\' File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/Nexmo.php Line:83',1428325891),
	(150,'Rest',2,'You have exceeded the submission capacity allowed on this account, please back-off and retry\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1428325908),
	(151,'Rest',1,'Illegal string offset \'status\' File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/Nexmo.php Line:85',1428325908),
	(152,'Rest',2,'You have exceeded the submission capacity allowed on this account, please back-off and retry\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1428325920),
	(153,'Rest',1,'Illegal string offset \'status\' File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/Nexmo.php Line:85',1428325920),
	(154,'Rest',2,'Your request is incomplete and missing some mandatory parameters\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1428325967),
	(155,'Rest',1,'Illegal string offset \'status\' File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/Nexmo.php Line:85',1428325967),
	(156,'Rest',1,'Only variables should be passed by reference File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/Nexmo.php Line:81',1428325983),
	(157,'Rest',2,'Your request is incomplete and missing some mandatory parameters\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1428326191),
	(158,'Rest',1,'Illegal string offset \'status\' File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/Nexmo.php Line:85',1428326191),
	(159,'Rest',2,'Your request is incomplete and missing some mandatory parameters\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1428326275),
	(160,'Rest',1,'Illegal string offset \'status\' File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/Nexmo.php Line:85',1428326275),
	(161,'Rest',1,'Illegal string offset \'status\' File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/Nexmo.php Line:83',1428326280),
	(162,'Rest',1,'Illegal string offset \'status\' File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/Nexmo.php Line:84',1428326291),
	(163,'Rest',1,'Illegal string offset \'status\' File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/Nexmo.php Line:83',1428326305),
	(164,'Rest',1,'Illegal string offset \'status\' File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/Nexmo.php Line:84',1428326316),
	(165,'Rest',2,'Your request is incomplete and missing some mandatory parameters\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1428326329),
	(166,'Rest',1,'Illegal string offset \'status\' File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/Nexmo.php Line:84',1428326329),
	(167,'Rest',1,'Illegal string offset \'status\' File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/Nexmo.php Line:84',1428326348),
	(168,'Rest',1,'Illegal string offset \'status\' File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/Nexmo.php Line:84',1428326354),
	(169,'Rest',1,'Illegal string offset \'status\' File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/Nexmo.php Line:84',1428326392),
	(170,'Rest',1,'Illegal string offset \'status\' File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/Nexmo.php Line:84',1428326397),
	(171,'Rest',1,'Illegal string offset \'status\' File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/Nexmo.php Line:83',1428326408),
	(172,'Rest',2,'Your request is incomplete and missing some mandatory parameters\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1428326562),
	(173,'Rest',1,'Illegal string offset \'status\' File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/Nexmo.php Line:83',1428326562),
	(174,'Rest',1,'Only variables should be passed by reference File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/Nexmo.php Line:81',1428326613),
	(175,'Rest',1,'Trying to get property of non-object File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/Nexmo.php Line:83',1428326623),
	(176,'Rest',2,'Quota Exceeded - rejected\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1428326786),
	(177,'Rest',1,'Undefined index: status File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/Nexmo.php Line:88',1428326807),
	(178,'Rest',2,'Quota Exceeded - rejected\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1428326883),
	(179,'Rest',2,'Nexmo Quota Exceeded - rejected\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1428327080),
	(180,'Rest',2,'Nexmo: Quota Exceeded - rejected\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1428327131),
	(181,'Rest',1,'Class \'SMSFactory\\Exceptions\\BadRequestException\' not found File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/Nexmo.php Line:86',1428327275),
	(182,'Rest',1,'Class \'SMSFactory\\Providers\\BaseException\' not found File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/Nexmo.php Line:86',1428327288),
	(183,'Rest',1,'Class \'SMSFactory\\Providers\\BaseException\' not found File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/Nexmo.php Line:86',1428327296),
	(184,'Rest',1,'Class \'SMSFactory\\Providers\\BaseException\' not found File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/Nexmo.php Line:86',1428327320),
	(185,'Rest',2,'Nexmo: Quota Exceeded - rejected\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1428327334),
	(186,'Rest',2,'BulkSMS: FAILED_USERCREDITS\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1428328162),
	(187,'Rest',1,'Undefined variable: matches File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/Clickatell.php Line:79',1428328357),
	(188,'Rest',1,'Class \'SMSFactory\\Providers\\BaseException\' not found File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/Clickatell.php Line:86',1428328870),
	(189,'Rest',2,'Clickatell: Authentication failed\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1428328903),
	(190,'Rest',2,'The server is not responding: Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1428329084),
	(191,'Rest',1,'Class \'SMSFactory\\Providers\\Exception\' not found File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/MessageBird.php Line:77',1428329115),
	(192,'Rest',2,'The server is not responding: Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1428329123),
	(193,'Rest',2,'The server is not responding: Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1428330110),
	(194,'Rest',2,'SMSC: parameters error\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1428596194),
	(195,'Rest',1,'Class SMSFactory\\Config\\SmsAero contains 1 abstract method and must therefore be declared abstract or implement the remaining methods (SMSFactory\\Aware\\ProviderConfigInterface::getResponseStatus) File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Config/SmsAero.php Line:128',1428596732),
	(196,'Rest',1,'Class SMSFactory\\Config\\Nexmo contains 1 abstract method and must therefore be declared abstract or implement the remaining methods (SMSFactory\\Aware\\ProviderConfigInterface::getResponseStatus) File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Config/Nexmo.php Line:111',1428596787),
	(197,'Rest',2,'SmsAero: empty field. reject\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1428596984),
	(198,'Rest',1,'Argument 1 passed to SMSFactory\\Config\\SmsUkraine::__construct() must be of the type array, null given, called in /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Sender.php on line 57 and defined File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Config/SmsUkraine.php Line:83',1428597181),
	(199,'Rest',1,'Argument 1 passed to SMSFactory\\Config\\SmsUkraine::__construct() must be of the type array, null given, called in /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Sender.php on line 57 and defined File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Config/SmsUkraine.php Line:57',1428597220),
	(200,'Rest',1,'syntax error, unexpected \'return\' (T_RETURN), expecting function (T_FUNCTION) File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/SmsUkraine.php Line:97',1428597974),
	(201,'Rest',1,'preg_match(): Unknown modifier \'g\' File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/SmsUkraine.php Line:83',1428598264),
	(202,'Rest',2,'SmsUkraine: errors:Error in Alpha-name.errors:Not enough money\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1428598422),
	(203,'Rest',1,'Class \'SMSFactory\\Config\\SMSRu\' not found File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Sender.php Line:57',1428600510),
	(204,'Rest',1,'Argument 1 passed to SMSFactory\\Providers\\SMSRu::__construct() must be an instance of SMSFactory\\Config\\SMSC, instance of SMSFactory\\Config\\SMSRu given, called in /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Sender.php on line 57 and defined File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/SMSRu.php Line:46',1428600545),
	(205,'Rest',2,'SMSRu: Неправильный api_id\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1428601063),
	(206,'Rest',1,'Undefined index: 100\n201515-1000001\nbalance=0 File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/SMSRu.php Line:83',1428601076),
	(207,'Global',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/',1429019481),
	(208,'Global',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/',1429041409),
	(209,'Rest',2,'SmsAero: {\"result\":\"reject\",\"reason\":\"incorrect user or password\"}\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1429088379),
	(210,'Rest',2,'SmsAero: empty field. reject\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1429088388),
	(211,'Rest',2,'SmsAero: {\"result\":\"reject\",\"reason\":\"incorrect user or password\"}\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1429088490),
	(212,'Rest',1,'Call to a member function send() on a non-object File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestSecurityService.php Line:283',1429088734),
	(213,'Rest',2,'SmsUkraine: errors:Wrong login/password\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1429090132),
	(214,'Rest',2,'SmsUkraine: errors:Wrong login/password\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1429090148),
	(215,'Rest',1,'Array to string conversion File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestSecurityService.php Line:284',1429090423),
	(216,'Rest',1,'Array to string conversion File: /Users/stanislavmenshykh/phalcon.local/Application/Modules/Rest/Services/RestSecurityService.php Line:284',1429090456),
	(217,'Rest',2,'Nexmo: \n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1429090546),
	(218,'Rest',1,'Undefined index: error-text File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/Nexmo.php Line:83',1429090546),
	(219,'Rest',2,'Nexmo: \n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1429090559),
	(220,'Rest',1,'Undefined index: error-text File: /Users/stanislavmenshykh/phalcon.local/vendor/stanislav-web/phalcon-sms-factory/src/SMSFactory/Providers/Nexmo.php Line:85',1429090559),
	(221,'Rest',2,'Nexmo: authentication failed\n              IP: 127.0.0.1\n              Refer: \n              Method: PUT\n              URI: http://phalcon.local/api/v1/sign',1429090570),
	(222,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175222),
	(223,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175223),
	(224,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175223),
	(225,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429175223),
	(226,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429175223),
	(227,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175223),
	(228,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175224),
	(229,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429175224),
	(230,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175224),
	(231,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175229),
	(232,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=id%2Ctitle%2Cwrong',1429175229),
	(233,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175229),
	(234,'Rest',2,'Forbidden\n              IP: 127.0.0.1\n              Refer: http://phalcon.local/api/v1/sign?login=user%40gmail.com&password=user%40gmail.com\n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1429175229),
	(235,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429175229),
	(236,'Rest',2,'Request URI Too Long\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',1429175229),
	(237,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1429175229),
	(238,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/undefined/page',1429175229),
	(239,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/sign',1429175229),
	(240,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1429175229),
	(241,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429175229),
	(242,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429175229),
	(243,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175239),
	(244,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175241),
	(245,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175262),
	(246,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175264),
	(247,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175276),
	(248,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175277),
	(249,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175277),
	(250,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429175277),
	(251,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429175277),
	(252,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175277),
	(253,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175277),
	(254,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429175277),
	(255,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175277),
	(256,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175280),
	(257,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=id%2Ctitle%2Cwrong',1429175281),
	(258,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175281),
	(259,'Rest',2,'Forbidden\n              IP: 127.0.0.1\n              Refer: http://phalcon.local/api/v1/sign?login=user%40gmail.com&password=user%40gmail.com\n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1429175281),
	(260,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429175281),
	(261,'Rest',2,'Request URI Too Long\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',1429175281),
	(262,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1429175281),
	(263,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/undefined/page',1429175281),
	(264,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/sign',1429175281),
	(265,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1429175281),
	(266,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429175281),
	(267,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429175281),
	(268,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/logs',1429175311),
	(269,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov@gmail.com&password=stanisov@gmail.com',1429175316),
	(270,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov@gmail.com&password=stanisov@gmail.com',1429175319),
	(271,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: DELETE\n              URI: http://phalcon.local/api/v1/sign/1',1429175322),
	(272,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: DELETE\n              URI: http://phalcon.local/api/v1/sign/1',1429175327),
	(273,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: DELETE\n              URI: http://phalcon.local/api/v1/sign/1',1429175328),
	(274,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: DELETE\n              URI: http://phalcon.local/api/v1/sign/1',1429175328),
	(275,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: DELETE\n              URI: http://phalcon.local/api/v1/sign/1',1429175329),
	(276,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: DELETE\n              URI: http://phalcon.local/api/v1/sign/1',1429175329),
	(277,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: DELETE\n              URI: http://phalcon.local/api/v1/sign/1',1429175329),
	(278,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: DELETE\n              URI: http://phalcon.local/api/v1/sign/1',1429175329),
	(279,'Rest',2,'Too Many Requests\n              IP: 127.0.0.1\n              Refer: \n              Method: DELETE\n              URI: http://phalcon.local/api/v1/sign/1',1429175329),
	(280,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: DELETE\n              URI: http://phalcon.local/api/v1/sign/1',1429175330),
	(281,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: DELETE\n              URI: http://phalcon.local/api/v1/sign/1',1429175330),
	(282,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: DELETE\n              URI: http://phalcon.local/api/v1/sign/1',1429175330),
	(283,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: DELETE\n              URI: http://phalcon.local/api/v1/sign/1',1429175330),
	(284,'Rest',2,'Conflict\n              IP: 127.0.0.1\n              Refer: \n              Method: POST\n              URI: http://phalcon.local/api/v1/sign',1429175336),
	(285,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175339),
	(286,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: DELETE\n              URI: http://phalcon.local/api/v1/sign/1',1429175344),
	(287,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: DELETE\n              URI: http://phalcon.local/api/v1/sign/10',1429175349),
	(288,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175367),
	(289,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175497),
	(290,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: DELETE\n              URI: http://phalcon.local/api/v1/sign/1',1429175571),
	(291,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175576),
	(292,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175684),
	(293,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175684),
	(294,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175684),
	(295,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429175685),
	(296,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429175685),
	(297,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175685),
	(298,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175685),
	(299,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429175685),
	(300,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175685),
	(301,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175685),
	(302,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175685),
	(303,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175689),
	(304,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=id%2Ctitle%2Cwrong',1429175689),
	(305,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175689),
	(306,'Rest',2,'Forbidden\n              IP: 127.0.0.1\n              Refer: http://phalcon.local/api/v1/sign?login=user%40gmail.com&password=user%40gmail.com\n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1429175689),
	(307,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429175689),
	(308,'Rest',2,'Request URI Too Long\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',1429175689),
	(309,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1429175689),
	(310,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/undefined/page',1429175689),
	(311,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/sign',1429175689),
	(312,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1429175689),
	(313,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429175689),
	(314,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429175689),
	(315,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175726),
	(316,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175844),
	(317,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175858),
	(318,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175868),
	(319,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175868),
	(320,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429175884),
	(321,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429176255),
	(322,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429176256),
	(323,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429176256),
	(324,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429176256),
	(325,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429176256),
	(326,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429176256),
	(327,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429176256),
	(328,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429176256),
	(329,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429176256),
	(330,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429176256),
	(331,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429176257),
	(332,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429176260),
	(333,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=id%2Ctitle%2Cwrong',1429176260),
	(334,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429176260),
	(335,'Rest',2,'Forbidden\n              IP: 127.0.0.1\n              Refer: http://phalcon.local/api/v1/sign?login=user%40gmail.com&password=user%40gmail.com\n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1429176261),
	(336,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429176261),
	(337,'Rest',2,'Request URI Too Long\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',1429176261),
	(338,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1429176261),
	(339,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/undefined/page',1429176261),
	(340,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/sign',1429176261),
	(341,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1429176261),
	(342,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429176261),
	(343,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429176261),
	(344,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429176272),
	(345,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429176272),
	(346,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429176272),
	(347,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429176272),
	(348,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429176272),
	(349,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429176272),
	(350,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429176272),
	(351,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429176272),
	(352,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429176272),
	(353,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429176272),
	(354,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429176272),
	(355,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429176275),
	(356,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=id%2Ctitle%2Cwrong',1429176275),
	(357,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429176275),
	(358,'Rest',2,'Forbidden\n              IP: 127.0.0.1\n              Refer: http://phalcon.local/api/v1/sign?login=user%40gmail.com&password=user%40gmail.com\n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1429176275),
	(359,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429176275),
	(360,'Rest',2,'Request URI Too Long\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',1429176275),
	(361,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1429176275),
	(362,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/undefined/page',1429176275),
	(363,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/sign',1429176275),
	(364,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1429176276),
	(365,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429176276),
	(366,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429176276),
	(367,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429176280),
	(368,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429176282),
	(369,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429176294),
	(370,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429176295),
	(371,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429176306),
	(372,'Rest',1,'Class \'XHProfRuns_Default\' not found File: /Users/stanislavmenshykh/phalcon.local/public/index.php Line:36',1429176307),
	(373,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429176470),
	(374,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429176470),
	(375,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429176470),
	(376,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=id%2Ctitle%2Cwrong',1429176473),
	(377,'Rest',2,'Forbidden\n              IP: 127.0.0.1\n              Refer: http://phalcon.local/api/v1/sign?login=user%40gmail.com&password=user%40gmail.com\n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1429176473),
	(378,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429176473),
	(379,'Rest',2,'Request URI Too Long\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',1429176473),
	(380,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1429176473),
	(381,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/undefined/page',1429176473),
	(382,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/sign',1429176473),
	(383,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1429176473),
	(384,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429176473),
	(385,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429176473),
	(386,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429176485),
	(387,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429176485),
	(388,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429176485),
	(389,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=id%2Ctitle%2Cwrong',1429176489),
	(390,'Rest',2,'Forbidden\n              IP: 127.0.0.1\n              Refer: http://phalcon.local/api/v1/sign?login=user%40gmail.com&password=user%40gmail.com\n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1429176489),
	(391,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429176489),
	(392,'Rest',2,'Request URI Too Long\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',1429176489),
	(393,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1429176489),
	(394,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/undefined/page',1429176489),
	(395,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/sign',1429176489),
	(396,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1429176489),
	(397,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429176489),
	(398,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429176489),
	(399,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429176513),
	(400,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429176513),
	(401,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429176513),
	(402,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=id%2Ctitle%2Cwrong',1429176516),
	(403,'Rest',2,'Forbidden\n              IP: 127.0.0.1\n              Refer: http://phalcon.local/api/v1/sign?login=user%40gmail.com&password=user%40gmail.com\n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1429176516),
	(404,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429176516),
	(405,'Rest',2,'Request URI Too Long\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',1429176516),
	(406,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1429176516),
	(407,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/undefined/page',1429176516),
	(408,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/sign',1429176516),
	(409,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1429176516),
	(410,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429176516),
	(411,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429176516),
	(412,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/logs',1429176636),
	(413,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429176787),
	(414,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429176787),
	(415,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=id%2Ctitle%2Cwrong',1429176791),
	(416,'Rest',2,'Forbidden\n              IP: 127.0.0.1\n              Refer: http://phalcon.local/api/v1/sign?login=user%40gmail.com&password=user%40gmail.com\n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1429176791),
	(417,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429176791),
	(418,'Rest',2,'Request URI Too Long\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',1429176791),
	(419,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1429176791),
	(420,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/undefined/page',1429176791),
	(421,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/sign',1429176791),
	(422,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1429176791),
	(423,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429176791),
	(424,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local/api/v1/sign?login=stanisov%40gmail.com&password=baJeTtbceI',1429176792),
	(425,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=id%2Ctitle%2Cwrong',1429176900),
	(426,'Rest',2,'Forbidden\n              IP: 127.0.0.1\n              Refer: http://phalcon.local/api/v1/sign?login=user%40gmail.com&password=user%40gmail.com\n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1429176900),
	(427,'Rest',2,'Request URI Too Long\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',1429176900),
	(428,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1429176900),
	(429,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/undefined/page',1429176900),
	(430,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/sign',1429176900),
	(431,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1429176900),
	(432,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=id%2Ctitle%2Cwrong',1429176913),
	(433,'Rest',2,'Forbidden\n              IP: 127.0.0.1\n              Refer: http://phalcon.local/api/v1/sign?login=user%40gmail.com&password=user%40gmail.com\n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1429176913),
	(434,'Rest',2,'Request URI Too Long\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/pages?columns=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',1429176913),
	(435,'Rest',2,'Not Acceptable\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1429176913),
	(436,'Rest',2,'Not Found\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/undefined/page',1429176913),
	(437,'Rest',2,'Bad Request\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/sign',1429176913),
	(438,'Rest',2,'Unauthorized\n              IP: 127.0.0.1\n              Refer: \n              Method: GET\n              URI: http://phalcon.local//api/v1/users',1429176913);

/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;


# Дамп таблицы pages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pages`;

CREATE TABLE `pages` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'Title of page',
  `content` text NOT NULL COMMENT 'HTML content',
  `alias` varchar(32) NOT NULL DEFAULT '' COMMENT 'URL slug',
  `date_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Create date',
  `date_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Update date',
  PRIMARY KEY (`id`),
  FULLTEXT KEY `ful_content` (`content`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;

INSERT INTO `pages` (`id`, `title`, `content`, `alias`, `date_create`, `date_update`)
VALUES
	(1,'About','<p>This is about page content. I am edit storage text. EDITED2</p>','/pages/about','2015-01-22 00:30:05','2015-03-23 12:26:25'),
	(2,'Agreement','This is agreement page content','/pages/agreement','2015-01-22 00:32:41','2015-03-23 12:26:27'),
	(4,'Contacts','<p>This is contacs page content. EDITED</p>','/pages/contacts','2015-01-22 00:34:22','2015-03-23 12:26:30'),
	(5,'Help','<p>This is the help page</p>','/pages/help','2015-01-22 02:53:07','2015-03-23 12:26:32');

/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;


# Дамп таблицы user_access
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_access`;

CREATE TABLE `user_access` (
  `user_id` int(11) unsigned NOT NULL,
  `token` varchar(255) NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `user_access_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `user_access` WRITE;
/*!40000 ALTER TABLE `user_access` DISABLE KEYS */;

INSERT INTO `user_access` (`user_id`, `token`, `expire_date`)
VALUES
	(11,'$2a$08$I3ufgZwqtpy.Bz2wsBTD/uXzrTlvHxZV3nSYUROvJVVNXfwPwkqQW','2015-04-23 09:35:13'),
	(14,'e95b8b637146bc43325c9df2fd1a0ab4','2015-03-16 05:45:43'),
	(15,'$2a$08$Q7Ps7jtdzx/HaWhPCQeNeOJZVzDKUUBvK9A/76DiAQ11CcyBtvCiu','2015-04-23 09:35:13'),
	(16,'643bd3a1ce3090d14f9a59d0c45ad354','2015-03-16 05:51:12'),
	(17,'1c94392e83ea494e4060b6a3ac651e6c','2015-03-16 05:54:21'),
	(18,'685c2403f2e977a5e02f8ed36c0e22d0','2015-03-16 05:55:23'),
	(19,'283108b3ee610cef11e51aa12cb697fc','2015-03-16 05:57:00'),
	(20,'27906fadb0f3bdade5a0cb8d3846611c','2015-03-16 05:59:14'),
	(21,'70accea75c068e1ed0e9adc4aa99acd9','2015-03-16 06:03:03'),
	(22,'6b67c6230eb9d646d583a29d19292bd8','2015-03-16 06:34:23'),
	(23,'ffbd44b314d83a442a49c56ef9f74af7','2015-03-16 07:01:05'),
	(24,'627761113ed88e4a56eb6189def3e651','2015-03-16 07:02:25'),
	(25,'f222918ddb53cc11d5905c45c865dc78','2015-03-16 07:04:33'),
	(26,'073626d8d6b3bacd3c4ad040406979d6','2015-03-16 07:05:48'),
	(30,'632a7cc5792dfe4c57106bd821402bf4','2015-03-16 07:20:57'),
	(31,'3fe372c2f39619966384ab84f6894518','2015-03-16 07:43:18'),
	(32,'210056b2ac1fc6071520c0c0b2b5f979','2015-03-19 02:13:37'),
	(33,'d2516319f860cd17283f8ffae47d47f6','2015-03-16 21:57:41'),
	(34,'$2a$08$PbKDhDPHitTnswhak8W//exO4CLiefSt3aR72pNWKXO0WJ.jFfpni','2015-04-07 11:23:17'),
	(35,'$2a$08$/PFLE8I5mYUj.HIoGfs6luEiVn9zTrPmUYgHiqqnUWmwXzEmgDAxy','2015-04-07 11:24:06'),
	(36,'$2a$08$6EupB84BZeBK6BZLQSjTXecMQ/Eg.dYNo962d9eYn7zrpxibK85/O','2015-04-07 12:21:21'),
	(37,'$2a$08$wN//uhFgWnchQAdiKOp9eO7pM5GlNm2x3pZHgBNT7yYPnkWZcAepS','2015-04-07 12:24:12'),
	(38,'$2a$08$aLsi3TaKmFFJc5Y4VCmwbe4esiRRwtYRhEfDyYg3SPw9qXnd9U/b2','2015-04-07 14:27:55'),
	(39,'$2a$08$MLfJr8pGzNos5CrzDrrDeusE5ZH.11BsQbM7AhOcwZ/Qo3bL3Wt4.','2015-04-07 14:28:30'),
	(40,'$2a$08$qnFlgvZtNBy..anoepICP.9QygytLA81CvQxbbg5Yji/qq01ONDn2','2015-04-07 14:28:54'),
	(42,'$2a$08$9CUJ6aCg7rn9kDAOF/vmje/VhnpnkbKzyGKKsd2hjFUa1VOG5l3Km','2015-04-07 14:29:46'),
	(44,'$2a$08$d8kuBcJHjU/ZeMcD.0ln8utB4t2nJD09kW65pBnejn1nml69DLX1O','2015-04-07 14:30:47'),
	(45,'$2a$08$1iONIkKmmbz63VktW3O4nOpm/szsn682DH39qPRE8SwkAyPh92Zbu','2015-04-07 14:30:53'),
	(46,'$2a$08$JofjRtUGBnSvd6OyJRFdF.Eh764wWyFNCEuaFKxmgy9XzmRaetFJu','2015-04-07 15:43:05'),
	(47,'$2a$08$HgQqN2FJfaifmm2HhiCmV.ZCyABm5yqqLVCFyXMjtVBU43c6tmOVy','2015-04-07 15:52:37'),
	(48,'$2a$08$/12JHmfWhs9IZJQu9BMiEOukEFxabPNifRhmbTr7A667MLR/F3t/y','2015-04-07 17:29:13'),
	(49,'$2a$08$kh.3Ej.yqyvM5PcE0NLsdOr1d8NVmjOsTYBxIDT.e8wB7srMxCXXq','2015-04-08 00:07:38'),
	(50,'$2a$08$H/QpOznNOsZnF6wJYdTEueIeZCrPsKk4iFE9Jmv6trFfM4FBZV.Ia','2015-04-08 00:15:13'),
	(51,'$2a$08$3Nw17yjWTLiSD.rAlzbLoOqk/J1gG7SnII.bmfDFPdWAm8h0IlA8u','2015-04-08 00:16:48'),
	(52,'$2a$08$49qBrk6Sj8NvEnLK0.Bj1eCyeJRA6V/6LcD2OdZ36KHKvR2nrjDye','2015-04-08 09:04:14'),
	(53,'$2a$08$RMKkqxPG7I8meczlIguXw.ybcZr.UNNrWVuXU4owhI0vATo4NL0s.','2015-04-08 09:08:21'),
	(54,'$2a$08$1A3aInSSV8NeoC5KpznesOgOBLWTJD3P2XzXSDEu64NQTSKkwu/AK','2015-04-08 09:08:53'),
	(55,'$2a$08$/8QcV9x0icpsbDNl19zSxObOOViZ7v9nILGCwlaDTvJiPzr8HnqH2','2015-04-08 09:09:05'),
	(56,'$2a$08$XSXzztVhYcR8mvhrhKS/Tes8vHn6AEaqBklyptCDzkoTnQgUCsOvy','2015-04-08 09:12:05'),
	(57,'$2a$08$WVlWq1n56MA.XWKrJTC.NeNnkXQAb.nHKrO81Y7gAIupz0jVJw1oq','2015-04-08 09:12:22'),
	(58,'$2a$08$tIRB9V/Bad9TQvcZrRNEYOb3EMZ9UDczm8SuJ4quDggQgzo2R3Usm','2015-04-08 09:30:53'),
	(59,'$2a$08$XP6RYGO7tixZL25uv4tOnejfJbwU3xcFv6WpnAOPcGn8STN2RqtFq','2015-04-08 09:31:32'),
	(60,'$2a$08$jx.bHNzSPbPxNfla3s5Y0ePnXgfDkVNUmiUzlMKGiqnI/cFFIqeM2','2015-04-08 09:32:33'),
	(61,'$2a$08$H/jJXnL/yhHst8nAzvtGqOude0kmUHAkXsvOV5HnJp0VZ8bB9Jyk2','2015-04-08 09:32:55'),
	(62,'$2a$08$iaYDfXYEmYexjvxMcHz9PedAOJXdxqjWtFzXQNKk0JndnZyv08RP6','2015-04-08 09:35:09'),
	(63,'$2a$08$Zh3KvvRo3x1MrPZ0jTckWOq6gV5c9AJq/Bk8ncO8MuO81V0KiXsya','2015-04-08 09:35:48'),
	(64,'$2a$08$6B6SYeBS0NBdTqdSQGrileHFaVnD5p2te3Ki5PmvjJQpb4Dd6Z5nC','2015-04-09 08:15:01'),
	(65,'$2a$08$au41d6XKOnO4cf9I17xQ/.fyDdXOtn2Tq1ywRPPNZKaWFCvgdiEkW','2015-04-09 09:27:08'),
	(66,'$2a$08$.wytX.4kwxY6zntOOAtvaOtZlJKp4ecakdbrxc9BLbIyKb1MWMxp2','2015-04-09 09:29:20'),
	(67,'$2a$08$OMMdK7HW92n.XJhVFZul/uZ/qBuQUglbAaGpSVpTvCmNmcviGfOU6','2015-04-09 09:29:46'),
	(68,'$2a$08$vBgaXF1.CwshWPWm4iut/OpsJwSwtUfGN7JicBk17uYOllfuNnPrK','2015-04-09 09:34:27'),
	(69,'$2a$08$jws7N6Mx.IttmHgX0IENmOzN3Gy3h31Se6lKgQBwJVmQsIwoQ5tJ2','2015-04-09 11:18:01'),
	(70,'$2a$08$BcNgpylVGB0hcxxro.UJxOjRl79vL..sjc2CcOdd0K1VpIJ1cJCUS','2015-04-09 11:24:03'),
	(71,'$2a$08$WkU0TH2XzBgEknVSBAp6yOJySH0AHWPBE7xf80kt3TXZgbtw03kAu','2015-04-09 11:25:35'),
	(72,'$2a$08$foOVh8.lGUmeDqsdCQs8Z.5XAEDqbUkU3H8nh8nPjnHiz6bV98lsa','2015-04-09 11:26:11'),
	(73,'$2a$08$0S/OqB36ghCu7rF5gQfnduBkqO9WgDX9A0jVle3Q1SGvCBVLGh3se','2015-04-09 14:05:52'),
	(74,'$2a$08$BYlaKpZPNncLh2uiA.nPxOgpH8WT1Ri8wQYJvCtDXUkcLtKSIhGlG','2015-04-09 15:26:29'),
	(75,'$2a$08$vuQyXdOGGYBJauzCsSxof.CTcOsGW5FwIilGHgK7.cxCCQcD1AR5W','2015-04-23 09:07:04'),
	(76,'$2a$08$hb69DNueFa6VfY9apBDLPetGxNskFiBzmIQ3UgudlwamObRWHr2g2','2015-04-23 09:07:57'),
	(77,'$2a$08$is/SNbL3dRKVx7oWqWc5IeOf/C3p5NdlYMM5BZ9Q087h533k9gqfm','2015-04-23 09:08:59'),
	(78,'$2a$08$h6vicHw6D0v5h5ODVIyqG.BZtGMbJ3dALviGiJgPqhFjbJ5WaT5iS','2015-04-23 09:11:37'),
	(80,'$2a$08$eKt.5Tb9eciaqGTkesXdcuXmHPpCsQBtSfsh3n.2zt81cR1NqZyFK','2015-04-23 09:14:45'),
	(82,'$2a$08$EUcLZIPaghAD/va4kzWU.uhDGz11uCr3h4niPiSycpGTwA90jLYgy','2015-04-23 09:24:17'),
	(84,'$2a$08$KA5joy3JjcFfYNzKaqBfNuWGrUJsyvT2426OQ9uB/UDUyNKXdS0Fu','2015-04-23 09:24:32'),
	(86,'$2a$08$GWcwCvgIzB3yPC/9rv8GM.upLout5mTUdGtVPpcT4yAq5sRtVxxNu','2015-04-23 09:27:50'),
	(88,'$2a$08$hRWTX40m/pZCzD4NwRHk1OmFajIhawZ5hvox71V2N7K1kCx9.GcEq','2015-04-23 09:28:06'),
	(90,'$2a$08$S8n23hNNt7XiCYPPv2SvZukjVyFjkdRNa6s69ljKhlfuA4pasSxaG','2015-04-23 09:28:33'),
	(92,'$2a$08$9QIqMrOvYQpDEWs/9fuMI.SOuHCWEs/NsBcESizSdvbgmq0QSiony','2015-04-23 09:33:08'),
	(94,'$2a$08$M.ktkIl01MT2P0DiBKgis.tBx8i579Cj1ng8XN3GWAx1SSsOeBZEi','2015-04-23 09:34:57'),
	(96,'$2a$08$vwTz8Ya5IzWYg.Fd5jJ9c.gWgjzaCoZ/6abt3lGqjuQFdS0IZQXnm','2015-04-23 09:35:10');

/*!40000 ALTER TABLE `user_access` ENABLE KEYS */;
UNLOCK TABLES;


# Дамп таблицы user_roles
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_roles`;

CREATE TABLE `user_roles` (
  `id` tinyint(1) unsigned NOT NULL,
  `name` varchar(45) DEFAULT NULL COMMENT 'User Roles table',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 MAX_ROWS=5;

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;

INSERT INTO `user_roles` (`id`, `name`)
VALUES
	(0,'User'),
	(1,'Admin');

/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;


# Дамп таблицы users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Common users table';

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `login`, `name`, `surname`, `password`, `role`, `state`, `rating`, `ip`, `ua`, `date_registration`, `date_lastvisit`)
VALUES
	(11,'user@gmail.com','stanisovw@gmail.com','','$2a$08$n9WNEktlDCbVqPZ8faZzVOvPuoi4XZr2beSusccYt6GKpatmPsTT2',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-02-21 04:31:14','2015-04-16 09:35:13'),
	(12,'userundefined@gmail.com','TestRestoreUser','','$2a$08$6iZhl5qx8NOAOtyJQf3NPuJFMOlJiT7hXM2ELisjL/eSafWaDgH6G',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.111 Safari/537.36','2015-02-22 13:37:59','2015-04-02 12:31:13'),
	(13,'380954916517','stanisov3@gmail.com','','$2a$08$I6hHlg0Vu2DVofpgsK.15enr.6K2X7MrIBATNDtvBwoef/AsFmgL2',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.111 Safari/537.36','2015-02-22 14:36:52','2015-04-02 17:10:38'),
	(14,'stanisov4@gmail.com','dcdcdcdcdc','','wwwwww',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 05:45:43','2015-03-09 05:45:43'),
	(15,'admin@admin.ua','AdminTester','','$2a$08$GpGWBJuVavKO2/NOYaM45eSOyi1MiygFUEMDecvppWtCR5xsWN8RC',1,'0',0,2130706433,'Symfony2 BrowserKit','2015-03-09 05:48:23','2015-04-16 09:35:13'),
	(16,'qstanisov@gmail.com','qqqqqq','','qqqqqq',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 05:51:12','2015-03-09 05:51:12'),
	(17,'ssss@mail.ua','ssss@mail.ua','','ssss@mail.ua',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 05:54:21','2015-03-09 05:54:21'),
	(18,'sss2@mail.ua','ssss@mail.ua','','ssss@mail.ua',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 05:55:23','2015-03-09 05:55:23'),
	(19,'stanisov44@gmail.com','stanisov4@gmail.com','','stanisov4@gmail.com',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 05:57:00','2015-03-09 05:57:00'),
	(20,'sssdsd2@msdsd.uA','sssdsd2@msdsd.uA','','sssdsd2@msdsd.uA',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 05:59:14','2015-03-09 05:59:14'),
	(21,'asasas@mail.fj','asasas@mail.fj','','asasas@mail.fj',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 06:03:03','2015-03-09 06:03:03'),
	(22,'asasa@sdsdsd.er','asasa@sdsdsd.er','','asasa@sdsdsd.er',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 06:34:23','2015-03-09 06:34:23'),
	(23,'asassfdf@sds.ua','asassfdf@sds.ua','','$2a$08$yWl8VCT1yCfkac8a5gVfeuLnLnAlmpobG7euC6w2BV85NaJjEBrym',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 07:01:05','2015-03-09 07:01:05'),
	(24,'credential@sdsdsd.ua','$credential@sdsdsd.ua','','$2a$08$70SWdTIlqfBx.59c1GpvQORFGOrj5H6p83BQbCBUABjJcoEa6O8mi',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 07:02:25','2015-03-09 07:02:25'),
	(25,'stanisovddddd@mail.ewe','stanisovddddd@mail.ewe','','$2a$08$y4P38MNLvUl3k3L0OmF6LeYd0N1bA4pGKEkO54fuOxjzYuKSO7Nv2',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 07:04:33','2015-03-09 07:04:33'),
	(26,'sdsfgfgfl@ksds.ua','sdsfgfgfl@ksds.ua','','$2a$08$XRFx3poEIMT7wn0dKoMiyeSNynu/BAfgAQbbG95LL0G4Psp/QOHQ2',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 07:05:48','2015-03-09 07:05:48'),
	(27,'dsdsffgfg@mail.cu','dsdsffgfg@mail.cu','','$2a$08$XdG3lDu.o0XVRN/lOp0zyOyDGxY/TDLmtVjO7GwJQMqTioU8.HKG.',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 07:07:36','2015-03-09 07:07:36'),
	(28,'gfhgfh@dfdfd.ia','gfhgfh@dfdfd.ia','','$2a$08$WiKNINxRZGHm8cD1esGtieRfNnqA2PgaGi729KPvDBhnazoah/O.e',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 07:14:58','2015-03-09 07:14:58'),
	(29,'rer@erer2.ua','rer@erer','','$2a$08$eW3FlhO32GSrTgclk3evQOUMzdBx0VqTTBYIxAuRUGFJ6tszn6FLO',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 07:17:51','2015-03-09 07:17:51'),
	(30,'fdsgf@asdsa.ua','fdsgf@asdsa.ua','','$2a$08$QNBEocj/fytqlnM2x3qNkeiRh2uRnLnCgEz2eKr9gZZ4ahKJP6sSC',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 07:20:57','2015-03-09 07:20:57'),
	(31,'ddffff@mail.ru','ddffff@mail.ru','','$2a$08$vzeuVMFudlFKdi/wERuR4Ov4Dy6BH8Zn2Qf1IDnGburGzsLWQaYUe',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 07:22:46','2015-03-09 07:22:46'),
	(32,'ddffff@mail.ru2','ddffff@mail.ru2','','$2a$08$G1DYLGCUb14lr5hNy/e83uOPYK3VlRmpAXPDiDcSXNUi1VLjdPQJe',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 07:43:32','2015-03-12 02:13:37'),
	(33,'ddffff@mail.ru22','ddffff@mail.ru22','','$2a$08$V.SUyESC46HEmOtvmEXRLeiX.6TLxYcClLR93x42KkNT/m2AQy8rS',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-03-09 07:45:37','2015-03-09 07:45:37'),
	(34,'stanisovwewwew@gmail.com','stanisov@gmail.com','','$2a$08$M.NVYcQeTbp7NBNwR4qTdOKmg.0KYBriIvmhpT/M2Aiz52aEP1.7C',0,'0',0,2130706433,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36','2015-03-31 14:23:17','2015-03-31 14:23:17'),
	(35,'1980634175@1469152825.com','CodeceptionTester','','$2a$08$I1Mq.lVWgM7ScFnLIdSnTOR4qq0xw.EOUX1PYqWIy.MSBg.UDa5Om',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-03-31 14:24:06','2015-03-31 14:24:06'),
	(36,'stanisov2@wewgmail.com','stanisov@gmail.com','','$2a$08$7JjHP0/vp9zGGDbKnl3dZOGA9l3syPjR1nm0KTvL.bYc5EpjLltqq',0,'0',0,2130706433,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36','2015-03-31 15:21:21','2015-03-31 15:21:21'),
	(37,'stanis2ov2@wewgmail.com','stanisov@gmail.com','','$2a$08$J0UJFK2p9ZHpJPLYRIjHTO68LtqoTUuXxrojOf92HlCYDR1ru.wCS',0,'0',0,2130706433,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36','2015-03-31 15:24:12','2015-03-31 15:24:12'),
	(38,'stanisov232@wewgmail.com','stanisov@gmail.com','','$2a$08$e7wSzmRRlAIs.9SIWuuMr.TaPJ8wgF09dtwdFLPaoboqb7C1OwSIK',0,'0',0,2130706433,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36','2015-03-31 17:27:55','2015-03-31 17:27:55'),
	(39,'stanisov2232@wewgmail.com','stanisov@gmail.com','','$2a$08$gsPEBHk0HJH/meaJgdE2keAL/rgXwfWZLvK2g5nWAKI4kEYWtfzXG',0,'0',0,2130706433,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36','2015-03-31 17:28:30','2015-03-31 17:28:30'),
	(40,'stanisov22232@wewgmail.com','stanisov@gmail.com','','$2a$08$ydcK5r5tWRE967qyGcmjDeFGJHdyPOMlVFJaVknqcuz6J0OpZ25Am',0,'0',0,2130706433,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36','2015-03-31 17:28:54','2015-03-31 17:28:54'),
	(41,'stanis1ov22232@wewgmail.com','stanisov@gmail.com','','$2a$08$Ixua.kzkRevn5/9nqOLwXeYNOohodv3QthiolVYU3vJ5qy2Xu2B/W',0,'0',0,2130706433,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36','2015-03-31 17:29:12','2015-03-31 17:29:12'),
	(42,'stanis1ov22232@we3wgmail.com','stanisov@gmail.com','','$2a$08$zRmkBEq5mZYBPLcUlgHxZeE3jMt8HkYr7rzEJPk10L3dAtR8YJuWO',0,'0',0,2130706433,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36','2015-03-31 17:29:46','2015-03-31 17:29:46'),
	(43,'stnis1ov22232@we3wgmail.com','stanisov@gmail.com','','$2a$08$5LdfVKXBdATLpQHVzwt4JO95oK/4LaWAGjBD1QQS7TwODChbQUZZO',0,'0',0,2130706433,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36','2015-03-31 17:30:15','2015-03-31 17:30:15'),
	(44,'stnis1ov222332@we3wgmail.com','stanisov@gmail.com','','$2a$08$2BJmgPcoKaIL31sgGYAgXuiWqr4qrgtEHXFm1sD0qauyQh2EirgY.',0,'0',0,2130706433,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36','2015-03-31 17:30:47','2015-03-31 17:30:47'),
	(45,'stnis12ov222332@we3wgmail.com','stanisov@gmail.com','','$2a$08$dCRUlbFlG0u7bP6gH7MTm.mDHo/nArE.ZkeSYx3PbVMDRsKSPfLD6',0,'0',0,2130706433,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36','2015-03-31 17:30:53','2015-03-31 17:30:53'),
	(46,'1356546924@38359461.com','CodeceptionTester','','$2a$08$bk3I53NsgEcl8cHhaovcZukQNXDrduPsXkhKnrytuTA9gDmBUTfNC',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-03-31 18:43:05','2015-03-31 18:43:05'),
	(47,'1503413079@1472169146.com','CodeceptionTester','','$2a$08$ex20i7n9dS8vu2UrNNkDieTRFB47VLZo.n/Eu7igaqJQ.8Q3vvKPC',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-03-31 18:52:37','2015-03-31 18:52:37'),
	(48,'151669929@625129123.com','CodeceptionTester','','$2a$08$Qn7JisY1iboqIFO7BPH.gOo4DbaggKld0nFe.jcdJTSid.B1fjGoK',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-03-31 20:29:13','2015-03-31 20:29:13'),
	(49,'test@mail.ruww','StanislavTester','','$2a$08$zj5uVbwNahlGr9Y5lXr2x.4GYcT0Yh69srrYw69BkBeSs7fB7ng6S',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-04-01 00:07:38','2015-04-01 00:07:38'),
	(50,'teqqst@mail.ruww','StanislavTesqter','','$2a$08$09KhAvZOmEfmwT3cwj8S5.AHf6L9ncHT88VXFg2ZORT.rT7tsD5DO',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-04-01 00:15:13','2015-04-01 00:15:13'),
	(51,'testuser@qmail.ru','StanislavTester','','$2a$08$jixQpjJtU69X6QUQYk1wP.hESGHGsUZqBe4LKB7DEZ2x4GpttXk1G',0,'0',0,2130706433,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','2015-04-01 00:16:48','2015-04-01 00:16:48'),
	(52,'1417103358@957110347.com','CodeceptionTester','','$2a$08$th6LMvTQ6aS9OI0DSEJPmuXAJv0gAoFeEGeMSBq60KoAw1jqkk75i',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-01 12:04:14','2015-04-01 12:04:14'),
	(53,'1883971273@965515154.com','CodeceptionTester','','$2a$08$ZM.Ts9SDRbpMOJkRw2McYOx1TZ6.z4Q/ZeufavRabqsptavMlIgXe',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-01 12:08:21','2015-04-01 12:08:21'),
	(54,'599324794@1242578991.com','CodeceptionTester','','$2a$08$eCQQSc0XLmH2.arJhQmQ8u8yjwpN9mDVIvAUXa6CzPYmG7kLP7POC',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-01 12:08:53','2015-04-01 12:08:53'),
	(55,'1385637827@1482547037.com','CodeceptionTester','','$2a$08$/AkpUH26kdz2SnIIJOqg.OhRE2KM5lqcqXXXor0IfFhMBNlwls7B2',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-01 12:09:05','2015-04-01 12:09:05'),
	(56,'1798900866@256465155.com','CodeceptionTester','','$2a$08$Xhb2lMPcYAjubb1VdpFWiu/adPeFTkjJn3HUJVZgvKoHZ4ISTo5RS',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-01 12:12:05','2015-04-01 12:12:05'),
	(57,'1987628893@1804164931.com','CodeceptionTester','','$2a$08$6x0dGRws5n.lUzAUSzSKQu.ALoppnsu4LqqEcn6RVnaNesSz3nIue',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-01 12:12:22','2015-04-01 12:12:22'),
	(58,'1158649052@1032212238.com','CodeceptionTester','','$2a$08$xzZ2KFM.iUl.RbuHHjeUL.lbdybdLhvk0q6507/FSMduqTnsyQlhi',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-01 12:30:53','2015-04-01 12:30:53'),
	(59,'stanisov3442@wewgmail.com','stanisov@gmail.com','','$2a$08$1sYYENbzVfNG97L5FQqsIeIFcHYluxqO5MAy43VCCEFSJs8XB367a',0,'0',0,2130706433,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36','2015-04-01 12:31:32','2015-04-01 12:31:32'),
	(60,'stanisov3442@wewgmail.com34','stanisov@gmail.com','','$2a$08$/4ITunQ241qCxTmAhtf4AOEnb1BhPWGty.J5D21nGF3QMCTMmlGHq',0,'0',0,2130706433,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36','2015-04-01 12:32:33','2015-04-01 12:32:33'),
	(61,'stanisovwe3442@wewgmail.com34','stanisov@gmail.com','','$2a$08$YtdkkJHVlT2HLcXjUPG8KO7MxsQk9gerZOjNtUbMO775vzfMXUoFa',0,'0',0,2130706433,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36','2015-04-01 12:32:55','2015-04-01 12:32:55'),
	(62,'stweanisov2@wewgmail.com','stanisov@gmail.com','','$2a$08$c9mXmFL0zBgwU2Wt1UfEY.jAdBSIULnfEo/jNc24cgsIKL385htNa',0,'0',0,2130706433,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36','2015-04-01 12:35:09','2015-04-01 12:35:09'),
	(63,'stwean34isov2@wewgmail.com','stanisov@gmail.com','','$2a$08$m4Oj3RqemvYbo5gLopZ3BeDkCi5fLpu1RYpodg2d0gfVqg5S2fK7m',0,'0',0,2130706433,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36','2015-04-01 12:35:48','2015-04-01 12:35:48'),
	(64,'2066202914@877925423.com','CodeceptionTester','','$2a$08$pATQm7CywkUzDUG4ErnPRusIOzaf.CnY1Jw4toumgr2OdDBrW7/QS',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-02 11:15:01','2015-04-02 11:15:01'),
	(65,'1646309651@705864297.com','CodeceptionTester','','$2a$08$jFoLJ4VzgKs4pLvMxoLDKOCyomeS19cMP3wFlkzzQ2Yg55qQTNJ3S',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-02 12:27:08','2015-04-02 12:27:08'),
	(66,'1913148572@828523189.com','CodeceptionTester','','$2a$08$T/2oi0aJSyuzgjBx1RPTGe.eKRS9HfA.vr7k4Kaf67GzJcgzmfX1C',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-02 12:29:20','2015-04-02 12:29:20'),
	(67,'629973120@1027920468.com','CodeceptionTester','','$2a$08$.xnNvP4cRbaOYcijYqaTDuD0wttFdYOcpuiUQLHP8aeylnEIAFvpy',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-02 12:29:46','2015-04-02 12:29:46'),
	(68,'1135672924@1464491270.com','CodeceptionTester','','$2a$08$mSst7ifuJx6wu2F3IDSQ1eNzFiLBopzkY6M1nlAkkFhHNkFTUl43C',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-02 12:34:27','2015-04-02 12:34:27'),
	(69,'565160853@371120871.com','CodeceptionTester','','$2a$08$XKnT2Bfa8EnJI0pcTv3JtOp6foo7/A3d8a2OQNRMKwQ67CMNxpIRa',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-02 14:18:01','2015-04-02 14:18:01'),
	(70,'1488014298@1877584569.com','CodeceptionTester','','$2a$08$OIwa8ur0RxLSqH3RYtGlgOOBAb4Xe6.P2x6jwxQNSEI5mx.Mv8ucG',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-02 14:24:03','2015-04-02 14:24:03'),
	(71,'514448206@1870936479.com','CodeceptionTester','','$2a$08$dZ3dPK/EKVvPRLsQdHo33OaZZGWLEpVi1AYJ0AhMqIrlShECwZ/zq',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-02 14:25:35','2015-04-02 14:25:35'),
	(72,'1768311384@1493860176.com','CodeceptionTester','','$2a$08$G1o5sP8ukqFJs6cc93H70ei0.2nFPl0g7W7uiFR7WsTB/dQx3YJ36',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-02 14:26:11','2015-04-02 14:26:11'),
	(73,'stanisov@gmail.com','StasTester','','$2a$08$/mPxVhZxTo2Rq4ntGxXpA.dZVQXtfv8lI7xzwHHZnZ/bESAY60gdC',0,'0',0,2130706433,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36','2015-04-02 14:37:04','2015-04-02 14:05:52'),
	(74,'stanisov2ss2@wewgmail.com','stanisov@gmail.com','','$2a$08$zgxULopmZJy89u2AWv5naO7i9ueits0dDeso4Laaqsk8b3utXH3EC',0,'0',0,2130706433,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36','2015-04-02 18:26:29','2015-04-02 18:26:29'),
	(75,'57442569@2060335552.com','CodeceptionTester','','$2a$08$Pckax0vjrgN2e3GFZmxybuen3H5QGzexldGaB7LdadPVnP.BKl57S',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-16 12:07:04','2015-04-16 12:07:04'),
	(76,'825234704@524936265.com','CodeceptionTester','','$2a$08$qE7qt1zDiZnRCDQwzO2rR.0lX7WjTH8J6m0Nolh3OklafBNvTPjUG',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-16 12:07:57','2015-04-16 12:07:57'),
	(77,'stanisov23@wewgmail.com','stanisov@gmail.com','','$2a$08$fXVBzblKwegZ3YefOmg5ROKwM948tfb2TeLroA6UhNWYNfydzexQq',0,'0',0,2130706433,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.118 Safari/537.36','2015-04-16 12:08:59','2015-04-16 12:08:59'),
	(78,'stanisov223@wewgmail.com','stanisov@gmail.com','','$2a$08$uCi94q0TViXNfCrEZtvk0OIWIIbbtEeplbWNeTnY.bkd5B30.1cLq',0,'0',0,2130706433,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.118 Safari/537.36','2015-04-16 12:11:37','2015-04-16 12:11:37'),
	(79,'1373893319@307293671.com','CodeceptionTester','','$2a$08$NObUpvUT1z7uimGX0rZJoeuKpP4BpS26Z4ZnnQh6AW75tZi1djrz.',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-16 12:14:45','2015-04-16 12:14:45'),
	(80,'2121273921@478597088.com','CodeceptionTester','','$2a$08$BZddGrMnwm2ujxwckG/xgOE520H7rO.jn4SIxbXNaelLzgGzVHFF6',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-16 12:14:45','2015-04-16 12:14:45'),
	(81,'1174442596@122444204.com','CodeceptionTester','','$2a$08$2VKrHs1AgHW7wjx5Nmy/GuxyYY7Z/WNSkIfBLRYWvBu8Y6Qv47ALC',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-16 12:24:16','2015-04-16 12:24:16'),
	(82,'745443902@520376167.com','CodeceptionTester','','$2a$08$ofXmQGvtx2gokmBuL3xFNuqx53VPv5863nnTz18ZDpYOreHTez89a',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-16 12:24:17','2015-04-16 12:24:17'),
	(83,'1946581401@1250589184.com','CodeceptionTester','','$2a$08$E4uyrJtcUhhG2OEkvWJ1ze6t3IQjy6O/oNUxMH9fFz751/Q8mf43G',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-16 12:24:32','2015-04-16 12:24:32'),
	(84,'1042556367@465801202.com','CodeceptionTester','','$2a$08$FZ7JsR2gEB8OSjah1KqoTOS/KxXaArs3bQcVYqbdDwJjF3txXZD6m',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-16 12:24:32','2015-04-16 12:24:32'),
	(85,'794626886@608752202.com','CodeceptionTester','','$2a$08$Sn5NxVd5jau4RtNcqXujGuwnNnvuIqRpF1F.i.d3DiFG9UgH9tuyG',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-16 12:27:50','2015-04-16 12:27:50'),
	(86,'622549494@1500424487.com','CodeceptionTester','','$2a$08$oq0OC8lRaACRuauaUj6oJu6ljAwIH16RfOyXUhVWfXM72NWzSEGCq',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-16 12:27:50','2015-04-16 12:27:50'),
	(87,'1590360942@1147790028.com','CodeceptionTester','','$2a$08$3e8yRpxTngK8pUu8k9SImOexdkXo4iXAWu75KWkJhYlYdbYilbksy',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-16 12:28:06','2015-04-16 12:28:06'),
	(88,'916274800@1961177705.com','CodeceptionTester','','$2a$08$qGOXYRzdMplz9OElesx0XuI/ribUEIpXylthIrZKWAfEtAiGH71.W',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-16 12:28:06','2015-04-16 12:28:06'),
	(89,'1702449101@1489017720.com','CodeceptionTester','','$2a$08$tXpNn1SvLS/x7dg7z0L1QeHKaYvUUx/aB6y2UMrgB36fTj21LVLMK',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-16 12:28:33','2015-04-16 12:28:33'),
	(90,'1047775485@128051290.com','CodeceptionTester','','$2a$08$ReAAPnO6tzrX5M2Ubi4Kk.lTd1m7M6OEQndKk4rFfMDVTVibFwM/O',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-16 12:28:33','2015-04-16 12:28:33'),
	(91,'81097064@2028848052.com','CodeceptionTester','','$2a$08$nQ1hn3U9ESveV3q7iaVjUOEEQTiAbBtH174t0hkLXesgHFBhI5RH.',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-16 12:33:08','2015-04-16 12:33:08'),
	(92,'202755125@2112196877.com','CodeceptionTester','','$2a$08$64L1THamgglPbKb0geX4.O/dhCDAX0RvhiYcHlxhFolGDLGKBcxOm',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-16 12:33:08','2015-04-16 12:33:08'),
	(93,'2059369560@867502096.com','CodeceptionTester','','$2a$08$BLDQsKUvtOhShXbpp7rs8OgnAFTTjy8henwrrlJrPK/5hrtaHwEJi',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-16 12:34:56','2015-04-16 12:34:56'),
	(94,'1513640278@1311701320.com','CodeceptionTester','','$2a$08$vtDC.elbVVad1kS3gqV4L.Qyjsp7K0KNDd9Nmbf4F8pF9NiLeKFxC',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-16 12:34:57','2015-04-16 12:34:57'),
	(95,'1775257485@944163275.com','CodeceptionTester','','$2a$08$7iJENS3Y2NSz0ssy1VZHfO/uHwhuflwo8kig35sVmHoPatyoaNvH2',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-16 12:35:10','2015-04-16 12:35:10'),
	(96,'1467145428@1461509071.com','CodeceptionTester','','$2a$08$Te1Bn2xVNOqZy5.JHY2jKu3i6jjpK3WboDyGhnxORhr86Thw.TzDC',0,'0',0,2130706433,'Symfony2 BrowserKit','2015-04-16 12:35:10','2015-04-16 12:35:10');

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;



--
-- Dumping routines (FUNCTION) for database 'phalcon.local'
--
DELIMITER ;;

# Dump of FUNCTION REBUILD_TREE
# ------------------------------------------------------------

/*!50003 DROP FUNCTION IF EXISTS `REBUILD_TREE` */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 FUNCTION `REBUILD_TREE`() RETURNS int(11)
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
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
DELIMITER ;

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
