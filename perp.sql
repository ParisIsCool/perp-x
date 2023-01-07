-- --------------------------------------------------------
-- Host:                         perp.asocket.net
-- Server version:               10.4.17-MariaDB-1:10.4.17+maria~bionic-log - mariadb.org binary distribution
-- Server OS:                    debian-linux-gnu
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table s123_aSocket_PERP.achievements
CREATE TABLE IF NOT EXISTS `achievements` (
  `perpid` mediumtext NOT NULL,
  `id` text NOT NULL,
  `progress` bigint(20) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table s123_aSocket_PERP.perp_achievements
CREATE TABLE IF NOT EXISTS `perp_achievements` (
  `perpid` int(11) DEFAULT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`data`))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table s123_aSocket_PERP.perp_blacklists
CREATE TABLE IF NOT EXISTS `perp_blacklists` (
  `id` varchar(50) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `type` varchar(50) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `expire` bigint(20) NOT NULL,
  `value` varchar(50) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL DEFAULT '',
  `reason` varchar(100) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `adminid` varchar(50) CHARACTER SET latin1 COLLATE latin1_general_cs DEFAULT NULL,
  PRIMARY KEY (`id`,`type`,`value`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table s123_aSocket_PERP.perp_collectables
CREATE TABLE IF NOT EXISTS `perp_collectables` (
  `perpid` int(11) DEFAULT NULL,
  `collectable` tinytext DEFAULT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`data`))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table s123_aSocket_PERP.perp_extra
CREATE TABLE IF NOT EXISTS `perp_extra` (
  `id` varchar(30) DEFAULT NULL,
  `extra1` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table s123_aSocket_PERP.perp_freevip
CREATE TABLE IF NOT EXISTS `perp_freevip` (
  `steamid` text DEFAULT NULL,
  `time` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table s123_aSocket_PERP.perp_organization
CREATE TABLE IF NOT EXISTS `perp_organization` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `motd` text CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `owner` text CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  PRIMARY KEY (`id`,`owner`(50))
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table s123_aSocket_PERP.perp_users
CREATE TABLE IF NOT EXISTS `perp_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `steamid` text NOT NULL,
  `rp_name_first` varchar(50) NOT NULL DEFAULT 'John',
  `rp_name_last` varchar(50) NOT NULL DEFAULT 'Doe',
  `time_played` bigint(20) NOT NULL DEFAULT 0,
  `cash` bigint(20) NOT NULL DEFAULT 0,
  `bank` bigint(20) NOT NULL DEFAULT 10000,
  `model` varchar(400) NOT NULL DEFAULT '[]',
  `items` varchar(1000) NOT NULL DEFAULT '[]',
  `skills` varchar(150) NOT NULL DEFAULT '000000000000',
  `genes` varchar(150) NOT NULL DEFAULT '{"Genes":[0.0,0.0,0.0,0.0,0.0],"FreeGenes":5.0}',
  `formulas` varchar(150) NOT NULL DEFAULT '',
  `organization` int(11) NOT NULL DEFAULT 0,
  `ammo` varchar(50) NOT NULL DEFAULT '0',
  `ringtone` int(11) NOT NULL DEFAULT 0,
  `last_played` bigint(20) NOT NULL DEFAULT 0,
  `physgun_col` tinytext DEFAULT NULL,
  `background` tinytext DEFAULT NULL,
  `reputation` bigint(20) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table s123_aSocket_PERP.perp_vehicles
CREATE TABLE IF NOT EXISTS `perp_vehicles` (
  `auto_inc` int(11) NOT NULL AUTO_INCREMENT,
  `id` varchar(50) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `car_id` varchar(30) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `paint_id` int(11) NOT NULL DEFAULT 1,
  `headlight` varchar(50) NOT NULL DEFAULT '[]',
  `underglow` varchar(50) NOT NULL DEFAULT '[]',
  `anti-theft` int(11) NOT NULL DEFAULT 0,
  `hydraulics` int(11) NOT NULL DEFAULT 0,
  `custom_horn` int(11) NOT NULL DEFAULT 0,
  `rgb_colour` varchar(100) CHARACTER SET latin1 COLLATE latin1_general_cs DEFAULT '',
  `bodygroups` varchar(200) CHARACTER SET latin1 COLLATE latin1_general_cs DEFAULT '',
  `disabled` int(11) NOT NULL DEFAULT 0,
  `fuel` int(11) NOT NULL DEFAULT 10000,
  `vc_persist` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `license_plate` varchar(150) DEFAULT 'FIX ME',
  `engine` int(11) DEFAULT 0,
  `turbo` int(11) DEFAULT 0,
  PRIMARY KEY (`id`,`car_id`) USING BTREE,
  KEY `auto_inc` (`auto_inc`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table s123_aSocket_PERP.perp_warehouse
CREATE TABLE IF NOT EXISTS `perp_warehouse` (
  `id` text CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `itemid` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`id`(50),`itemid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
