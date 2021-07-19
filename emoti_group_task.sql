-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jul 17, 2021 at 05:32 PM
-- Server version: 5.7.23
-- PHP Version: 7.3.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ovalhr`
--

-- --------------------------------------------------------

--
-- Table structure for table `doctrine_migration_versions`
--

DROP TABLE IF EXISTS `doctrine_migration_versions`;
CREATE TABLE IF NOT EXISTS `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reservations`
--

DROP TABLE IF EXISTS `reservations`;
CREATE TABLE IF NOT EXISTS `reservations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  `total_bill` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `reservations`
--

INSERT INTO `reservations` (`id`, `customer_id`, `from_date`, `to_date`, `total_bill`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
(1, 1, '2021-07-08', '2021-07-10', 1500, '2021-07-07 16:22:37', NULL, NULL, NULL),
(2, 1, '2021-07-08', '2021-07-10', 1500, '2021-07-07 16:24:21', NULL, NULL, NULL),
(3, 1, '2021-07-08', '2021-07-10', 1500, '2021-07-07 16:27:19', NULL, NULL, NULL),
(4, 1, '2021-07-08', '2021-07-10', 1500, '2021-07-07 16:36:37', NULL, NULL, NULL),
(5, 1, '2021-07-08', '2021-07-10', 1500, '2021-07-07 16:37:13', NULL, NULL, NULL),
(6, 1, '2021-07-10', '2021-07-11', 1000, '2021-07-09 15:06:51', NULL, NULL, NULL),
(7, 1, '2021-07-10', '2021-07-11', 1000, '2021-07-09 20:55:19', NULL, NULL, NULL),
(8, 1, '2021-07-13', '2021-07-14', 1000, '2021-07-13 07:22:08', NULL, NULL, NULL),
(9, 2, '2021-07-15', '2021-07-15', 500, '2021-07-14 11:12:26', NULL, NULL, NULL),
(10, 2, '2021-07-14', '2021-07-14', 500, '2021-07-14 14:56:42', NULL, NULL, NULL),
(11, 2, '2021-07-14', '2021-07-14', 500, '2021-07-14 14:57:13', NULL, NULL, NULL),
(12, 2, '2021-07-15', '2021-07-15', 500, '2021-07-14 15:00:59', NULL, NULL, NULL),
(13, 2, '2021-07-15', '2021-07-15', 500, '2021-07-14 15:02:18', NULL, NULL, NULL),
(14, 2, '2021-07-15', '2021-07-15', 500, '2021-07-14 15:03:08', NULL, NULL, NULL),
(15, 2, '2021-07-15', '2021-07-15', 500, '2021-07-14 19:14:18', NULL, NULL, NULL),
(16, 2, '2021-07-15', '2021-07-15', 500, '2021-07-14 19:14:25', NULL, NULL, NULL),
(17, 1, '2021-07-16', '2021-07-16', 1000, '2021-07-16 03:48:23', NULL, NULL, NULL),
(18, 2, '2021-07-17', '2021-07-17', 1000, '2021-07-16 04:18:46', NULL, NULL, NULL),
(19, 2, '2021-07-17', '2021-07-17', 500, '2021-07-16 04:18:46', NULL, NULL, NULL),
(20, 2, '2021-07-17', '2021-07-17', 500, '2021-07-16 04:18:47', NULL, NULL, NULL),
(21, 2, '2021-07-17', '2021-07-17', 500, '2021-07-16 04:18:48', NULL, NULL, NULL),
(22, 2, '2021-07-17', '2021-07-17', 500, '2021-07-16 04:18:49', NULL, NULL, NULL),
(23, 2, '2021-07-17', '2021-07-17', 500, '2021-07-16 04:19:25', NULL, NULL, NULL),
(24, 1, '2021-07-16', '2021-07-16', 500, '2021-07-16 05:06:21', NULL, NULL, NULL),
(25, 1, '2021-07-18', '2021-07-18', 1000, '2021-07-17 16:54:30', NULL, NULL, NULL),
(26, 1, '2021-07-18', '2021-07-18', 500, '2021-07-17 16:55:20', NULL, NULL, NULL),
(27, 1, '2021-07-18', '2021-07-18', 500, '2021-07-17 16:56:08', NULL, NULL, NULL),
(28, 1, '2021-07-18', '2021-07-24', 3500, '2021-07-17 17:22:26', NULL, NULL, NULL),
(29, 1, '2021-07-18', '2021-07-24', 3500, '2021-07-17 17:22:36', NULL, NULL, NULL),
(30, 1, '2021-07-18', '2021-07-24', 3500, '2021-07-17 17:23:06', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `reservation_dates`
--

DROP TABLE IF EXISTS `reservation_dates`;
CREATE TABLE IF NOT EXISTS `reservation_dates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reservation_id` int(11) NOT NULL COMMENT 'from reservations table',
  `room_id` int(11) NOT NULL,
  `reservation_date` date NOT NULL,
  `price` int(11) NOT NULL,
  `status` int(2) NOT NULL DEFAULT '1' COMMENT '1=booking,2=running,3=checked out',
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `reservation_dates`
--

INSERT INTO `reservation_dates` (`id`, `reservation_id`, `room_id`, `reservation_date`, `price`, `status`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(1, 1, 1, '2021-07-07', 500, 1, 1, '2021-07-07 21:00:41', NULL, NULL),
(2, 1, 1, '2021-07-07', 500, 1, 1, '2021-07-07 21:13:57', NULL, NULL),
(3, 1, 2, '2021-07-07', 500, 1, 1, '2021-07-07 21:13:57', NULL, NULL),
(4, 1, 3, '2021-07-07', 500, 1, 1, '2021-07-07 21:13:57', NULL, NULL),
(5, 1, 4, '2021-07-07', 500, 1, 1, '2021-07-07 21:13:57', NULL, NULL),
(6, 1, 5, '2021-07-07', 500, 1, 1, '2021-07-07 21:13:57', NULL, NULL),
(7, 1, 6, '2021-07-07', 500, 1, 1, '2021-07-07 21:13:57', NULL, NULL),
(8, 3, 1, '2021-07-08', 500, 1, 1, '2021-07-07 16:27:19', NULL, NULL),
(9, 3, 1, '2021-07-09', 500, 1, 1, '2021-07-07 16:27:19', NULL, NULL),
(10, 3, 1, '2021-07-10', 500, 1, 1, '2021-07-07 16:27:19', NULL, NULL),
(11, 4, 2, '2021-07-08', 500, 1, 1, '2021-07-07 16:36:37', NULL, NULL),
(12, 4, 2, '2021-07-09', 500, 1, 1, '2021-07-07 16:36:37', NULL, NULL),
(13, 4, 2, '2021-07-10', 500, 1, 1, '2021-07-07 16:36:37', NULL, NULL),
(14, 5, 3, '2021-07-08', 500, 1, 1, '2021-07-07 16:37:13', NULL, NULL),
(15, 5, 3, '2021-07-09', 500, 1, 1, '2021-07-07 16:37:13', NULL, NULL),
(16, 5, 3, '2021-07-10', 500, 1, 1, '2021-07-07 16:37:13', NULL, NULL),
(17, 1, 1, '2021-07-09', 500, 1, 1, '2021-07-07 23:24:15', NULL, NULL),
(18, 1, 2, '2021-07-09', 500, 1, 1, '2021-07-07 23:24:15', NULL, NULL),
(19, 1, 3, '2021-07-09', 500, 1, 1, '2021-07-07 23:24:15', NULL, NULL),
(20, 1, 4, '2021-07-09', 500, 1, 1, '2021-07-07 23:24:15', NULL, NULL),
(21, 1, 5, '2021-07-09', 500, 1, 1, '2021-07-07 23:24:15', NULL, NULL),
(22, 1, 6, '2021-07-09', 500, 1, 1, '2021-07-07 23:24:15', NULL, NULL),
(23, 1, 5, '2021-07-08', 500, 1, 1, '2021-07-07 23:24:15', NULL, NULL),
(24, 1, 5, '2021-07-08', 500, 1, 1, '2021-07-07 23:24:15', NULL, NULL),
(25, 6, 4, '2021-07-10', 500, 1, 1, '2021-07-09 15:06:51', NULL, NULL),
(26, 6, 4, '2021-07-11', 500, 1, 1, '2021-07-09 15:06:51', NULL, NULL),
(27, 7, 5, '2021-07-10', 500, 1, 1, '2021-07-09 20:55:19', NULL, NULL),
(28, 7, 5, '2021-07-11', 500, 1, 1, '2021-07-09 20:55:19', NULL, NULL),
(29, 8, 1, '2021-07-13', 500, 1, 1, '2021-07-13 07:22:08', NULL, NULL),
(30, 8, 1, '2021-07-14', 500, 1, 1, '2021-07-13 07:22:08', NULL, NULL),
(31, 9, 1, '2021-07-15', 500, 1, 2, '2021-07-14 11:12:26', NULL, NULL),
(32, 10, 2, '2021-07-14', 500, 1, 2, '2021-07-14 14:56:42', NULL, NULL),
(33, 11, 3, '2021-07-14', 500, 1, 2, '2021-07-14 14:57:13', NULL, NULL),
(34, 12, 4, '2021-07-15', 500, 1, 2, '2021-07-14 15:00:59', NULL, NULL),
(35, 13, 3, '2021-07-15', 500, 1, 2, '2021-07-14 15:02:18', NULL, NULL),
(36, 14, 2, '2021-07-15', 500, 1, 2, '2021-07-14 15:03:08', NULL, NULL),
(37, 15, 5, '2021-07-15', 500, 1, 2, '2021-07-14 19:14:18', NULL, NULL),
(38, 16, 6, '2021-07-15', 500, 1, 2, '2021-07-14 19:14:25', NULL, NULL),
(39, 17, 1, '2021-07-16', 1000, 1, 1, '2021-07-16 03:48:24', NULL, NULL),
(40, 18, 1, '2021-07-17', 1000, 1, 2, '2021-07-16 04:18:46', NULL, NULL),
(41, 19, 2, '2021-07-17', 500, 1, 2, '2021-07-16 04:18:46', NULL, NULL),
(42, 20, 3, '2021-07-17', 500, 1, 2, '2021-07-16 04:18:47', NULL, NULL),
(43, 21, 4, '2021-07-17', 500, 1, 2, '2021-07-16 04:18:48', NULL, NULL),
(44, 22, 5, '2021-07-17', 500, 1, 2, '2021-07-16 04:18:49', NULL, NULL),
(45, 23, 6, '2021-07-17', 500, 1, 2, '2021-07-16 04:19:25', NULL, NULL),
(46, 24, 2, '2021-07-16', 500, 1, 1, '2021-07-16 05:06:21', NULL, NULL),
(47, 25, 1, '2021-07-18', 1000, 1, 1, '2021-07-17 16:54:31', NULL, NULL),
(48, 26, 2, '2021-07-18', 500, 1, 1, '2021-07-17 16:55:20', NULL, NULL),
(49, 27, 3, '2021-07-18', 500, 1, 1, '2021-07-17 16:56:08', NULL, NULL),
(50, 28, 5, '2021-07-18', 500, 1, 1, '2021-07-17 17:22:26', NULL, NULL),
(51, 28, 5, '2021-07-19', 500, 1, 1, '2021-07-17 17:22:26', NULL, NULL),
(52, 28, 5, '2021-07-20', 500, 1, 1, '2021-07-17 17:22:26', NULL, NULL),
(53, 28, 5, '2021-07-21', 500, 1, 1, '2021-07-17 17:22:26', NULL, NULL),
(54, 28, 5, '2021-07-22', 500, 1, 1, '2021-07-17 17:22:26', NULL, NULL),
(55, 28, 5, '2021-07-23', 500, 1, 1, '2021-07-17 17:22:26', NULL, NULL),
(56, 28, 5, '2021-07-24', 500, 1, 1, '2021-07-17 17:22:26', NULL, NULL),
(57, 29, 4, '2021-07-18', 500, 1, 1, '2021-07-17 17:22:36', NULL, NULL),
(58, 29, 4, '2021-07-19', 500, 1, 1, '2021-07-17 17:22:36', NULL, NULL),
(59, 29, 4, '2021-07-20', 500, 1, 1, '2021-07-17 17:22:36', NULL, NULL),
(60, 29, 4, '2021-07-21', 500, 1, 1, '2021-07-17 17:22:36', NULL, NULL),
(61, 29, 4, '2021-07-22', 500, 1, 1, '2021-07-17 17:22:36', NULL, NULL),
(62, 29, 4, '2021-07-23', 500, 1, 1, '2021-07-17 17:22:36', NULL, NULL),
(63, 29, 4, '2021-07-24', 500, 1, 1, '2021-07-17 17:22:36', NULL, NULL),
(64, 30, 6, '2021-07-18', 500, 1, 1, '2021-07-17 17:23:06', NULL, NULL),
(65, 30, 6, '2021-07-19', 500, 1, 1, '2021-07-17 17:23:06', NULL, NULL),
(66, 30, 6, '2021-07-20', 500, 1, 1, '2021-07-17 17:23:06', NULL, NULL),
(67, 30, 6, '2021-07-21', 500, 1, 1, '2021-07-17 17:23:06', NULL, NULL),
(68, 30, 6, '2021-07-22', 500, 1, 1, '2021-07-17 17:23:06', NULL, NULL),
(69, 30, 6, '2021-07-23', 500, 1, 1, '2021-07-17 17:23:06', NULL, NULL),
(70, 30, 6, '2021-07-24', 500, 1, 1, '2021-07-17 17:23:06', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
CREATE TABLE IF NOT EXISTS `rooms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `location` varchar(200) DEFAULT NULL,
  `price` int(11) NOT NULL,
  `room_type` int(11) NOT NULL DEFAULT '1' COMMENT '1=normal,2=ac',
  `is_active` int(1) NOT NULL DEFAULT '1' COMMENT '1=active,0=inactive',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int(11) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`id`, `name`, `location`, `price`, `room_type`, `is_active`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
(1, 'room1', NULL, 1000, 1, 1, '2021-07-06 08:12:31', 1, NULL, NULL),
(2, 'room2', NULL, 500, 1, 1, '2021-07-06 08:12:31', 1, NULL, NULL),
(3, 'room3', NULL, 500, 1, 1, '2021-07-06 08:12:52', 1, NULL, NULL),
(4, 'room4', NULL, 500, 1, 1, '2021-07-06 08:12:52', 1, NULL, NULL),
(5, 'room5', NULL, 500, 1, 1, '2021-07-06 08:13:14', 1, NULL, NULL),
(6, 'room6', NULL, 500, 1, 1, '2021-07-06 08:13:14', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '1=customer,2=admin',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_1483A5E9E7927C74` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `email`, `roles`, `password`, `type`) VALUES
(1, 'mr.tamal0007@gmail.com', '[\"ROLE_USER\"]', '$2y$13$zPcki4U4TywBGzj/ynue6OQYOiD8yF4UMw8ZEcOMeRevwp/4YYl/S', 1),
(2, 'mr.tamal00007@gmail.com', '[\"ROLE_ADMIN\"]', '$2y$13$DHlou9CeSf1ZHusxUmwuDOsenVNwJhM2diFTgRYQ/RobuthI3IBsO', 1);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
