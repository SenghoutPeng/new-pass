-- phpMyAdmin SQL Dump
-- version 5.2.2-1.fc42
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 13, 2025 at 06:36 PM
-- Server version: 8.0.41
-- PHP Version: 8.4.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `final_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_log`
--

CREATE TABLE `activity_log` (
  `id` bigint UNSIGNED NOT NULL,
  `log_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `event` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject_id` bigint UNSIGNED DEFAULT NULL,
  `causer_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `causer_id` bigint UNSIGNED DEFAULT NULL,
  `properties` json DEFAULT NULL,
  `batch_uuid` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `activity_log`
--

INSERT INTO `activity_log` (`id`, `log_name`, `description`, `subject_type`, `event`, `subject_id`, `causer_type`, `causer_id`, `properties`, `batch_uuid`, `created_at`, `updated_at`) VALUES
(15, 'admin_activities', 'Admin created', 'App\\Models\\Admin', 'created', 8, NULL, NULL, '{\"attributes\": {\"email\": \"o@gmail.com\", \"balance\": \"0.00\", \"admin_id\": 8, \"password\": \"$2y$12$kgARRMeHeVagx5P4bdeJnOwLR4WmIUYrXXweszQstRXOIwbUXOU.S\", \"username\": \"hout\", \"created_at\": \"2025-06-21T14:08:08.000000Z\", \"updated_at\": \"2025-06-21T14:08:08.000000Z\", \"profile_image\": null}}', NULL, '2025-06-21 07:08:08', '2025-06-21 07:08:08'),
(16, 'admin', 'Admin created', 'App\\Models\\Admin', 'created', 9, NULL, NULL, '{\"attributes\": {\"email\": \"oo@gmail.com\", \"balance\": \"0.00\", \"admin_id\": 9, \"password\": \"$2y$12$6NqUeDDXcioGaurnnVHtT.jQ.TMOd8ACMg6OBuUboqs82OJRS6wKG\", \"username\": \"hout\", \"created_at\": \"2025-06-21T14:16:06.000000Z\", \"updated_at\": \"2025-06-21T14:16:06.000000Z\", \"profile_image\": null}}', NULL, '2025-06-21 07:16:06', '2025-06-21 07:16:06'),
(17, 'admin', 'activity.logs.message.created', 'App\\Models\\Admin', 'created', 10, NULL, NULL, '{\"attributes\": {\"email\": \"oooo@gmail.com\", \"balance\": \"0.00\", \"admin_id\": 10, \"password\": \"$2y$12$WFsbRf4V1Ew74krYrZDwze2gSZgSO8RxfZpIIHaXahbHSaJTgHR1u\", \"username\": \"hout\", \"created_at\": \"2025-06-21T14:36:55.000000Z\", \"updated_at\": \"2025-06-21T14:36:55.000000Z\", \"profile_image\": null}}', NULL, '2025-06-21 07:36:55', '2025-06-21 07:36:55'),
(18, 'default', 'admin_registered', 'App\\Models\\Admin', NULL, 12, NULL, NULL, '{\"user_agent\": \"insomnia/10.3.1\", \"registration_ip\": \"127.0.0.1\"}', NULL, '2025-06-21 08:14:00', '2025-06-21 08:14:00'),
(19, 'default', 'admin_registered', 'App\\Models\\Admin', NULL, 13, 'App\\Models\\Admin', 13, '{\"user_agent\": \"insomnia/10.3.1\", \"registration_ip\": \"127.0.0.1\"}', NULL, '2025-06-21 08:14:58', '2025-06-21 08:14:58'),
(20, 'default', 'login_success', 'App\\Models\\Admin', NULL, 9, 'App\\Models\\Admin', 9, '{\"ip\": \"127.0.0.1\", \"login_method\": \"password\"}', NULL, '2025-06-21 08:27:27', '2025-06-21 08:27:27'),
(21, 'default', 'login_success', 'App\\Models\\Admin', NULL, 9, 'App\\Models\\Admin', 9, '{\"ip\": \"127.0.0.1\", \"login_method\": \"password\"}', NULL, '2025-06-21 08:34:32', '2025-06-21 08:34:32'),
(22, 'default', 'login_success', 'App\\Models\\Admin', NULL, 9, 'App\\Models\\Admin', 9, '{\"ip\": \"127.0.0.1\", \"login_method\": \"password\"}', NULL, '2025-06-22 04:14:59', '2025-06-22 04:14:59'),
(23, 'user', 'updated', 'App\\Models\\User', 'updated', 4, 'App\\Models\\User', 4, '{\"old\": [], \"attributes\": []}', NULL, '2025-06-22 06:50:42', '2025-06-22 06:50:42'),
(24, 'user', 'updated', 'App\\Models\\User', 'updated', 4, 'App\\Models\\User', 4, '{\"old\": [], \"attributes\": []}', NULL, '2025-06-22 07:28:10', '2025-06-22 07:28:10'),
(25, 'admin', 'updated', 'App\\Models\\Admin', 'updated', 13, 'App\\Models\\Admin', 13, '{\"old\": [], \"attributes\": []}', NULL, '2025-06-22 07:28:47', '2025-06-22 07:28:47'),
(26, 'default', 'admin logged in', NULL, NULL, NULL, NULL, NULL, '{\"email\": \"ooooooo@gmail.com\"}', NULL, '2025-06-22 07:46:40', '2025-06-22 07:46:40'),
(27, 'default', 'admin changed password', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '{\"email\": \"ooooooo@gmail.com\"}', NULL, '2025-06-22 07:47:22', '2025-06-22 07:47:22'),
(28, 'admin', 'updated', 'App\\Models\\Admin', 'updated', 13, 'App\\Models\\Admin', 13, '{\"old\": [], \"attributes\": []}', NULL, '2025-06-22 07:47:23', '2025-06-22 07:47:23'),
(29, 'default', 'admin logged out', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '{\"email\": \"ooooooo@gmail.com\"}', NULL, '2025-06-22 07:47:32', '2025-06-22 07:47:32'),
(30, 'admin', 'created', 'App\\Models\\Admin', 'created', 14, NULL, NULL, '{\"attributes\": {\"username\": \"hout\"}}', NULL, '2025-06-22 07:55:34', '2025-06-22 07:55:34'),
(31, 'default', 'admin_registered', NULL, NULL, NULL, NULL, NULL, '{\"email\": \"i@gmail.com\"}', NULL, '2025-06-22 07:55:34', '2025-06-22 07:55:34'),
(32, 'admin', 'created', 'App\\Models\\Admin', 'created', 15, NULL, NULL, '{\"attributes\": {\"username\": \"hout\"}}', NULL, '2025-06-22 07:56:39', '2025-06-22 07:56:39'),
(33, 'admin', 'created', 'App\\Models\\Admin', 'created', 16, NULL, NULL, '{\"attributes\": {\"username\": \"hout\"}}', NULL, '2025-06-22 07:58:55', '2025-06-22 07:58:55'),
(34, 'admin', 'created', 'App\\Models\\Admin', 'created', 17, NULL, NULL, '{\"attributes\": {\"username\": \"hout\"}}', NULL, '2025-06-22 07:59:48', '2025-06-22 07:59:48'),
(35, 'admin', 'created', 'App\\Models\\Admin', 'created', 18, NULL, NULL, '{\"attributes\": {\"username\": \"hout\"}}', NULL, '2025-06-22 08:02:17', '2025-06-22 08:02:17'),
(36, 'default', 'Admin signed up', NULL, NULL, NULL, 'App\\Models\\Admin', 18, '{\"email\": \"m@gmail.com\"}', NULL, '2025-06-22 08:02:17', '2025-06-22 08:02:17'),
(37, 'organization', 'created', 'App\\Models\\Organization', 'created', 2, NULL, NULL, '{\"attributes\": {\"org_id\": 2, \"org_name\": \"Tech Cambodia\"}}', NULL, '2025-06-23 02:06:52', '2025-06-23 02:06:52'),
(38, 'default', 'organization logged in', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '{\"email\": \"tech@cambodia.org\"}', NULL, '2025-06-23 02:29:54', '2025-06-23 02:29:54'),
(39, 'default', 'Admin Logged in', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '{\"email\": \"ooooooo@gmail.com\"}', NULL, '2025-06-23 03:10:11', '2025-06-23 03:10:11'),
(40, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-06-23 03:23:20', '2025-06-23 03:23:20'),
(41, 'default', 'organization logged in', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '{\"email\": \"tech@cambodia.org\"}', NULL, '2025-06-24 21:28:58', '2025-06-24 21:28:58'),
(42, 'default', 'organization logged in', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '{\"email\": \"tech@cambodia.org\"}', NULL, '2025-06-24 21:30:24', '2025-06-24 21:30:24'),
(43, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-06-28 07:41:40', '2025-06-28 07:41:40'),
(44, 'default', 'Admin Logged in', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '{\"email\": \"ooooooo@gmail.com\"}', NULL, '2025-06-28 09:11:49', '2025-06-28 09:11:49'),
(45, 'default', 'organization logged in', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '{\"email\": \"tech@cambodia.org\"}', NULL, '2025-06-28 09:13:25', '2025-06-28 09:13:25'),
(46, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-06-28 17:15:08', '2025-06-28 17:15:08'),
(47, 'default', 'Admin Logged in', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '{\"email\": \"ooooooo@gmail.com\"}', NULL, '2025-06-28 17:15:14', '2025-06-28 17:15:14'),
(48, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-06-28 17:45:06', '2025-06-28 17:45:06'),
(49, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-06-28 17:56:43', '2025-06-28 17:56:43'),
(50, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-06-28 17:56:45', '2025-06-28 17:56:45'),
(51, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-06-28 17:56:46', '2025-06-28 17:56:46'),
(52, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-06-28 17:56:58', '2025-06-28 17:56:58'),
(53, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-06-28 17:57:00', '2025-06-28 17:57:00'),
(54, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-06-28 17:57:01', '2025-06-28 17:57:01'),
(55, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-06-28 17:57:01', '2025-06-28 17:57:01'),
(56, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-06-28 17:57:01', '2025-06-28 17:57:01'),
(57, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-06-28 17:57:05', '2025-06-28 17:57:05'),
(58, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-06-28 17:57:05', '2025-06-28 17:57:05'),
(59, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-06-28 17:57:05', '2025-06-28 17:57:05'),
(60, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-06-28 17:57:06', '2025-06-28 17:57:06'),
(61, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-06-28 17:57:06', '2025-06-28 17:57:06'),
(62, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-06-28 17:57:06', '2025-06-28 17:57:06'),
(63, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-06-28 17:57:06', '2025-06-28 17:57:06'),
(64, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-06-28 17:57:06', '2025-06-28 17:57:06'),
(65, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-06-28 17:57:06', '2025-06-28 17:57:06'),
(66, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-06-28 17:57:07', '2025-06-28 17:57:07'),
(67, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-06-28 17:57:07', '2025-06-28 17:57:07'),
(68, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-06-28 17:57:09', '2025-06-28 17:57:09'),
(69, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-06-28 17:57:09', '2025-06-28 17:57:09'),
(70, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-06-28 17:57:25', '2025-06-28 17:57:25'),
(71, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-06-28 17:57:25', '2025-06-28 17:57:25'),
(72, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-06-28 17:57:25', '2025-06-28 17:57:25'),
(73, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-06-28 17:57:26', '2025-06-28 17:57:26'),
(74, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-06-28 17:57:26', '2025-06-28 17:57:26'),
(75, 'default', 'user signed up', NULL, NULL, NULL, 'App\\Models\\User', 5, '{\"email\": \"hoho@gmail.com\"}', NULL, '2025-06-28 17:57:47', '2025-06-28 17:57:47'),
(76, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 5, '{\"email\": \"hoho@gmail.com\"}', NULL, '2025-06-28 17:57:48', '2025-06-28 17:57:48'),
(77, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-06-28 18:00:04', '2025-06-28 18:00:04'),
(78, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-06-28 18:00:25', '2025-06-28 18:00:25'),
(79, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-06-28 18:24:35', '2025-06-28 18:24:35'),
(80, 'default', 'User logged out (API token)', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-06-28 18:24:43', '2025-06-28 18:24:43'),
(81, 'default', 'Admin Logged in', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '{\"email\": \"ooooooo@gmail.com\"}', NULL, '2025-06-30 05:47:06', '2025-06-30 05:47:06'),
(82, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-06-30 07:45:31', '2025-06-30 07:45:31'),
(83, 'default', 'organization logged in', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '{\"email\": \"tech@cambodia.org\"}', NULL, '2025-06-30 08:23:00', '2025-06-30 08:23:00'),
(84, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-07-04 08:14:07', '2025-07-04 08:14:07'),
(85, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-07-04 08:21:17', '2025-07-04 08:21:17'),
(86, 'default', 'user signed up', NULL, NULL, NULL, 'App\\Models\\User', 6, '{\"email\": \"user@gmail.com\"}', NULL, '2025-07-04 08:31:45', '2025-07-04 08:31:45'),
(87, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 6, '{\"email\": \"user@gmail.com\"}', NULL, '2025-07-04 08:32:32', '2025-07-04 08:32:32'),
(88, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 6, '{\"email\": \"user@gmail.com\"}', NULL, '2025-07-04 08:54:51', '2025-07-04 08:54:51'),
(89, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 6, '{\"email\": \"user@gmail.com\"}', NULL, '2025-07-04 09:01:53', '2025-07-04 09:01:53'),
(90, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-07-04 09:03:39', '2025-07-04 09:03:39'),
(91, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 6, '{\"email\": \"user@gmail.com\"}', NULL, '2025-07-04 09:06:10', '2025-07-04 09:06:10'),
(92, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 6, '{\"email\": \"user@gmail.com\"}', NULL, '2025-07-04 09:10:45', '2025-07-04 09:10:45'),
(93, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 6, '{\"email\": \"user@gmail.com\"}', NULL, '2025-07-04 09:11:58', '2025-07-04 09:11:58'),
(94, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 6, '{\"email\": \"user@gmail.com\"}', NULL, '2025-07-04 09:12:56', '2025-07-04 09:12:56'),
(95, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 6, '{\"email\": \"user@gmail.com\"}', NULL, '2025-07-04 09:20:32', '2025-07-04 09:20:32'),
(96, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 6, '{\"email\": \"user@gmail.com\"}', NULL, '2025-07-04 09:21:08', '2025-07-04 09:21:08'),
(97, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 6, '{\"email\": \"user@gmail.com\"}', NULL, '2025-07-04 09:24:21', '2025-07-04 09:24:21'),
(98, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 6, '{\"email\": \"user@gmail.com\"}', NULL, '2025-07-04 22:42:53', '2025-07-04 22:42:53'),
(99, 'default', 'User logged out (API token)', NULL, NULL, NULL, 'App\\Models\\User', 6, '{\"email\": \"user@gmail.com\"}', NULL, '2025-07-05 00:55:22', '2025-07-05 00:55:22'),
(100, 'default', 'User logged out (API token)', NULL, NULL, NULL, 'App\\Models\\User', 6, '{\"email\": \"user@gmail.com\"}', NULL, '2025-07-05 00:56:12', '2025-07-05 00:56:12'),
(101, 'default', 'User logged out (API token)', NULL, NULL, NULL, 'App\\Models\\User', 6, '{\"email\": \"user@gmail.com\"}', NULL, '2025-07-05 00:56:25', '2025-07-05 00:56:25'),
(102, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 4, '{\"email\": \"jo@gmail.com\"}', NULL, '2025-07-05 00:56:39', '2025-07-05 00:56:39'),
(103, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 6, '{\"email\": \"user@gmail.com\"}', NULL, '2025-07-07 09:07:55', '2025-07-07 09:07:55'),
(104, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 1, '{\"email\": \"hout@gmail.com\"}', NULL, '2025-07-08 00:19:25', '2025-07-08 00:19:25'),
(105, 'default', 'User logged out (API token)', NULL, NULL, NULL, 'App\\Models\\User', 1, '{\"email\": \"hout@gmail.com\"}', NULL, '2025-07-08 00:34:05', '2025-07-08 00:34:05'),
(106, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 6, '{\"email\": \"io@gmail.com\"}', NULL, '2025-07-08 09:06:30', '2025-07-08 09:06:30'),
(107, 'default', 'user changed password', NULL, NULL, NULL, 'App\\Models\\User', 6, '{\"email\": \"io@gmail.com\"}', NULL, '2025-07-08 09:13:50', '2025-07-08 09:13:50'),
(108, 'default', 'Organizer created an event', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '{\"email\": \"tech@cambodia.org\"}', NULL, '2025-07-09 00:08:28', '2025-07-09 00:08:28'),
(109, 'default', 'Admin Logged in', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '{\"email\": \"ooooooo@gmail.com\"}', NULL, '2025-07-09 03:29:44', '2025-07-09 03:29:44'),
(110, 'default', 'User changed password', NULL, NULL, NULL, 'App\\Models\\User', 6, '{\"email\": \"io@gmail.com\"}', NULL, '2025-07-09 03:42:29', '2025-07-09 03:42:29'),
(111, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 6, '{\"email\": \"io@gmail.com\"}', NULL, '2025-07-09 03:44:20', '2025-07-09 03:44:20'),
(112, 'default', 'organization logged in', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '{\"email\": \"tech@cambodia.org\"}', NULL, '2025-07-09 04:09:32', '2025-07-09 04:09:32'),
(113, 'default', 'organization changed password', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '{\"email\": \"tech@cambodia.org\"}', NULL, '2025-07-09 04:10:35', '2025-07-09 04:10:35'),
(114, 'default', 'Organization viewed feedback', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '{\"event_id\": \"8\"}', NULL, '2025-07-09 10:33:49', '2025-07-09 10:33:49'),
(115, 'default', 'User viewed all events', NULL, NULL, NULL, NULL, NULL, '[]', NULL, '2025-07-09 10:48:24', '2025-07-09 10:48:24'),
(116, 'default', 'User viewed all events', NULL, NULL, NULL, NULL, NULL, '[]', NULL, '2025-07-09 10:49:28', '2025-07-09 10:49:28'),
(117, 'default', 'User deleted all ratings for an event', NULL, NULL, NULL, 'App\\Models\\User', 6, '{\"event_id\": \"8\", \"deleted_count\": 4}', NULL, '2025-07-09 10:59:37', '2025-07-09 10:59:37'),
(118, 'default', 'Organization updated event', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '{\"event_id\": \"10\", \"event_title\": \"Updated Event Title\"}', NULL, '2025-07-09 11:12:44', '2025-07-09 11:12:44'),
(119, 'default', 'User recharged balance', NULL, NULL, NULL, 'App\\Models\\User', 6, '{\"amount\": 100.5}', NULL, '2025-07-09 11:13:46', '2025-07-09 11:13:46'),
(120, 'default', 'User viewed single event', NULL, NULL, NULL, NULL, NULL, '{\"event_id\": \"8\", \"event_title\": \"Small Title Change\"}', NULL, '2025-07-09 11:14:07', '2025-07-09 11:14:07'),
(121, 'default', 'Organization updated profile', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '[]', NULL, '2025-07-09 11:14:15', '2025-07-09 11:14:15'),
(122, 'default', 'User viewed all events', NULL, NULL, NULL, NULL, NULL, '[]', NULL, '2025-07-09 11:18:28', '2025-07-09 11:18:28'),
(123, 'default', 'User viewed own tickets', NULL, NULL, NULL, 'App\\Models\\User', 6, '[]', NULL, '2025-07-09 11:18:30', '2025-07-09 11:18:30'),
(124, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 6, '{\"email\": \"io@gmail.com\"}', NULL, '2025-07-09 11:18:34', '2025-07-09 11:18:34'),
(125, 'default', 'Admin Logged in', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '{\"email\": \"ooooooo@gmail.com\"}', NULL, '2025-07-09 11:18:38', '2025-07-09 11:18:38'),
(126, 'default', 'User viewed all events', NULL, NULL, NULL, NULL, NULL, '[]', NULL, '2025-07-09 11:44:56', '2025-07-09 11:44:56'),
(127, 'default', 'User viewed own tickets', NULL, NULL, NULL, 'App\\Models\\User', 6, '[]', NULL, '2025-07-09 11:44:59', '2025-07-09 11:44:59'),
(128, 'default', 'Admin upated organization profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-09 12:02:57', '2025-07-09 12:02:57'),
(129, 'default', 'Admin upated organization profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-09 12:03:05', '2025-07-09 12:03:05'),
(130, 'default', 'Admin updated user profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '{\"user_id\": \"6\"}', NULL, '2025-07-09 12:08:06', '2025-07-09 12:08:06'),
(131, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '{\"event_id\": \"10\", \"event_title\": \"Admin Edited Pending Event Title\"}', NULL, '2025-07-09 12:21:07', '2025-07-09 12:21:07'),
(132, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '{\"event_id\": \"9\", \"event_title\": \"Concerts 2025\"}', NULL, '2025-07-09 12:23:48', '2025-07-09 12:23:48'),
(133, 'default', 'organization logged in', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '{\"email\": \"tech@cambodia.org\"}', NULL, '2025-07-09 12:29:31', '2025-07-09 12:29:31'),
(134, 'default', 'Organization viewed feedback', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '{\"event_id\": \"8\"}', NULL, '2025-07-09 12:29:44', '2025-07-09 12:29:44'),
(135, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '{\"event_id\": \"8\", \"event_title\": \"Small Title Change\"}', NULL, '2025-07-09 12:31:24', '2025-07-09 12:31:24'),
(136, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '{\"event_id\": \"8\", \"event_title\": \"Small Title Change\"}', NULL, '2025-07-09 12:32:00', '2025-07-09 12:32:00'),
(137, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '{\"event_id\": \"8\", \"event_title\": \"Small Title Change\"}', NULL, '2025-07-09 12:32:01', '2025-07-09 12:32:01'),
(138, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '{\"event_id\": \"8\", \"event_title\": \"Small Title Change\"}', NULL, '2025-07-09 12:32:05', '2025-07-09 12:32:05'),
(139, 'default', 'Organization updated event', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '{\"event_id\": \"8\", \"event_title\": \"Small Title Change\"}', NULL, '2025-07-09 12:35:18', '2025-07-09 12:35:18'),
(140, 'default', 'Organization updated event', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '{\"event_id\": \"8\", \"event_title\": \"Small Title Change\"}', NULL, '2025-07-09 12:35:30', '2025-07-09 12:35:30'),
(141, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '{\"event_id\": \"9\", \"event_title\": \"Concerts 2025\"}', NULL, '2025-07-09 12:36:55', '2025-07-09 12:36:55'),
(142, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '{\"event_id\": \"9\", \"event_title\": \"Concerts 2025\"}', NULL, '2025-07-09 12:37:20', '2025-07-09 12:37:20'),
(143, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '{\"event_id\": \"9\", \"event_title\": \"Concerts 2025\"}', NULL, '2025-07-09 12:37:38', '2025-07-09 12:37:38'),
(144, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '{\"event_id\": \"9\", \"event_title\": \"Concerts 2025\"}', NULL, '2025-07-09 12:41:15', '2025-07-09 12:41:15'),
(145, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '{\"event_id\": \"10\", \"event_title\": \"Admin Edited Pending Event Title\"}', NULL, '2025-07-09 12:58:59', '2025-07-09 12:58:59'),
(146, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '{\"event_id\": \"9\", \"event_title\": \"Concerts 2025\"}', NULL, '2025-07-09 13:01:01', '2025-07-09 13:01:01'),
(147, 'default', 'Admin Logged in', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '{\"email\": \"ooooooo@gmail.com\"}', NULL, '2025-07-09 21:16:36', '2025-07-09 21:16:36'),
(148, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-09 21:16:36', '2025-07-09 21:16:36'),
(149, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-09 21:16:42', '2025-07-09 21:16:42'),
(150, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-09 21:17:35', '2025-07-09 21:17:35'),
(151, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-09 21:19:14', '2025-07-09 21:19:14'),
(152, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-09 21:19:52', '2025-07-09 21:19:52'),
(153, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-09 21:20:22', '2025-07-09 21:20:22'),
(154, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-09 21:20:50', '2025-07-09 21:20:50'),
(155, 'default', 'Admin Logged in', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '{\"email\": \"ooooooo@gmail.com\"}', NULL, '2025-07-09 21:22:09', '2025-07-09 21:22:09'),
(156, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-09 21:22:09', '2025-07-09 21:22:09'),
(157, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-09 21:28:14', '2025-07-09 21:28:14'),
(158, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-09 21:28:23', '2025-07-09 21:28:23'),
(159, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-09 21:30:14', '2025-07-09 21:30:14'),
(160, 'default', 'Organization viewed all events', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '[]', NULL, '2025-07-09 21:40:02', '2025-07-09 21:40:02'),
(161, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-09 21:40:50', '2025-07-09 21:40:50'),
(162, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-09 21:44:32', '2025-07-09 21:44:32'),
(163, 'default', 'User viewed single event', NULL, NULL, NULL, NULL, NULL, '{\"event_id\": \"8\", \"event_title\": \"Small Title Change\"}', NULL, '2025-07-10 08:41:07', '2025-07-10 08:41:07'),
(164, 'default', 'User viewed single event', NULL, NULL, NULL, NULL, NULL, '{\"event_id\": \"9\", \"event_title\": \"Concerts 2025\"}', NULL, '2025-07-10 08:41:22', '2025-07-10 08:41:22'),
(165, 'default', 'User viewed single event', NULL, NULL, NULL, NULL, NULL, '{\"event_id\": \"8\", \"event_title\": \"Small Title Change\"}', NULL, '2025-07-10 08:41:56', '2025-07-10 08:41:56'),
(166, 'default', 'User viewed all events', NULL, NULL, NULL, NULL, NULL, '[]', NULL, '2025-07-10 08:51:18', '2025-07-10 08:51:18'),
(167, 'default', 'User viewed all events', NULL, NULL, NULL, NULL, NULL, '[]', NULL, '2025-07-10 09:26:43', '2025-07-10 09:26:43'),
(168, 'default', 'User viewed all events', NULL, NULL, NULL, NULL, NULL, '[]', NULL, '2025-07-10 09:27:11', '2025-07-10 09:27:11'),
(169, 'default', 'User viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 09:27:18', '2025-07-10 09:27:18'),
(170, 'default', 'User viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 09:27:37', '2025-07-10 09:27:37'),
(171, 'default', 'User viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 09:29:28', '2025-07-10 09:29:28'),
(172, 'default', 'User viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 09:33:16', '2025-07-10 09:33:16'),
(173, 'default', 'User viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 09:33:29', '2025-07-10 09:33:29'),
(174, 'default', 'Admin Logged in', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"email\": \"hout@gmail.com\"}', NULL, '2025-07-10 09:47:11', '2025-07-10 09:47:11'),
(175, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 09:47:37', '2025-07-10 09:47:37'),
(176, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 09:47:41', '2025-07-10 09:47:41'),
(177, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 09:47:44', '2025-07-10 09:47:44'),
(178, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 09:47:44', '2025-07-10 09:47:44'),
(179, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 09:49:57', '2025-07-10 09:49:57'),
(180, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 09:49:59', '2025-07-10 09:49:59'),
(181, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 09:50:00', '2025-07-10 09:50:00'),
(182, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 09:50:48', '2025-07-10 09:50:48'),
(183, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 09:50:57', '2025-07-10 09:50:57'),
(184, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 09:51:15', '2025-07-10 09:51:15'),
(185, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 09:51:15', '2025-07-10 09:51:15'),
(186, 'default', 'Admin viewed single event request', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '{\"event_id\": \"12\", \"event_title\": \"Change  2025\"}', NULL, '2025-07-10 09:51:19', '2025-07-10 09:51:19'),
(187, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 09:51:46', '2025-07-10 09:51:46'),
(188, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 09:51:46', '2025-07-10 09:51:46'),
(189, 'default', 'Admin viewed single event request', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '{\"event_id\": \"12\", \"event_title\": \"Change  2025\"}', NULL, '2025-07-10 09:51:48', '2025-07-10 09:51:48'),
(190, 'default', 'Admin viewed single event request', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '{\"event_id\": \"12\", \"event_title\": \"Change  2025\"}', NULL, '2025-07-10 09:51:50', '2025-07-10 09:51:50'),
(191, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 09:55:11', '2025-07-10 09:55:11'),
(192, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 09:55:11', '2025-07-10 09:55:11'),
(193, 'default', 'Admin viewed single event request', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '{\"event_id\": \"12\", \"event_title\": \"Change  2025\"}', NULL, '2025-07-10 09:55:12', '2025-07-10 09:55:12'),
(194, 'default', 'Admin viewed single event request', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '{\"event_id\": \"12\", \"event_title\": \"Change  2025\"}', NULL, '2025-07-10 09:55:24', '2025-07-10 09:55:24'),
(195, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 10:05:31', '2025-07-10 10:05:31'),
(196, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 10:05:37', '2025-07-10 10:05:37'),
(197, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 10:06:02', '2025-07-10 10:06:02'),
(198, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 10:09:21', '2025-07-10 10:09:21'),
(199, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:10:00', '2025-07-10 10:10:00'),
(200, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 10:10:00', '2025-07-10 10:10:00'),
(201, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:10:01', '2025-07-10 10:10:01'),
(202, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 10:10:36', '2025-07-10 10:10:36'),
(203, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 10:11:31', '2025-07-10 10:11:31'),
(204, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:11:39', '2025-07-10 10:11:39'),
(205, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:11:40', '2025-07-10 10:11:40'),
(206, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:11:43', '2025-07-10 10:11:43'),
(207, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 10:11:43', '2025-07-10 10:11:43'),
(208, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:13:59', '2025-07-10 10:13:59'),
(209, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:14:00', '2025-07-10 10:14:00'),
(210, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:14:03', '2025-07-10 10:14:03'),
(211, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 10:14:03', '2025-07-10 10:14:03'),
(212, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:19:33', '2025-07-10 10:19:33'),
(213, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 10:19:33', '2025-07-10 10:19:33'),
(214, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:20:31', '2025-07-10 10:20:31'),
(215, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:20:33', '2025-07-10 10:20:33'),
(216, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:20:33', '2025-07-10 10:20:33'),
(217, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:20:33', '2025-07-10 10:20:33'),
(218, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:20:37', '2025-07-10 10:20:37'),
(219, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 10:20:37', '2025-07-10 10:20:37'),
(220, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 10:20:48', '2025-07-10 10:20:48'),
(221, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:20:52', '2025-07-10 10:20:52'),
(222, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 10:20:52', '2025-07-10 10:20:52'),
(223, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:21:03', '2025-07-10 10:21:03'),
(224, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:21:49', '2025-07-10 10:21:49'),
(225, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:21:49', '2025-07-10 10:21:49'),
(226, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:21:52', '2025-07-10 10:21:52'),
(227, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 10:21:52', '2025-07-10 10:21:52'),
(228, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:22:47', '2025-07-10 10:22:47'),
(229, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 10:22:47', '2025-07-10 10:22:47'),
(230, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:24:41', '2025-07-10 10:24:41'),
(231, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:24:42', '2025-07-10 10:24:42'),
(232, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:24:45', '2025-07-10 10:24:45'),
(233, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 10:24:45', '2025-07-10 10:24:45'),
(234, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:24:53', '2025-07-10 10:24:53'),
(235, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:24:54', '2025-07-10 10:24:54'),
(236, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:25:44', '2025-07-10 10:25:44'),
(237, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:25:46', '2025-07-10 10:25:46'),
(238, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:25:51', '2025-07-10 10:25:51'),
(239, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:25:52', '2025-07-10 10:25:52'),
(240, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:26:31', '2025-07-10 10:26:31'),
(241, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:26:32', '2025-07-10 10:26:32'),
(242, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:26:54', '2025-07-10 10:26:54'),
(243, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:28:03', '2025-07-10 10:28:03'),
(244, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 10:28:03', '2025-07-10 10:28:03'),
(245, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 10:28:32', '2025-07-10 10:28:32'),
(246, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 10:29:09', '2025-07-10 10:29:09'),
(247, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:29:14', '2025-07-10 10:29:14'),
(248, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 10:29:14', '2025-07-10 10:29:14'),
(249, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:31:24', '2025-07-10 10:31:24'),
(250, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:31:25', '2025-07-10 10:31:25'),
(251, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:31:27', '2025-07-10 10:31:27'),
(252, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:31:28', '2025-07-10 10:31:28'),
(253, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:31:35', '2025-07-10 10:31:35'),
(254, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 10:31:35', '2025-07-10 10:31:35'),
(255, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:32:15', '2025-07-10 10:32:15'),
(256, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:32:16', '2025-07-10 10:32:16'),
(257, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '{\"event_id\": \"10\", \"event_title\": \"Admin Edited Pending Event Title\"}', NULL, '2025-07-10 10:33:31', '2025-07-10 10:33:31'),
(258, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:33:38', '2025-07-10 10:33:38'),
(259, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 10:33:38', '2025-07-10 10:33:38'),
(260, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:34:27', '2025-07-10 10:34:27'),
(261, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:34:27', '2025-07-10 10:34:27'),
(262, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:34:36', '2025-07-10 10:34:36'),
(263, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:34:37', '2025-07-10 10:34:37'),
(264, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:34:57', '2025-07-10 10:34:57'),
(265, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:34:58', '2025-07-10 10:34:58'),
(266, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:36:28', '2025-07-10 10:36:28'),
(267, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:36:29', '2025-07-10 10:36:29'),
(268, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:36:39', '2025-07-10 10:36:39'),
(269, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '[]', NULL, '2025-07-10 10:36:39', '2025-07-10 10:36:39'),
(270, 'default', 'Admin Logged in', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"email\": \"hout@gmail.com\"}', NULL, '2025-07-10 10:37:37', '2025-07-10 10:37:37'),
(271, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:37:37', '2025-07-10 10:37:37'),
(272, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:37:41', '2025-07-10 10:37:41'),
(273, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:38:59', '2025-07-10 10:38:59'),
(274, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:39:00', '2025-07-10 10:39:00'),
(275, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:39:07', '2025-07-10 10:39:07'),
(276, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:39:07', '2025-07-10 10:39:07'),
(277, 'default', 'Admin viewed all organizations', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:43:19', '2025-07-10 10:43:19'),
(278, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:43:31', '2025-07-10 10:43:31'),
(279, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:44:48', '2025-07-10 10:44:48'),
(280, 'default', 'Admin Logged in', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"email\": \"hout@gmail.com\"}', NULL, '2025-07-10 10:44:57', '2025-07-10 10:44:57'),
(281, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:44:57', '2025-07-10 10:44:57'),
(282, 'default', 'Admin Logged in', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"email\": \"hout@gmail.com\"}', NULL, '2025-07-10 10:45:53', '2025-07-10 10:45:53'),
(283, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:45:53', '2025-07-10 10:45:53'),
(284, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:45:59', '2025-07-10 10:45:59'),
(285, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:46:01', '2025-07-10 10:46:01'),
(286, 'default', 'Admin Logged in', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"email\": \"hout@gmail.com\"}', NULL, '2025-07-10 10:48:25', '2025-07-10 10:48:25'),
(287, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:48:26', '2025-07-10 10:48:26'),
(288, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:48:36', '2025-07-10 10:48:36'),
(289, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:48:55', '2025-07-10 10:48:55'),
(290, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:48:55', '2025-07-10 10:48:55'),
(291, 'default', 'Admin Logged in', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"email\": \"hout@gmail.com\"}', NULL, '2025-07-10 10:51:28', '2025-07-10 10:51:28'),
(292, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:51:28', '2025-07-10 10:51:28'),
(293, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:52:59', '2025-07-10 10:52:59'),
(294, 'default', 'Admin Logged in', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"email\": \"hout@gmail.com\"}', NULL, '2025-07-10 10:53:19', '2025-07-10 10:53:19'),
(295, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:53:20', '2025-07-10 10:53:20'),
(296, 'default', 'Admin Logged in', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"email\": \"hout@gmail.com\"}', NULL, '2025-07-10 10:53:20', '2025-07-10 10:53:20'),
(297, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:54:22', '2025-07-10 10:54:22'),
(298, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:54:23', '2025-07-10 10:54:23'),
(299, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:54:26', '2025-07-10 10:54:26'),
(300, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:54:27', '2025-07-10 10:54:27'),
(301, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:54:33', '2025-07-10 10:54:33'),
(302, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:54:33', '2025-07-10 10:54:33'),
(303, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:55:58', '2025-07-10 10:55:58'),
(304, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:56:29', '2025-07-10 10:56:29'),
(305, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:56:30', '2025-07-10 10:56:30'),
(306, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:58:45', '2025-07-10 10:58:45'),
(307, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:58:46', '2025-07-10 10:58:46'),
(308, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:58:48', '2025-07-10 10:58:48'),
(309, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:58:49', '2025-07-10 10:58:49'),
(310, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:58:52', '2025-07-10 10:58:52'),
(311, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:58:53', '2025-07-10 10:58:53'),
(312, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:59:06', '2025-07-10 10:59:06'),
(313, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:59:07', '2025-07-10 10:59:07'),
(314, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:59:38', '2025-07-10 10:59:38'),
(315, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:59:39', '2025-07-10 10:59:39'),
(316, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:59:41', '2025-07-10 10:59:41'),
(317, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:59:41', '2025-07-10 10:59:41'),
(318, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:59:54', '2025-07-10 10:59:54'),
(319, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:59:55', '2025-07-10 10:59:55'),
(320, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:59:57', '2025-07-10 10:59:57'),
(321, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 10:59:58', '2025-07-10 10:59:58'),
(322, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"event_id\": \"12\", \"event_title\": \"Change  2025\"}', NULL, '2025-07-10 11:00:15', '2025-07-10 11:00:15'),
(323, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:00:31', '2025-07-10 11:00:31'),
(324, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:00:31', '2025-07-10 11:00:31');
INSERT INTO `activity_log` (`id`, `log_name`, `description`, `subject_type`, `event`, `subject_id`, `causer_type`, `causer_id`, `properties`, `batch_uuid`, `created_at`, `updated_at`) VALUES
(325, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:00:49', '2025-07-10 11:00:49'),
(326, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:00:50', '2025-07-10 11:00:50'),
(327, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:02:58', '2025-07-10 11:02:58'),
(328, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:03:08', '2025-07-10 11:03:08'),
(329, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:03:09', '2025-07-10 11:03:09'),
(330, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:03:49', '2025-07-10 11:03:49'),
(331, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:03:50', '2025-07-10 11:03:50'),
(332, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:03:50', '2025-07-10 11:03:50'),
(333, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:03:51', '2025-07-10 11:03:51'),
(334, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:03:52', '2025-07-10 11:03:52'),
(335, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:03:53', '2025-07-10 11:03:53'),
(336, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:03:56', '2025-07-10 11:03:56'),
(337, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:03:57', '2025-07-10 11:03:57'),
(338, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:04:06', '2025-07-10 11:04:06'),
(339, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:04:06', '2025-07-10 11:04:06'),
(340, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:04:40', '2025-07-10 11:04:40'),
(341, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:04:40', '2025-07-10 11:04:40'),
(342, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:05:34', '2025-07-10 11:05:34'),
(343, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:05:35', '2025-07-10 11:05:35'),
(344, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"event_id\": \"12\", \"event_title\": \"Change  2025\"}', NULL, '2025-07-10 11:05:47', '2025-07-10 11:05:47'),
(345, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:08:07', '2025-07-10 11:08:07'),
(346, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:08:09', '2025-07-10 11:08:09'),
(347, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:08:12', '2025-07-10 11:08:12'),
(348, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:08:13', '2025-07-10 11:08:13'),
(349, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:08:14', '2025-07-10 11:08:14'),
(350, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:08:15', '2025-07-10 11:08:15'),
(351, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:08:29', '2025-07-10 11:08:29'),
(352, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:08:29', '2025-07-10 11:08:29'),
(353, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:11:18', '2025-07-10 11:11:18'),
(354, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:11:19', '2025-07-10 11:11:19'),
(355, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:11:22', '2025-07-10 11:11:22'),
(356, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:11:22', '2025-07-10 11:11:22'),
(357, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:11:56', '2025-07-10 11:11:56'),
(358, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:12:24', '2025-07-10 11:12:24'),
(359, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:12:25', '2025-07-10 11:12:25'),
(360, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:12:27', '2025-07-10 11:12:27'),
(361, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:12:28', '2025-07-10 11:12:28'),
(362, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:12:30', '2025-07-10 11:12:30'),
(363, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:12:30', '2025-07-10 11:12:30'),
(364, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:13:11', '2025-07-10 11:13:11'),
(365, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:13:12', '2025-07-10 11:13:12'),
(366, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:13:14', '2025-07-10 11:13:14'),
(367, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:13:14', '2025-07-10 11:13:14'),
(368, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:19:57', '2025-07-10 11:19:57'),
(369, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:19:57', '2025-07-10 11:19:57'),
(370, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:19:58', '2025-07-10 11:19:58'),
(371, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:20:04', '2025-07-10 11:20:04'),
(372, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:20:04', '2025-07-10 11:20:04'),
(373, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:20:19', '2025-07-10 11:20:19'),
(374, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:20:20', '2025-07-10 11:20:20'),
(375, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:20:27', '2025-07-10 11:20:27'),
(376, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:20:28', '2025-07-10 11:20:28'),
(377, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '{\"event_id\": 10, \"event_title\": \"Admin Edited Pending Event Title\"}', NULL, '2025-07-10 11:21:03', '2025-07-10 11:21:03'),
(378, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:21:13', '2025-07-10 11:21:13'),
(379, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:21:13', '2025-07-10 11:21:13'),
(380, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"event_id\": \"12\", \"event_title\": \"Change  2025\"}', NULL, '2025-07-10 11:21:16', '2025-07-10 11:21:16'),
(381, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:21:26', '2025-07-10 11:21:26'),
(382, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:21:27', '2025-07-10 11:21:27'),
(383, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:21:27', '2025-07-10 11:21:27'),
(384, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:21:27', '2025-07-10 11:21:27'),
(385, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:21:43', '2025-07-10 11:21:43'),
(386, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:21:43', '2025-07-10 11:21:43'),
(387, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"event_id\": \"12\", \"event_title\": \"Change  2025\"}', NULL, '2025-07-10 11:21:54', '2025-07-10 11:21:54'),
(388, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:23:38', '2025-07-10 11:23:38'),
(389, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:23:39', '2025-07-10 11:23:39'),
(390, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:23:44', '2025-07-10 11:23:44'),
(391, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:23:44', '2025-07-10 11:23:44'),
(392, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:24:43', '2025-07-10 11:24:43'),
(393, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:24:43', '2025-07-10 11:24:43'),
(394, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:27:47', '2025-07-10 11:27:47'),
(395, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:27:48', '2025-07-10 11:27:48'),
(396, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"event_id\": \"12\", \"event_title\": \"Change  2025\"}', NULL, '2025-07-10 11:27:54', '2025-07-10 11:27:54'),
(397, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"event_id\": \"12\", \"event_title\": \"Change  2025\"}', NULL, '2025-07-10 11:28:01', '2025-07-10 11:28:01'),
(398, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"event_id\": \"12\", \"event_title\": \"Change  2025\"}', NULL, '2025-07-10 11:28:06', '2025-07-10 11:28:06'),
(399, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"event_id\": \"12\", \"event_title\": \"Change  2025\"}', NULL, '2025-07-10 11:28:07', '2025-07-10 11:28:07'),
(400, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"event_id\": \"12\", \"event_title\": \"Change  2025\"}', NULL, '2025-07-10 11:28:17', '2025-07-10 11:28:17'),
(401, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"event_id\": \"12\", \"event_title\": \"Change  2025\"}', NULL, '2025-07-10 11:28:17', '2025-07-10 11:28:17'),
(402, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"event_id\": \"12\", \"event_title\": \"Change  2025\"}', NULL, '2025-07-10 11:28:18', '2025-07-10 11:28:18'),
(403, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"event_id\": \"12\", \"event_title\": \"Change  2025\"}', NULL, '2025-07-10 11:28:18', '2025-07-10 11:28:18'),
(404, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"event_id\": \"12\", \"event_title\": \"Change  2025\"}', NULL, '2025-07-10 11:28:18', '2025-07-10 11:28:18'),
(405, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"event_id\": \"12\", \"event_title\": \"Change  2025\"}', NULL, '2025-07-10 11:28:25', '2025-07-10 11:28:25'),
(406, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"event_id\": \"12\", \"event_title\": \"Change\"}', NULL, '2025-07-10 11:28:47', '2025-07-10 11:28:47'),
(407, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:29:10', '2025-07-10 11:29:10'),
(408, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:29:10', '2025-07-10 11:29:10'),
(409, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:30:06', '2025-07-10 11:30:06'),
(410, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:30:07', '2025-07-10 11:30:07'),
(411, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:30:07', '2025-07-10 11:30:07'),
(412, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:30:22', '2025-07-10 11:30:22'),
(413, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:30:22', '2025-07-10 11:30:22'),
(414, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"event_id\": \"9\", \"event_title\": \"Concerts 2025\"}', NULL, '2025-07-10 11:30:30', '2025-07-10 11:30:30'),
(415, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:30:42', '2025-07-10 11:30:42'),
(416, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:30:42', '2025-07-10 11:30:42'),
(417, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"event_id\": \"12\", \"event_title\": \"Change\"}', NULL, '2025-07-10 11:30:45', '2025-07-10 11:30:45'),
(418, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"event_id\": \"12\", \"event_title\": \"Change\"}', NULL, '2025-07-10 11:30:55', '2025-07-10 11:30:55'),
(419, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:31:10', '2025-07-10 11:31:10'),
(420, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:31:11', '2025-07-10 11:31:11'),
(421, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:31:12', '2025-07-10 11:31:12'),
(422, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:31:13', '2025-07-10 11:31:13'),
(423, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:31:14', '2025-07-10 11:31:14'),
(424, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:31:15', '2025-07-10 11:31:15'),
(425, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"event_id\": \"12\", \"event_title\": \"Change\"}', NULL, '2025-07-10 11:32:07', '2025-07-10 11:32:07'),
(426, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:38:02', '2025-07-10 11:38:02'),
(427, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:38:57', '2025-07-10 11:38:57'),
(428, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:39:34', '2025-07-10 11:39:34'),
(429, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:39:34', '2025-07-10 11:39:34'),
(430, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"event_id\": \"12\", \"event_title\": \"Change\"}', NULL, '2025-07-10 11:39:41', '2025-07-10 11:39:41'),
(431, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:39:49', '2025-07-10 11:39:49'),
(432, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:39:50', '2025-07-10 11:39:50'),
(433, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:39:56', '2025-07-10 11:39:56'),
(434, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:39:56', '2025-07-10 11:39:56'),
(435, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:39:56', '2025-07-10 11:39:56'),
(436, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"event_id\": \"12\", \"event_title\": \"Change\"}', NULL, '2025-07-10 11:40:00', '2025-07-10 11:40:00'),
(437, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:40:17', '2025-07-10 11:40:17'),
(438, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:40:17', '2025-07-10 11:40:17'),
(439, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"event_id\": \"12\", \"event_title\": \"Change\"}', NULL, '2025-07-10 11:40:20', '2025-07-10 11:40:20'),
(440, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:42:40', '2025-07-10 11:42:40'),
(441, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:42:41', '2025-07-10 11:42:41'),
(442, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:42:58', '2025-07-10 11:42:58'),
(443, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:42:58', '2025-07-10 11:42:58'),
(444, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"event_id\": \"9\", \"event_title\": \"Concerts 2025\"}', NULL, '2025-07-10 11:43:01', '2025-07-10 11:43:01'),
(445, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"event_id\": \"9\", \"event_title\": \"Concerts 2025\"}', NULL, '2025-07-10 11:43:10', '2025-07-10 11:43:10'),
(446, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"event_id\": \"9\", \"event_title\": \"Concerts 2025\"}', NULL, '2025-07-10 11:43:27', '2025-07-10 11:43:27'),
(447, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:44:18', '2025-07-10 11:44:18'),
(448, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:44:18', '2025-07-10 11:44:18'),
(449, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:44:29', '2025-07-10 11:44:29'),
(450, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:44:29', '2025-07-10 11:44:29'),
(451, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:49:43', '2025-07-10 11:49:43'),
(452, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:51:25', '2025-07-10 11:51:25'),
(453, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 11:57:53', '2025-07-10 11:57:53'),
(454, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\Admin', 13, '{\"event_id\": 10, \"event_title\": \"Admin Edited Pending Event Title\"}', NULL, '2025-07-10 12:08:17', '2025-07-10 12:08:17'),
(455, 'default', 'Admin viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 12:10:48', '2025-07-10 12:10:48'),
(456, 'default', 'User viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 12:17:02', '2025-07-10 12:17:02'),
(457, 'default', 'User viewed all events', NULL, NULL, NULL, NULL, NULL, '[]', NULL, '2025-07-10 12:17:03', '2025-07-10 12:17:03'),
(458, 'default', 'User viewed all events', NULL, NULL, NULL, NULL, NULL, '[]', NULL, '2025-07-10 12:17:03', '2025-07-10 12:17:03'),
(459, 'default', 'User viewed all events', NULL, NULL, NULL, NULL, NULL, '[]', NULL, '2025-07-10 12:17:03', '2025-07-10 12:17:03'),
(460, 'default', 'User viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 12:17:03', '2025-07-10 12:17:03'),
(461, 'default', 'User logged out', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"email\": \"hout@gmail.com\"}', NULL, '2025-07-10 12:17:17', '2025-07-10 12:17:17'),
(462, 'default', 'User viewed all events', NULL, NULL, NULL, NULL, NULL, '[]', NULL, '2025-07-10 12:17:18', '2025-07-10 12:17:18'),
(463, 'default', 'User viewed all events', NULL, NULL, NULL, NULL, NULL, '[]', NULL, '2025-07-10 12:17:18', '2025-07-10 12:17:18'),
(464, 'default', 'User viewed all events', NULL, NULL, NULL, NULL, NULL, '[]', NULL, '2025-07-10 12:17:18', '2025-07-10 12:17:18'),
(465, 'default', 'User viewed all events', NULL, NULL, NULL, NULL, NULL, '[]', NULL, '2025-07-10 12:18:38', '2025-07-10 12:18:38'),
(466, 'default', 'User viewed all events', NULL, NULL, NULL, NULL, NULL, '[]', NULL, '2025-07-10 12:18:38', '2025-07-10 12:18:38'),
(467, 'default', 'User viewed all events', NULL, NULL, NULL, NULL, NULL, '[]', NULL, '2025-07-10 12:18:38', '2025-07-10 12:18:38'),
(468, 'default', 'User viewed all events', NULL, NULL, NULL, NULL, NULL, '[]', NULL, '2025-07-10 12:19:24', '2025-07-10 12:19:24'),
(469, 'default', 'User viewed all events', NULL, NULL, NULL, NULL, NULL, '[]', NULL, '2025-07-10 12:19:24', '2025-07-10 12:19:24'),
(470, 'default', 'User viewed all events', NULL, NULL, NULL, NULL, NULL, '[]', NULL, '2025-07-10 12:19:24', '2025-07-10 12:19:24'),
(471, 'default', 'User viewed all events', NULL, NULL, NULL, NULL, NULL, '[]', NULL, '2025-07-10 12:20:10', '2025-07-10 12:20:10'),
(472, 'default', 'User viewed all events', NULL, NULL, NULL, NULL, NULL, '[]', NULL, '2025-07-10 12:20:11', '2025-07-10 12:20:11'),
(473, 'default', 'User viewed all events', NULL, NULL, NULL, NULL, NULL, '[]', NULL, '2025-07-10 12:20:11', '2025-07-10 12:20:11'),
(474, 'default', 'User viewed all events', NULL, NULL, NULL, NULL, NULL, '[]', NULL, '2025-07-10 12:20:12', '2025-07-10 12:20:12'),
(475, 'default', 'User viewed all events', NULL, NULL, NULL, NULL, NULL, '[]', NULL, '2025-07-10 12:20:12', '2025-07-10 12:20:12'),
(476, 'default', 'User viewed all events', NULL, NULL, NULL, NULL, NULL, '[]', NULL, '2025-07-10 12:20:12', '2025-07-10 12:20:12'),
(477, 'default', 'User viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 12:22:01', '2025-07-10 12:22:01'),
(478, 'default', 'User viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 12:22:02', '2025-07-10 12:22:02'),
(479, 'default', 'User viewed all events', NULL, NULL, NULL, NULL, NULL, '[]', NULL, '2025-07-10 12:22:03', '2025-07-10 12:22:03'),
(480, 'default', 'User viewed all events', NULL, NULL, NULL, NULL, NULL, '[]', NULL, '2025-07-10 12:22:03', '2025-07-10 12:22:03'),
(481, 'default', 'User viewed all events', NULL, NULL, NULL, NULL, NULL, '[]', NULL, '2025-07-10 12:22:03', '2025-07-10 12:22:03'),
(482, 'default', 'User viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 12:22:03', '2025-07-10 12:22:03'),
(483, 'default', 'organization logged in', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '{\"email\": \"tech@cambodia.org\"}', NULL, '2025-07-10 12:22:12', '2025-07-10 12:22:12'),
(484, 'default', 'Organization viewed profile', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '[]', NULL, '2025-07-10 12:22:13', '2025-07-10 12:22:13'),
(485, 'default', 'Organization viewed buyer list', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '[]', NULL, '2025-07-10 12:22:13', '2025-07-10 12:22:13'),
(486, 'default', 'Organization viewed profile', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '[]', NULL, '2025-07-10 12:22:13', '2025-07-10 12:22:13'),
(487, 'default', 'Organization viewed buyer list', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '[]', NULL, '2025-07-10 12:22:13', '2025-07-10 12:22:13'),
(488, 'default', 'Organization viewed profile', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '[]', NULL, '2025-07-10 12:22:13', '2025-07-10 12:22:13'),
(489, 'default', 'Organization viewed feedback', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '{\"event_id\": 12}', NULL, '2025-07-10 12:22:16', '2025-07-10 12:22:16'),
(490, 'default', 'Organization viewed buyer list', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '[]', NULL, '2025-07-10 12:22:18', '2025-07-10 12:22:18'),
(491, 'default', 'User viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 12:22:50', '2025-07-10 12:22:50'),
(492, 'default', 'User viewed all events', NULL, NULL, NULL, NULL, NULL, '[]', NULL, '2025-07-10 12:22:50', '2025-07-10 12:22:50'),
(493, 'default', 'User viewed all events', NULL, NULL, NULL, NULL, NULL, '[]', NULL, '2025-07-10 12:22:50', '2025-07-10 12:22:50'),
(494, 'default', 'User viewed all events', NULL, NULL, NULL, NULL, NULL, '[]', NULL, '2025-07-10 12:22:50', '2025-07-10 12:22:50'),
(495, 'default', 'User viewed profile', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 12:22:50', '2025-07-10 12:22:50'),
(496, 'default', 'Organization viewed transactions', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '{\"event_id_filter\": null}', NULL, '2025-07-10 12:23:35', '2025-07-10 12:23:35'),
(497, 'default', 'Organization viewed feedback', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '{\"event_id\": 12}', NULL, '2025-07-10 12:23:35', '2025-07-10 12:23:35'),
(498, 'default', 'Organization viewed buyer list', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '[]', NULL, '2025-07-10 12:23:38', '2025-07-10 12:23:38'),
(499, 'default', 'Organization viewed feedback', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '{\"event_id\": 12}', NULL, '2025-07-10 12:23:56', '2025-07-10 12:23:56'),
(500, 'default', 'Organization viewed transactions', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '{\"event_id_filter\": null}', NULL, '2025-07-10 12:23:57', '2025-07-10 12:23:57'),
(501, 'default', 'Organization viewed buyer list', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '[]', NULL, '2025-07-10 12:24:17', '2025-07-10 12:24:17'),
(502, 'default', 'Organization viewed feedback', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '{\"event_id\": 12}', NULL, '2025-07-10 12:24:18', '2025-07-10 12:24:18'),
(503, 'default', 'Organization viewed buyer list', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '[]', NULL, '2025-07-10 12:24:18', '2025-07-10 12:24:18'),
(504, 'default', 'Organization viewed feedback', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '{\"event_id\": 12}', NULL, '2025-07-10 12:24:19', '2025-07-10 12:24:19'),
(505, 'default', 'Organization viewed transactions', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '{\"event_id_filter\": null}', NULL, '2025-07-10 12:24:20', '2025-07-10 12:24:20'),
(506, 'default', 'Organization viewed feedback', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '{\"event_id\": 12}', NULL, '2025-07-10 12:24:26', '2025-07-10 12:24:26'),
(507, 'default', 'Organization viewed buyer list', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '[]', NULL, '2025-07-10 12:24:26', '2025-07-10 12:24:26'),
(508, 'default', 'Organization viewed feedback', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '{\"event_id\": 12}', NULL, '2025-07-10 12:24:29', '2025-07-10 12:24:29'),
(509, 'default', 'Organization viewed buyer list', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '[]', NULL, '2025-07-10 12:24:29', '2025-07-10 12:24:29'),
(510, 'default', 'Admin Logged in', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"email\": \"hout@gmail.com\"}', NULL, '2025-07-10 17:56:08', '2025-07-10 17:56:08'),
(511, 'default', 'Admin viewed all event requests', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 17:59:22', '2025-07-10 17:59:22'),
(512, 'default', 'Admin viewed all event requests', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 17:59:22', '2025-07-10 17:59:22'),
(513, 'default', 'Admin viewed all event requests', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 17:59:51', '2025-07-10 17:59:51'),
(514, 'default', 'Admin viewed all event requests', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 17:59:52', '2025-07-10 17:59:52'),
(515, 'default', 'Admin viewed all event requests', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 17:59:53', '2025-07-10 17:59:53'),
(516, 'default', 'Admin viewed all event requests', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 17:59:54', '2025-07-10 17:59:54'),
(517, 'default', 'Admin viewed all event requests', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 18:00:09', '2025-07-10 18:00:09'),
(518, 'default', 'Admin viewed all event requests', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 18:00:09', '2025-07-10 18:00:09'),
(519, 'default', 'Admin viewed all event requests', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 18:00:11', '2025-07-10 18:00:11'),
(520, 'default', 'Admin viewed all event requests', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 18:00:38', '2025-07-10 18:00:38'),
(521, 'default', 'Admin viewed all event requests', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 18:02:50', '2025-07-10 18:02:50'),
(522, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 6, '{\"email\": \"io@gmail.com\"}', NULL, '2025-07-10 18:06:07', '2025-07-10 18:06:07'),
(523, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 6, '{\"email\": \"io@gmail.com\"}', NULL, '2025-07-10 18:10:07', '2025-07-10 18:10:07'),
(524, 'default', 'Admin viewed all event requests', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 18:10:17', '2025-07-10 18:10:17'),
(525, 'default', 'Admin viewed all event requests', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 18:15:32', '2025-07-10 18:15:32'),
(526, 'default', 'Admin viewed all organizations', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 18:30:37', '2025-07-10 18:30:37'),
(527, 'default', 'Admin viewed all organizations', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 18:31:20', '2025-07-10 18:31:20'),
(528, 'default', 'Admin viewed all organizations', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 18:31:21', '2025-07-10 18:31:21'),
(529, 'default', 'Admin viewed all organizations', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 18:31:31', '2025-07-10 18:31:31'),
(530, 'default', 'Admin viewed all organizations', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 18:31:31', '2025-07-10 18:31:31'),
(531, 'default', 'Admin viewed all organizations', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 18:31:47', '2025-07-10 18:31:47'),
(532, 'default', 'Admin viewed all organizations', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 18:31:59', '2025-07-10 18:31:59'),
(533, 'default', 'Admin viewed all organizations', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 18:33:49', '2025-07-10 18:33:49'),
(534, 'default', 'Admin viewed all event requests', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 18:34:01', '2025-07-10 18:34:01'),
(535, 'default', 'Admin viewed all event requests', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 18:34:05', '2025-07-10 18:34:05'),
(536, 'default', 'Admin viewed dashboard', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 18:34:54', '2025-07-10 18:34:54'),
(537, 'default', 'Admin viewed dashboard', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 18:34:54', '2025-07-10 18:34:54'),
(538, 'default', 'organization logged in', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '{\"email\": \"tech@cambodia.org\"}', NULL, '2025-07-10 18:37:20', '2025-07-10 18:37:20'),
(539, 'default', 'Organization viewed buyer list', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 18:37:21', '2025-07-10 18:37:21'),
(540, 'default', 'Organization viewed buyer list', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 18:37:24', '2025-07-10 18:37:24'),
(541, 'default', 'Organization viewed buyer list', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 18:38:00', '2025-07-10 18:38:00'),
(542, 'default', 'Organization viewed buyer list', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 18:38:00', '2025-07-10 18:38:00'),
(543, 'default', 'Organization viewed buyer list', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 18:38:02', '2025-07-10 18:38:02'),
(544, 'default', 'Organization viewed buyer list', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 18:39:12', '2025-07-10 18:39:12'),
(545, 'default', 'Organization viewed buyer list', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-10 18:39:20', '2025-07-10 18:39:20'),
(546, 'default', 'Organization viewed transactions', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"event_id_filter\": null}', NULL, '2025-07-10 18:39:25', '2025-07-10 18:39:25'),
(547, 'default', 'Organization viewed transactions', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"event_id_filter\": null}', NULL, '2025-07-10 18:40:15', '2025-07-10 18:40:15'),
(548, 'default', 'Organization viewed transactions', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"event_id_filter\": null}', NULL, '2025-07-10 18:40:32', '2025-07-10 18:40:32'),
(549, 'default', 'Organization viewed transactions', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"event_id_filter\": null}', NULL, '2025-07-10 18:40:32', '2025-07-10 18:40:32'),
(550, 'default', 'Organization viewed transactions', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"event_id_filter\": null}', NULL, '2025-07-10 18:40:34', '2025-07-10 18:40:34'),
(551, 'default', 'Organization viewed transactions', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"event_id_filter\": null}', NULL, '2025-07-10 18:41:12', '2025-07-10 18:41:12'),
(552, 'default', 'User logged out', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"email\": \"hout@gmail.com\"}', NULL, '2025-07-10 18:41:20', '2025-07-10 18:41:20'),
(553, 'default', 'organization logged in', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '{\"email\": \"tech@cambodia.org\"}', NULL, '2025-07-10 18:41:31', '2025-07-10 18:41:31'),
(554, 'default', 'Organization viewed buyer list', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '[]', NULL, '2025-07-10 18:41:31', '2025-07-10 18:41:31'),
(555, 'default', 'Organization viewed buyer list', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '[]', NULL, '2025-07-10 18:41:31', '2025-07-10 18:41:31'),
(556, 'default', 'Organization viewed transactions', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '{\"event_id_filter\": null}', NULL, '2025-07-10 18:41:34', '2025-07-10 18:41:34'),
(557, 'default', 'Organization viewed buyer list', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '[]', NULL, '2025-07-10 18:41:38', '2025-07-10 18:41:38'),
(558, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 6, '{\"email\": \"io@gmail.com\"}', NULL, '2025-07-10 19:57:21', '2025-07-10 19:57:21'),
(559, 'default', 'User bought ticket', NULL, NULL, NULL, 'App\\Models\\User', 6, '{\"event_id\": 8, \"quantity\": 1, \"total_price\": 15, \"event_date_id\": 10}', NULL, '2025-07-10 19:59:24', '2025-07-10 19:59:24'),
(560, 'default', 'User submitted rating', NULL, NULL, NULL, 'App\\Models\\User', 6, '{\"event_id\": 8}', NULL, '2025-07-10 20:06:39', '2025-07-10 20:06:39'),
(561, 'default', 'User changed password', NULL, NULL, NULL, 'App\\Models\\User', 6, '{\"email\": \"io@gmail.com\"}', NULL, '2025-07-10 20:08:12', '2025-07-10 20:08:12'),
(562, 'default', 'User updated profile info', NULL, NULL, NULL, 'App\\Models\\User', 6, '{\"user_id\": 6}', NULL, '2025-07-10 20:13:34', '2025-07-10 20:13:34'),
(563, 'default', 'User updated profile info', NULL, NULL, NULL, 'App\\Models\\User', 6, '{\"user_id\": 6}', NULL, '2025-07-10 20:13:42', '2025-07-10 20:13:42'),
(564, 'default', 'Organization viewed buyer list', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '[]', NULL, '2025-07-10 20:14:52', '2025-07-10 20:14:52'),
(565, 'default', 'Organization viewed buyer list', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '[]', NULL, '2025-07-10 20:18:26', '2025-07-10 20:18:26'),
(566, 'default', 'Organization viewed buyer list', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '[]', NULL, '2025-07-10 20:18:35', '2025-07-10 20:18:35'),
(567, 'default', 'Organization viewed buyer list', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '[]', NULL, '2025-07-10 20:19:09', '2025-07-10 20:19:09'),
(568, 'default', 'Organization viewed buyer list', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '[]', NULL, '2025-07-10 20:19:37', '2025-07-10 20:19:37'),
(569, 'default', 'Organization viewed buyer list', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '[]', NULL, '2025-07-10 20:19:59', '2025-07-10 20:19:59'),
(570, 'default', 'Organization viewed buyer list', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '[]', NULL, '2025-07-10 20:23:49', '2025-07-10 20:23:49'),
(571, 'default', 'Organization viewed buyer list', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '[]', NULL, '2025-07-10 20:23:49', '2025-07-10 20:23:49'),
(572, 'default', 'Organization viewed buyer list', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '[]', NULL, '2025-07-10 20:25:40', '2025-07-10 20:25:40'),
(573, 'default', 'Organization viewed transactions', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '{\"event_id_filter\": \"11\"}', NULL, '2025-07-10 20:26:25', '2025-07-10 20:26:25'),
(574, 'default', 'Organization viewed transactions', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '{\"event_id_filter\": null}', NULL, '2025-07-10 20:26:45', '2025-07-10 20:26:45'),
(575, 'default', 'Organization viewed transactions', NULL, NULL, NULL, 'App\\Models\\Organization', 2, '{\"event_id_filter\": null}', NULL, '2025-07-10 20:27:22', '2025-07-10 20:27:22'),
(576, 'default', 'User viewed own tickets', NULL, NULL, NULL, 'App\\Models\\User', 6, '[]', NULL, '2025-07-13 08:51:46', '2025-07-13 08:51:46'),
(577, 'default', 'user signed up', NULL, NULL, NULL, 'App\\Models\\User', 7, '{\"email\": \"user@gmail.com\"}', NULL, '2025-07-13 09:21:33', '2025-07-13 09:21:33'),
(578, 'default', 'organization signed up', NULL, NULL, NULL, 'App\\Models\\Organization', 3, '{\"email\": \"organization@gmail.com\"}', NULL, '2025-07-13 09:27:29', '2025-07-13 09:27:29'),
(579, 'default', 'organization logged in', NULL, NULL, NULL, 'App\\Models\\Organization', 1, '{\"email\": \"organization@gmail.com\"}', NULL, '2025-07-13 09:31:43', '2025-07-13 09:31:43'),
(580, 'default', 'Admin Logged in', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"email\": \"admin@gmail.com\"}', NULL, '2025-07-13 09:36:39', '2025-07-13 09:36:39'),
(581, 'default', 'User viewed single event', NULL, NULL, NULL, NULL, NULL, '{\"event_id\": \"14\", \"event_title\": \"World Cup 2026\"}', NULL, '2025-07-13 09:38:24', '2025-07-13 09:38:24'),
(582, 'default', 'Admin signed up', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"email\": \"admin@gmail.com\"}', NULL, '2025-07-13 09:39:12', '2025-07-13 09:39:12'),
(583, 'default', 'Admin Logged in', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"email\": \"admin@gmail.com\"}', NULL, '2025-07-13 09:39:23', '2025-07-13 09:39:23'),
(584, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-13 09:39:26', '2025-07-13 09:39:26'),
(585, 'default', 'Admin viewed all event requests', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-13 09:39:27', '2025-07-13 09:39:27'),
(586, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 1, '{\"email\": \"user@gmail.com\"}', NULL, '2025-07-13 09:39:50', '2025-07-13 09:39:50'),
(587, 'default', 'User viewed single event', NULL, NULL, NULL, NULL, NULL, '{\"event_id\": \"14\", \"event_title\": \"World Cup 2026\"}', NULL, '2025-07-13 09:39:52', '2025-07-13 09:39:52'),
(588, 'default', 'User viewed single event', NULL, NULL, NULL, NULL, NULL, '{\"event_id\": \"14\", \"event_title\": \"World Cup 2026\"}', NULL, '2025-07-13 09:40:29', '2025-07-13 09:40:29'),
(589, 'default', 'User viewed own tickets', NULL, NULL, NULL, 'App\\Models\\User', 1, '[]', NULL, '2025-07-13 09:40:31', '2025-07-13 09:40:31'),
(590, 'default', 'User viewed own tickets', NULL, NULL, NULL, 'App\\Models\\User', 1, '[]', NULL, '2025-07-13 09:40:41', '2025-07-13 09:40:41'),
(591, 'default', 'User viewed own tickets', NULL, NULL, NULL, 'App\\Models\\User', 1, '[]', NULL, '2025-07-13 09:40:53', '2025-07-13 09:40:53'),
(592, 'default', 'User viewed single event', NULL, NULL, NULL, NULL, NULL, '{\"event_id\": \"14\", \"event_title\": \"World Cup 2026\"}', NULL, '2025-07-13 09:40:56', '2025-07-13 09:40:56'),
(593, 'default', 'User viewed single event', NULL, NULL, NULL, NULL, NULL, '{\"event_id\": \"14\", \"event_title\": \"World Cup 2026\"}', NULL, '2025-07-13 09:41:07', '2025-07-13 09:41:07'),
(594, 'default', 'User bought ticket', NULL, NULL, NULL, 'App\\Models\\User', 1, '{\"event_id\": 14, \"quantity\": 3, \"total_price\": 600, \"event_date_id\": 25}', NULL, '2025-07-13 09:41:25', '2025-07-13 09:41:25'),
(595, 'default', 'User viewed own tickets', NULL, NULL, NULL, 'App\\Models\\User', 1, '[]', NULL, '2025-07-13 09:41:26', '2025-07-13 09:41:26'),
(596, 'default', 'User viewed own tickets', NULL, NULL, NULL, 'App\\Models\\User', 1, '[]', NULL, '2025-07-13 09:41:38', '2025-07-13 09:41:38'),
(597, 'default', 'User viewed own tickets', NULL, NULL, NULL, 'App\\Models\\User', 1, '[]', NULL, '2025-07-13 09:41:41', '2025-07-13 09:41:41'),
(598, 'default', 'User viewed own tickets', NULL, NULL, NULL, 'App\\Models\\User', 1, '[]', NULL, '2025-07-13 09:41:57', '2025-07-13 09:41:57'),
(599, 'default', 'User viewed own tickets', NULL, NULL, NULL, 'App\\Models\\User', 1, '[]', NULL, '2025-07-13 09:41:58', '2025-07-13 09:41:58'),
(600, 'default', 'User viewed own tickets', NULL, NULL, NULL, 'App\\Models\\User', 1, '[]', NULL, '2025-07-13 09:48:59', '2025-07-13 09:48:59'),
(601, 'default', 'User viewed single event', NULL, NULL, NULL, NULL, NULL, '{\"event_id\": \"15\", \"event_title\": \"Vannda - Treyvisai\"}', NULL, '2025-07-13 09:52:07', '2025-07-13 09:52:07'),
(602, 'default', 'User viewed own tickets', NULL, NULL, NULL, 'App\\Models\\User', 1, '[]', NULL, '2025-07-13 09:52:16', '2025-07-13 09:52:16'),
(603, 'default', 'Admin viewed all event requests', NULL, NULL, NULL, 'App\\Models\\User', 1, '[]', NULL, '2025-07-13 09:52:48', '2025-07-13 09:52:48'),
(604, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\User', 1, '[]', NULL, '2025-07-13 09:52:48', '2025-07-13 09:52:48'),
(605, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\User', 1, '[]', NULL, '2025-07-13 09:52:50', '2025-07-13 09:52:50'),
(606, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\User', 1, '[]', NULL, '2025-07-13 09:52:52', '2025-07-13 09:52:52'),
(607, 'default', 'Admin updated event', NULL, NULL, NULL, 'App\\Models\\User', 1, '{\"event_id\": \"15\", \"event_title\": \"Vannda - Treyvisai 2025\"}', NULL, '2025-07-13 09:53:02', '2025-07-13 09:53:02'),
(608, 'default', 'User viewed own tickets', NULL, NULL, NULL, 'App\\Models\\User', 1, '[]', NULL, '2025-07-13 09:53:20', '2025-07-13 09:53:20'),
(609, 'default', 'Organization viewed transactions', NULL, NULL, NULL, 'App\\Models\\Organization', 1, '{\"event_id_filter\": null}', NULL, '2025-07-13 09:53:51', '2025-07-13 09:53:51'),
(610, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '[]', NULL, '2025-07-13 09:55:27', '2025-07-13 09:55:27'),
(611, 'default', 'Admin Logged in', NULL, NULL, NULL, 'App\\Models\\Admin', 1, '{\"email\": \"admin@gmail.com\"}', NULL, '2025-07-13 09:57:36', '2025-07-13 09:57:36'),
(612, 'default', 'user logged in', NULL, NULL, NULL, 'App\\Models\\User', 1, '{\"email\": \"user@gmail.com\"}', NULL, '2025-07-13 09:58:39', '2025-07-13 09:58:39'),
(613, 'default', 'User viewed own tickets', NULL, NULL, NULL, 'App\\Models\\User', 1, '[]', NULL, '2025-07-13 09:58:58', '2025-07-13 09:58:58'),
(614, 'default', 'Admin viewed all event requests', NULL, NULL, NULL, 'App\\Models\\User', 1, '[]', NULL, '2025-07-13 09:59:31', '2025-07-13 09:59:31'),
(615, 'default', 'Admin viewed all events', NULL, NULL, NULL, 'App\\Models\\User', 1, '[]', NULL, '2025-07-13 09:59:32', '2025-07-13 09:59:32');

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` bigint UNSIGNED NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL,
  `profile_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `username`, `email`, `password`, `balance`, `created_at`, `updated_at`, `profile_image`) VALUES
(1, 'Admin', 'admin@gmail.com', '$2y$12$8b1tEoFI0BAnTwjBdeaH/.uyjjVQv4nTFJD7EhGHswu0p.As2SIJy', 30.00, '2025-07-13 16:22:40', '2025-07-13 09:36:39', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `checkin_log`
--

CREATE TABLE `checkin_log` (
  `checkin_id` bigint UNSIGNED NOT NULL,
  `ticket_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `event_id` bigint UNSIGNED NOT NULL,
  `ticket_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `checked_in_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `event`
--

CREATE TABLE `event` (
  `event_id` bigint UNSIGNED NOT NULL,
  `org_id` bigint UNSIGNED DEFAULT NULL,
  `admin_id` bigint UNSIGNED DEFAULT NULL,
  `event_category_id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `banner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `reviewed_at` time DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `event`
--

INSERT INTO `event` (`event_id`, `org_id`, `admin_id`, `event_category_id`, `title`, `description`, `banner`, `location`, `status`, `reviewed_at`, `created_at`, `updated_at`) VALUES
(14, 1, 1, 4, 'World Cup 2026', 'This is the world biggest football tournment', 'banners/org_1_1752424312.jpg', 'Cambodia', 'approved', '16:37:55', '2025-07-13 09:31:52', '2025-07-13 09:31:52'),
(15, 1, 1, 1, 'Vannda - Treyvisai 2025', 'This is the world biggest concert', 'banners/org_1_1752425503.jpg', 'Cambodia', 'approved', '16:51:53', '2025-07-13 09:51:43', '2025-07-13 09:53:02');

-- --------------------------------------------------------

--
-- Table structure for table `event_category`
--

CREATE TABLE `event_category` (
  `event_category_id` bigint UNSIGNED NOT NULL,
  `event_category_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `event_category`
--

INSERT INTO `event_category` (`event_category_id`, `event_category_name`) VALUES
(1, 'Concerts'),
(2, 'Festivals'),
(3, 'Conferences'),
(4, 'Sports');

-- --------------------------------------------------------

--
-- Table structure for table `event_date`
--

CREATE TABLE `event_date` (
  `event_date_id` bigint UNSIGNED NOT NULL,
  `event_id` bigint UNSIGNED NOT NULL,
  `event_date` date NOT NULL,
  `event_time` time NOT NULL,
  `ticket_price` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `total_ticket` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `event_date`
--

INSERT INTO `event_date` (`event_date_id`, `event_id`, `event_date`, `event_time`, `ticket_price`, `created_at`, `updated_at`, `total_ticket`) VALUES
(25, 14, '2026-06-18', '14:00:00', 200.00, '2025-07-13 09:31:52', '2025-07-13 16:41:25', 9997),
(26, 14, '2026-07-11', '14:00:00', 400.00, '2025-07-13 09:31:52', '2025-07-13 09:31:52', 10000),
(27, 15, '2025-08-18', '14:00:00', 20.00, '2025-07-13 09:51:43', '2025-07-13 09:53:02', 10000),
(28, 15, '2026-08-12', '14:00:00', 40.00, '2025-07-13 09:51:43', '2025-07-13 09:53:02', 10000);

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000001_create_cache_table', 1),
(2, '0001_01_01_000002_create_jobs_table', 1),
(3, '2025_06_07_024315_create_personal_access_tokens_table', 1),
(4, '2025_06_13_141816_create_organization_table', 1),
(5, '2025_06_13_141817_create_admin_table', 1),
(6, '2025_06_13_141818_create_event_category_table', 1),
(7, '2025_06_13_141818_create_event_table', 1),
(8, '2025_06_13_141818_create_user_table', 1),
(9, '2025_06_13_141819_create_rating_category_table', 1),
(10, '2025_06_13_141819_create_rating_table', 1),
(11, '2025_06_13_141819_create_ticket_table', 1),
(12, '2025_06_13_141819_create_transaction_table', 1),
(13, '2025_06_13_141820_create_payment_table', 1),
(14, '2025_06_19_144109_create_activity_log_table', 2),
(15, '2025_06_19_144110_add_event_column_to_activity_log_table', 2),
(16, '2025_06_19_144111_add_batch_uuid_column_to_activity_log_table', 2),
(17, '2025_06_13_141820_create_checkin_log_table', 3);

-- --------------------------------------------------------

--
-- Table structure for table `organization`
--

CREATE TABLE `organization` (
  `org_id` bigint UNSIGNED NOT NULL,
  `org_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NOT NULL,
  `org_type` varchar(125) COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `organization`
--

INSERT INTO `organization` (`org_id`, `org_name`, `status`, `email`, `password`, `contact_name`, `profile_image`, `contact_phone`, `contact_email`, `balance`, `created_at`, `org_type`, `updated_at`) VALUES
(1, 'Organization', 1, 'organization@gmail.com', '$2y$12$ue9TMzt8wo12o/0o0q.5Ieo1pVEgyddpiJHYcn.NuHysOw29LPIfK', 'Organization', NULL, '092345678', 'contact@gmail.com', 570.00, '2025-07-13 09:27:29', 'Non-Profit', '2025-07-13 09:27:29');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `payment_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `event_id` bigint UNSIGNED NOT NULL,
  `amount` decimal(8,2) NOT NULL,
  `quantity` int NOT NULL,
  `payment_status` enum('Completed','Rejected') COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_date` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`payment_id`, `user_id`, `event_id`, `amount`, `quantity`, `payment_status`, `payment_date`) VALUES
(56, 1, 14, 600.00, 3, 'Completed', '2025-07-13 09:41:25');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 2, 'user-signup', 'd45ca6630722e0c68ebe717314b4f36bf5f7b42de78f4a05a772364d05a92afc', '[\"*\"]', NULL, NULL, '2025-06-19 07:53:40', '2025-06-19 07:53:40'),
(2, 'App\\Models\\Admin', 3, 'api-token', '5fd3bd85b82240a8ce3db8ecc436a0fedc95fd4176a89953497fc194ee285149', '[\"*\"]', NULL, NULL, '2025-06-19 08:08:33', '2025-06-19 08:08:33'),
(3, 'App\\Models\\Admin', 4, 'api-token', 'c11865e01bed1e1717a0e28dcae3f06844a8ae8f85418b98695b3988a287333e', '[\"*\"]', NULL, NULL, '2025-06-19 08:26:43', '2025-06-19 08:26:43'),
(4, 'App\\Models\\User', 3, 'user-signup', '2a3d509b058e14056159cf325075042ca91b060fa9a6369ba0876bc7771b75e0', '[\"*\"]', NULL, NULL, '2025-06-19 20:13:52', '2025-06-19 20:13:52'),
(5, 'App\\Models\\Admin', 5, 'api-token', '0218af15060be04a6f13210507eb8da0fdf83070e2885ac31d22e4cc1a358bf8', '[\"*\"]', NULL, NULL, '2025-06-21 06:24:35', '2025-06-21 06:24:35'),
(6, 'App\\Models\\Admin', 6, 'api-token', '259f77d00c0aabadf31dbdc4d6d77a7ff093b347514bd7eb173405371640abe0', '[\"*\"]', NULL, NULL, '2025-06-21 06:26:55', '2025-06-21 06:26:55'),
(7, 'App\\Models\\Admin', 5, 'mytoken', 'bfc883a922688dfd25202fa8ca21e6e35aea61114ddf650c037af81e199004c4', '[\"*\"]', NULL, NULL, '2025-06-21 06:37:53', '2025-06-21 06:37:53'),
(8, 'App\\Models\\Admin', 5, 'mytoken', '0bf1f86d900b0764eab3c142ca9e2dc6b743265ce8b6f1c50a4c7fd614feff77', '[\"*\"]', NULL, NULL, '2025-06-21 06:38:15', '2025-06-21 06:38:15'),
(9, 'App\\Models\\Admin', 5, 'mytoken', '1343e2e8b7416537ef704cba6dd1ec18b0b26dd5dab1cbf79848fdf19b19685a', '[\"*\"]', NULL, NULL, '2025-06-21 06:41:32', '2025-06-21 06:41:32'),
(10, 'App\\Models\\Admin', 5, 'mytoken', '9f69c24007c839da2c531b6427239f6da0500e7b9005eca678ad086ee09607d3', '[\"*\"]', NULL, NULL, '2025-06-21 06:45:03', '2025-06-21 06:45:03'),
(11, 'App\\Models\\Admin', 7, 'api-token', 'e6bbb010252ee31848a3851ec96cebb82482569f7c2f901a5ccf34c3e960dcd6', '[\"*\"]', NULL, NULL, '2025-06-21 06:53:48', '2025-06-21 06:53:48'),
(12, 'App\\Models\\Admin', 5, 'mytoken', 'b875b6f148f16e2140056a013618d51c3f7108ba424369cf6b348a258660afe7', '[\"*\"]', NULL, NULL, '2025-06-21 06:59:56', '2025-06-21 06:59:56'),
(13, 'App\\Models\\Admin', 5, 'mytoken', '87c06dba378249d839334a28066535962a862bc026f3157435a11b7caa6e04a5', '[\"*\"]', NULL, NULL, '2025-06-21 07:01:04', '2025-06-21 07:01:04'),
(14, 'App\\Models\\Admin', 5, 'mytoken', '667085be627bf4dc5f6f25922d1527f5dac247e80f6640b11c54879d712bbdef', '[\"*\"]', NULL, NULL, '2025-06-21 07:01:16', '2025-06-21 07:01:16'),
(15, 'App\\Models\\Admin', 5, 'mytoken', '7483aa8899894eb18180df22092195c6d49b5ef5349cc31e9e30d71c33e8f6b5', '[\"*\"]', NULL, NULL, '2025-06-21 07:02:29', '2025-06-21 07:02:29'),
(16, 'App\\Models\\Admin', 5, 'mytoken', '14d2844d4e72d2cdf774b591eb865f2fc9e684fde5c090fb02ba7320b992b855', '[\"*\"]', NULL, NULL, '2025-06-21 07:05:47', '2025-06-21 07:05:47'),
(17, 'App\\Models\\Admin', 5, 'mytoken', '6ac059c8f29f8845140d9612838b5392376ec4e891c2b3a1e4e17b76053fcf17', '[\"*\"]', NULL, NULL, '2025-06-21 07:06:56', '2025-06-21 07:06:56'),
(18, 'App\\Models\\Admin', 8, 'api-token', 'bc0d3de8b108c8acb3699d905e8de5d9bce71314348e7ea92468ee55c5956a13', '[\"*\"]', NULL, NULL, '2025-06-21 07:08:08', '2025-06-21 07:08:08'),
(19, 'App\\Models\\Admin', 5, 'mytoken', '4d7e44ace5fbdc78710e946b979cd9ed2983b9ee834be35ef26215800d51f643', '[\"*\"]', NULL, NULL, '2025-06-21 07:08:49', '2025-06-21 07:08:49'),
(20, 'App\\Models\\Admin', 5, 'mytoken', 'c40dae2da9d1952ed723cca9bc45e8bb672a6ad7d53eab6e6a42e3150b22f089', '[\"*\"]', NULL, NULL, '2025-06-21 07:14:26', '2025-06-21 07:14:26'),
(21, 'App\\Models\\Admin', 9, 'api-token', '851339b38767d333259e77bf035cc58eac76090a891e43dc2c87b3d73f502b25', '[\"*\"]', NULL, NULL, '2025-06-21 07:16:06', '2025-06-21 07:16:06'),
(22, 'App\\Models\\Admin', 9, 'mytoken', '719b71ca924e57486ae21ea3e3a7a4d1d7174d098fe0c339792793a8d4f4fd55', '[\"*\"]', NULL, NULL, '2025-06-21 07:16:22', '2025-06-21 07:16:22'),
(23, 'App\\Models\\Admin', 9, 'mytoken', 'a62042d7e7104f83e5cce1fe1dc5190c78b4ca2f684b093362be6bf72c9f99a8', '[\"*\"]', NULL, NULL, '2025-06-21 07:36:26', '2025-06-21 07:36:26'),
(24, 'App\\Models\\Admin', 10, 'api-token', '540f36f42790d712395c58fadbcea2ac66f9b3273cfb9a859a4830a91138c9d4', '[\"*\"]', NULL, NULL, '2025-06-21 07:36:55', '2025-06-21 07:36:55'),
(25, 'App\\Models\\Admin', 9, 'mytoken', '4bc9609ddb0bd08b53534404917e04cb21b882a4f272470e205cb51f3f1e9138', '[\"*\"]', NULL, NULL, '2025-06-21 07:42:14', '2025-06-21 07:42:14'),
(26, 'App\\Models\\Admin', 9, 'mytoken', '8177852ddb92b47be20f0dd347ce287374914251a3f29b6cdfaebc265bbc22d1', '[\"*\"]', NULL, NULL, '2025-06-21 08:08:09', '2025-06-21 08:08:09'),
(27, 'App\\Models\\Admin', 11, 'api-token', 'bacb854b28437866f3fa4e440f0afe18b39e576d1e0a1319eba1dcaccf431847', '[\"*\"]', NULL, NULL, '2025-06-21 08:08:20', '2025-06-21 08:08:20'),
(28, 'App\\Models\\Admin', 12, 'api-token', '394358f365411adcb58bb8f23a5309ad55f0d2d573272c7c03c4aaffdf6d42db', '[\"*\"]', NULL, NULL, '2025-06-21 08:14:00', '2025-06-21 08:14:00'),
(29, 'App\\Models\\Admin', 13, 'api-token', '114c0d569703d695a778b24486cd37bd44a027233bd71b750cb7dae00f046f0b', '[\"*\"]', NULL, NULL, '2025-06-21 08:14:58', '2025-06-21 08:14:58'),
(30, 'App\\Models\\Admin', 9, 'mytoken', '04cdba5f03de12f99f4b74825b2f63ca86956f891b8cce02445ff1bd8a5bc2ea', '[\"*\"]', NULL, NULL, '2025-06-21 08:27:27', '2025-06-21 08:27:27'),
(31, 'App\\Models\\Admin', 9, 'mytoken', '402e93a39071dae9de90ef5575262ad2a6f75e0a8892b38814d1f6715fcd654a', '[\"*\"]', NULL, NULL, '2025-06-21 08:34:32', '2025-06-21 08:34:32'),
(32, 'App\\Models\\Admin', 9, 'mytoken', '151397ac29526c56b1a0265213b32db6fad01deaa65b42a3cca53440fedef26a', '[\"*\"]', NULL, NULL, '2025-06-22 04:14:59', '2025-06-22 04:14:59'),
(33, 'App\\Models\\Admin', 9, 'mytoken', '4b55fade6f802fd7cff3e86d86d0a45965a3ca7069582ad2579572216717818d', '[\"*\"]', NULL, NULL, '2025-06-22 04:36:46', '2025-06-22 04:36:46'),
(34, 'App\\Models\\Admin', 9, 'mytoken', '9f6ec8bc579eed66f6df5589bbec0b16958c96d519d621cb6d69003bd4350c30', '[\"*\"]', NULL, NULL, '2025-06-22 04:37:43', '2025-06-22 04:37:43'),
(35, 'App\\Models\\Admin', 9, 'mytoken', 'bae531fa4d6754b60f45f7f12eb61d339c2d3898b2efc79483d9e9e5a928bdcc', '[\"*\"]', NULL, NULL, '2025-06-22 04:48:44', '2025-06-22 04:48:44'),
(36, 'App\\Models\\User', 4, 'user-signup', '788776b9b086cad767f5ba76aec14f6c648779d99ba55377c9901129f83f6389', '[\"*\"]', NULL, NULL, '2025-06-22 05:25:48', '2025-06-22 05:25:48'),
(37, 'App\\Models\\User', 4, 'user', '98a2f127180a3262b36b0f68011c470ee61611eea3c0dee272204728526b9f00', '[\"*\"]', NULL, NULL, '2025-06-22 05:31:12', '2025-06-22 05:31:12'),
(38, 'App\\Models\\Admin', 13, 'mytoken', 'd620588d76cbcac008cc98f3789e409342f42e389d68512c456dd133cdb4374d', '[\"*\"]', NULL, NULL, '2025-06-22 05:37:53', '2025-06-22 05:37:53'),
(39, 'App\\Models\\Admin', 13, 'mytoken', '4dda652ac2ac359d60147c63726d8f37eda160dde35660f038e2c84565806dcf', '[\"*\"]', NULL, NULL, '2025-06-22 05:40:11', '2025-06-22 05:40:11'),
(40, 'App\\Models\\User', 4, 'user', '04e703b9cd4537930948fca0707e77bed8755508e8aa0e872542f44d0809a89e', '[\"*\"]', NULL, NULL, '2025-06-22 05:43:45', '2025-06-22 05:43:45'),
(41, 'App\\Models\\User', 4, 'user', '5461d80fb91726df4c7426a05de04b963b425de9efd5cd7ee8d8f95cdda32435', '[\"*\"]', NULL, NULL, '2025-06-22 05:48:29', '2025-06-22 05:48:29'),
(42, 'App\\Models\\User', 4, 'user-token', '1ea10378877b54a2ac84ef9fb98e4e2815ae5cf70675ed327c098e07060d44f5', '[\"*\"]', NULL, NULL, '2025-06-22 05:52:40', '2025-06-22 05:52:40'),
(43, 'App\\Models\\User', 4, 'user-token', 'efe761eb8d84efa4f371b7bbe0e7c6c8f01ce673569e3cc737172c3c83406ebb', '[\"*\"]', NULL, NULL, '2025-06-22 05:54:56', '2025-06-22 05:54:56'),
(44, 'App\\Models\\User', 4, 'user-token', '6a4020ac9e16bd7eccdafdb7da39d2bbddd74b3d9504c4e7e8f72f56d2217e84', '[\"*\"]', NULL, NULL, '2025-06-22 06:15:05', '2025-06-22 06:15:05'),
(45, 'App\\Models\\User', 4, 'user-token', '908c60994520fbcabfa43ef490adb2750011ce41b98d30fbd2a78e9d6a90b7e0', '[\"*\"]', NULL, NULL, '2025-06-22 06:18:32', '2025-06-22 06:18:32'),
(46, 'App\\Models\\User', 4, 'user-token', '42532e5e4d93fe9a889add12719cf3f0e0d723034545c8bd6c92bcaaf0bcc013', '[\"*\"]', '2025-06-22 06:50:40', NULL, '2025-06-22 06:31:18', '2025-06-22 06:50:40'),
(47, 'App\\Models\\User', 4, 'user-token', '4781bcb4aabbe84ec0b60c2f32504d10f2137d1f094c16c09d0a5ed0911b2126', '[\"*\"]', NULL, NULL, '2025-06-22 06:47:15', '2025-06-22 06:47:15'),
(49, 'App\\Models\\User', 4, 'mytoken', '3dd624d26f584112216dc60a5bfb0dd5aeebe414d35df0c3e358198611eb5eec', '[\"*\"]', '2025-07-08 08:58:55', NULL, '2025-06-22 07:27:19', '2025-07-08 08:58:55'),
(52, 'App\\Models\\Admin', 14, 'api-token', 'ee8c7cac2988c4b5ac1d7dc7cb7933b25bc4a0453eb8475455ccd7ced409e7fa', '[\"*\"]', NULL, NULL, '2025-06-22 07:55:34', '2025-06-22 07:55:34'),
(53, 'App\\Models\\Admin', 15, 'api-token', '0dc34c582559c6066b869610d8a3d9df250c297873b713dde0ab45e56ed0ea45', '[\"*\"]', NULL, NULL, '2025-06-22 07:56:39', '2025-06-22 07:56:39'),
(54, 'App\\Models\\Admin', 16, 'api-token', '2c7dfa681637ee31fdf09de90a8d2c76f6157a265da5e47b6978d0257f19e096', '[\"*\"]', NULL, NULL, '2025-06-22 07:58:55', '2025-06-22 07:58:55'),
(55, 'App\\Models\\Admin', 17, 'api-token', 'd23e3e1801268042e8c7163fe174ab3f5890fa8ab142e1eb93300b34f21c3437', '[\"*\"]', NULL, NULL, '2025-06-22 07:59:48', '2025-06-22 07:59:48'),
(56, 'App\\Models\\Admin', 18, 'api-token', '928167dfc08287f7d2a6a1eb46b3a9076fcdac3d9554fd6260d0993e4403b35e', '[\"*\"]', NULL, NULL, '2025-06-22 08:02:17', '2025-06-22 08:02:17'),
(59, 'App\\Models\\Admin', 13, 'mytoken', 'cff05dcee2d556148629e2d0de8f21924ff14f9497ebc35736f9ac6d9bdee6c0', '[\"*\"]', '2025-07-10 10:29:09', NULL, '2025-06-23 03:10:11', '2025-07-10 10:29:09'),
(60, 'App\\Models\\User', 4, 'mytoken', 'd9128369b65e1763c9aeacaa1e4250193f7afcc8766ac27a9682b09f59683533', '[\"*\"]', '2025-07-04 08:55:11', NULL, '2025-06-23 03:23:20', '2025-07-04 08:55:11'),
(64, 'App\\Models\\Admin', 13, 'mytoken', 'fdaa4ca13b4ff4143ccdf91cbacf7206bfc22f1e6510239f5d3cf21f12c58967', '[\"*\"]', '2025-07-08 07:04:29', NULL, '2025-06-28 09:11:49', '2025-07-08 07:04:29'),
(67, 'App\\Models\\Admin', 13, 'mytoken', 'f2b544a18d4eba834ead33a2efa220efd9594a3afea4cbba0b41aa4654f4f605', '[\"*\"]', NULL, NULL, '2025-06-28 17:15:14', '2025-06-28 17:15:14'),
(68, 'App\\Models\\User', 4, 'mytoken', '610a4a7cf11fa9bd44cae812a385693f9b48170fca08b1d98a8c010270e5d8ad', '[\"*\"]', NULL, NULL, '2025-06-28 17:45:06', '2025-06-28 17:45:06'),
(69, 'App\\Models\\User', 4, 'mytoken', '6d2256304e55c23ac4269320f049715ac61bae3e7eeb9de5c93e6bcd2c509c52', '[\"*\"]', NULL, NULL, '2025-06-28 17:56:43', '2025-06-28 17:56:43'),
(70, 'App\\Models\\User', 4, 'mytoken', '0e3341b8285f8103ad4ec5e565e7c69d2eb666718082e63cf80b13726974713b', '[\"*\"]', NULL, NULL, '2025-06-28 17:56:45', '2025-06-28 17:56:45'),
(71, 'App\\Models\\User', 4, 'mytoken', '77226648eb30b83c05199d76182e3a4e5b0f4175ea3a11681feb74ecc339331f', '[\"*\"]', NULL, NULL, '2025-06-28 17:56:46', '2025-06-28 17:56:46'),
(72, 'App\\Models\\User', 4, 'mytoken', '77ca27ad63011cc885746167e7eb1c782ec19b1a1f164c8b4ff1321425b1da97', '[\"*\"]', NULL, NULL, '2025-06-28 17:56:58', '2025-06-28 17:56:58'),
(73, 'App\\Models\\User', 4, 'mytoken', '4eb23ad405b45eaa5d4e18e6f6a85937411422c95dc19d4b6ecb9f0d0cb60d04', '[\"*\"]', NULL, NULL, '2025-06-28 17:57:00', '2025-06-28 17:57:00'),
(74, 'App\\Models\\User', 4, 'mytoken', 'c96e0b8ce61afeb12407e659b1466dc1efb75b4949235bbe9c724683e58bd8b8', '[\"*\"]', NULL, NULL, '2025-06-28 17:57:01', '2025-06-28 17:57:01'),
(75, 'App\\Models\\User', 4, 'mytoken', '1d18e4e4a8b2cff908b0ed369a0abafaf373d66933683efd4c7fb7bd76e51560', '[\"*\"]', NULL, NULL, '2025-06-28 17:57:01', '2025-06-28 17:57:01'),
(76, 'App\\Models\\User', 4, 'mytoken', '365e0ae8fe4c55a060711d17f0b80bb97a7389ad60fa4a03869a41cf1e669bcc', '[\"*\"]', NULL, NULL, '2025-06-28 17:57:01', '2025-06-28 17:57:01'),
(77, 'App\\Models\\User', 4, 'mytoken', 'c9e3156e442bab2378b66694b9a6ace3ca1cf894fd486b654b3bb52285dc4b6a', '[\"*\"]', NULL, NULL, '2025-06-28 17:57:05', '2025-06-28 17:57:05'),
(78, 'App\\Models\\User', 4, 'mytoken', '5c61d7ec1227dadcc9717f3d48afbabde8060979452b12dcba6b29e536b0fc54', '[\"*\"]', NULL, NULL, '2025-06-28 17:57:05', '2025-06-28 17:57:05'),
(79, 'App\\Models\\User', 4, 'mytoken', 'da3fee41e1acfe9d8798e70799f24bb9283876b3292842ca49bff07c69e19c79', '[\"*\"]', NULL, NULL, '2025-06-28 17:57:05', '2025-06-28 17:57:05'),
(80, 'App\\Models\\User', 4, 'mytoken', 'b9f694a0afbbb5b59358c99ea963289b86ce1ec11d1d0b4db67237d65306234b', '[\"*\"]', NULL, NULL, '2025-06-28 17:57:06', '2025-06-28 17:57:06'),
(81, 'App\\Models\\User', 4, 'mytoken', '24d7785afe3e3df79ce646cf001bdfc2b13d5d77e69ae88415537e5dcf5e45a1', '[\"*\"]', NULL, NULL, '2025-06-28 17:57:06', '2025-06-28 17:57:06'),
(82, 'App\\Models\\User', 4, 'mytoken', 'd20084fbf9bb8d961f49f4752289a23f338a5d42f1b34260c0d6f6f06fc0f5cb', '[\"*\"]', NULL, NULL, '2025-06-28 17:57:06', '2025-06-28 17:57:06'),
(83, 'App\\Models\\User', 4, 'mytoken', '82f982156856be86cd9a27372e6fe89d0ae303b16d3da3e6581803dd894b68ba', '[\"*\"]', NULL, NULL, '2025-06-28 17:57:06', '2025-06-28 17:57:06'),
(84, 'App\\Models\\User', 4, 'mytoken', '7783054454a0f044c279408d367a49c9b7cbe4c5a0a68fccff4df97c57f73cab', '[\"*\"]', NULL, NULL, '2025-06-28 17:57:06', '2025-06-28 17:57:06'),
(85, 'App\\Models\\User', 4, 'mytoken', '915ce971b77c4216f3cf6f538eaf9d4c525e6a916e404efc4eb35f95cdc2f804', '[\"*\"]', NULL, NULL, '2025-06-28 17:57:06', '2025-06-28 17:57:06'),
(86, 'App\\Models\\User', 4, 'mytoken', '72506fa1dcb5e3e42152bb083420bf05d7c6eb60d3e73ef1f360f6b692373419', '[\"*\"]', NULL, NULL, '2025-06-28 17:57:07', '2025-06-28 17:57:07'),
(87, 'App\\Models\\User', 4, 'mytoken', '8a1c1d65d43679aa49cd3e41c5da55028c3413cf24406bd97655249cd274cfb0', '[\"*\"]', NULL, NULL, '2025-06-28 17:57:07', '2025-06-28 17:57:07'),
(88, 'App\\Models\\User', 4, 'mytoken', '928d1dacaae014f3b579215261dbd844159e4b5957b23da80da28d50dfc1c083', '[\"*\"]', NULL, NULL, '2025-06-28 17:57:09', '2025-06-28 17:57:09'),
(89, 'App\\Models\\User', 4, 'mytoken', '3281cf96a0f51c887f00f891abab504d885455e028c7d8c3edc5c4c5156a4dac', '[\"*\"]', NULL, NULL, '2025-06-28 17:57:09', '2025-06-28 17:57:09'),
(90, 'App\\Models\\User', 4, 'mytoken', '316a442e78060d746e82d8b690344e6f58e907b7011d3c6820817f479e09972b', '[\"*\"]', NULL, NULL, '2025-06-28 17:57:25', '2025-06-28 17:57:25'),
(91, 'App\\Models\\User', 4, 'mytoken', '4de4ba7c7f0b304e20764eeb319f2feccc86f3b69cf7dede0679e9009a689c7c', '[\"*\"]', NULL, NULL, '2025-06-28 17:57:25', '2025-06-28 17:57:25'),
(92, 'App\\Models\\User', 4, 'mytoken', '3b9df30fa693349bc2367d9befac153339952cdf1a86d7b381c91c021c2cc19a', '[\"*\"]', NULL, NULL, '2025-06-28 17:57:25', '2025-06-28 17:57:25'),
(93, 'App\\Models\\User', 4, 'mytoken', 'b0195540c8ce760ed57c276002b6aa91233359cfe9256ff913555de0ef119456', '[\"*\"]', NULL, NULL, '2025-06-28 17:57:26', '2025-06-28 17:57:26'),
(94, 'App\\Models\\User', 4, 'mytoken', '7d89e32c830bb372160afcd147f50b569faecafcfa6e912aeea58d535e25bb28', '[\"*\"]', NULL, NULL, '2025-06-28 17:57:26', '2025-06-28 17:57:26'),
(95, 'App\\Models\\User', 5, 'api-token', 'b7a553e47669273df22bd637d8f9fb42cb8706005be9fc5abae815a1e7e88b77', '[\"*\"]', NULL, NULL, '2025-06-28 17:57:47', '2025-06-28 17:57:47'),
(96, 'App\\Models\\User', 5, 'mytoken', '32ce9efd0d5bebebeb8564132203cc0b4fbd77de46935397a4d23947951592ec', '[\"*\"]', NULL, NULL, '2025-06-28 17:57:48', '2025-06-28 17:57:48'),
(97, 'App\\Models\\User', 4, 'mytoken', 'facc42a1a6304f30dde027bfcbe252c2bf80ae552a7a327760fefd8cdad26231', '[\"*\"]', NULL, NULL, '2025-06-28 18:00:04', '2025-06-28 18:00:04'),
(98, 'App\\Models\\User', 4, 'mytoken', '2b4dcef08cf964a19bd71793b91ccd2aa4341784b97eaa8d495a2bcb41ca7435', '[\"*\"]', NULL, NULL, '2025-06-28 18:00:25', '2025-06-28 18:00:25'),
(100, 'App\\Models\\Admin', 13, 'mytoken', '8b24fefe5ece32000c3cf4db38eed174746d5b51ca101d95b3d6e52536118adb', '[\"*\"]', '2025-07-07 08:45:15', NULL, '2025-06-30 05:47:06', '2025-07-07 08:45:15'),
(101, 'App\\Models\\User', 4, 'mytoken', 'b24bda586c4b1d12b32c9d5ea76329f1bb6544982d69426d5fa3ffac82a059e9', '[\"*\"]', '2025-07-10 20:05:02', NULL, '2025-06-30 07:45:31', '2025-07-10 20:05:02'),
(103, 'App\\Models\\User', 4, 'user-login-token', '51baf72a56ab32e547d5334aa6a335dc39210029838fe7b11f1f1f332381bc60', '[\"*\"]', NULL, NULL, '2025-07-04 08:14:07', '2025-07-04 08:14:07'),
(104, 'App\\Models\\User', 4, 'user-login-token', 'f1e2779592d6ad0a20be8085c7535153bec430de40aec109848979d38078f9ec', '[\"*\"]', NULL, NULL, '2025-07-04 08:21:17', '2025-07-04 08:21:17'),
(109, 'App\\Models\\User', 4, 'user-login-token', '128d1bdc07199f0048e4f7e9e8fbd3c18a104b801b7933df4115b3487a1edd1c', '[\"*\"]', NULL, NULL, '2025-07-04 09:03:39', '2025-07-04 09:03:39'),
(118, 'App\\Models\\User', 4, 'user-login-token', '2df26cdeef304cd3d16e99a1544a3b5b1ce60d3416659ac08677e6292589c4f0', '[\"*\"]', '2025-07-05 01:18:36', NULL, '2025-07-05 00:56:39', '2025-07-05 01:18:36'),
(122, 'App\\Models\\Admin', 13, 'mytoken', 'b577dc5eaf30a38952ef728d2ab55db40767b829c5fc66a0aa91ad0f7a5b314b', '[\"*\"]', '2025-07-09 03:45:31', NULL, '2025-07-09 03:29:44', '2025-07-09 03:45:31'),
(126, 'App\\Models\\Admin', 13, 'mytoken', '0184c3d3431580785af0a4c98e394e5c90a5c54ec8845af1bad43a205530b4d2', '[\"*\"]', '2025-07-10 12:08:17', NULL, '2025-07-09 11:18:38', '2025-07-10 12:08:17'),
(127, 'App\\Models\\Organization', 2, 'mytoken', '1b8e21c25550b4f635fd835df4f16a4dcbbf17bdda70e58fd35f3fb32959ccc5', '[\"*\"]', '2025-07-10 23:38:30', NULL, '2025-07-09 12:29:31', '2025-07-10 23:38:30'),
(128, 'App\\Models\\Admin', 13, 'mytoken', '607810186e8d70016d1f53811a22a6fecdb3633a492883fe7816c9d77daa5947', '[\"*\"]', '2025-07-09 21:20:50', NULL, '2025-07-09 21:16:36', '2025-07-09 21:20:50'),
(129, 'App\\Models\\Admin', 13, 'mytoken', '28bd30e391fbde2058e1f7fb3147176aa10800e926cf25c21133dc1c64ed967a', '[\"*\"]', '2025-07-10 10:36:39', NULL, '2025-07-09 21:22:09', '2025-07-10 10:36:39'),
(138, 'App\\Models\\Organization', 2, 'mytoken', '2a1d117413928d53ab2b2391d06dc591b313ecf0a19ebdc2918400b67ea44fe2', '[\"*\"]', NULL, NULL, '2025-07-10 12:22:12', '2025-07-10 12:22:12'),
(140, 'App\\Models\\User', 6, 'user-login-token', '5dddbf8a3eaf8110fbb2d96c53f6c014ec5962e6a2c350760928233b7283aecd', '[\"*\"]', NULL, NULL, '2025-07-10 18:06:07', '2025-07-10 18:06:07'),
(141, 'App\\Models\\User', 6, 'user-login-token', 'ed4cb92420c231453b252314de427f0db30f4584949c8e7b205802ee8a86700f', '[\"*\"]', NULL, NULL, '2025-07-10 18:10:07', '2025-07-10 18:10:07'),
(142, 'App\\Models\\Organization', 2, 'mytoken', '493d1f7af42114e7c6798d892e35a99d88e430478af8ee79e942d8adb8001633', '[\"*\"]', NULL, NULL, '2025-07-10 18:37:20', '2025-07-10 18:37:20'),
(143, 'App\\Models\\Organization', 2, 'mytoken', 'e51f9b1697148a8d6af39f879e08c979db19e8927074fe5927aa1a48b7a128e4', '[\"*\"]', NULL, NULL, '2025-07-10 18:41:31', '2025-07-10 18:41:31'),
(144, 'App\\Models\\User', 6, 'user-login-token', '55b80907ea230452ada595f7a4076350ae0ead3f3873dd046a3761b2ecfc1048', '[\"*\"]', '2025-07-13 08:51:46', NULL, '2025-07-10 19:57:21', '2025-07-13 08:51:46'),
(145, 'App\\Models\\User', 7, 'user-signup-token', '0f3375af4bdbe7b3e363ccc414c16f96c4e204b4562f6bd9bfd18528f9a00df2', '[\"*\"]', NULL, NULL, '2025-07-13 09:21:33', '2025-07-13 09:21:33'),
(146, 'App\\Models\\Organization', 3, 'api-token', '1e58bedca8b79ef7dcd63eede4b098be6bf79074cde3034d107ed0c831cba3ca', '[\"*\"]', NULL, NULL, '2025-07-13 09:27:29', '2025-07-13 09:27:29'),
(147, 'App\\Models\\Organization', 1, 'mytoken', '5c95d727b6e9d4fcf83de35695664f74d5056cb89739d610c1c5f84f4502f48b', '[\"*\"]', '2025-07-13 09:53:51', NULL, '2025-07-13 09:31:43', '2025-07-13 09:53:51'),
(148, 'App\\Models\\Admin', 1, 'mytoken', 'c9520adbad029bc7c6790588ac39dd7a910139fee349ef3d10a664c895b1314d', '[\"*\"]', '2025-07-13 09:55:27', NULL, '2025-07-13 09:36:39', '2025-07-13 09:55:27'),
(149, 'App\\Models\\Admin', 1, 'mytoken', 'bb6a945252dc5c86ea34e8219754306e2536b31494cf1d85e2b3963ba4048b66', '[\"*\"]', '2025-07-13 09:52:43', NULL, '2025-07-13 09:39:23', '2025-07-13 09:52:43'),
(150, 'App\\Models\\User', 1, 'user-login-token', 'ecc457e22db2d0b7c7577bfb5b7baae1ce31e694a345e1c069e2475a8dc263b0', '[\"*\"]', '2025-07-13 09:53:20', NULL, '2025-07-13 09:39:50', '2025-07-13 09:53:20'),
(151, 'App\\Models\\Admin', 1, 'mytoken', '11495f657fb5c5127d57355325fd2a7985eb728e18008d74a0d588330edf2742', '[\"*\"]', '2025-07-13 09:58:11', NULL, '2025-07-13 09:57:36', '2025-07-13 09:58:11'),
(152, 'App\\Models\\User', 1, 'user-login-token', 'f28335f1758d40d15ad59595d81cd163224916c261f9d8c661df6dfe399e6d31', '[\"*\"]', '2025-07-13 09:58:58', NULL, '2025-07-13 09:58:39', '2025-07-13 09:58:58');

-- --------------------------------------------------------

--
-- Table structure for table `rating`
--

CREATE TABLE `rating` (
  `rating_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `rating_category_id` bigint UNSIGNED NOT NULL,
  `event_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `rating` decimal(8,2) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rating_category`
--

CREATE TABLE `rating_category` (
  `rating_category_id` bigint UNSIGNED NOT NULL,
  `rating_category_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rating_category`
--

INSERT INTO `rating_category` (`rating_category_id`, `rating_category_name`) VALUES
(1, 'Experience'),
(2, 'Price'),
(3, 'Quality'),
(4, 'Service');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('0eNuCufmQgZ78ZLvuW6VhDykDFopu4m3UdJq658V', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZGQ4c3duVjhvT3VlRFREN0lvVkc1MEptbmhVSjZPV2kzc2hQbWFzZCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZ2V0LXRpY2tldHMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1752424918),
('1AbgumsGqBe898FqVAEeGe2j4q4GqQ5Dn69VAva2', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMnhrZ0JtMWlQREV2ajU5VTFWZlU4YmJ4WjdUTWQyU0FaUW5KT0praiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2xpbWl0PTEwJnNvcnQ9ZmVhdHVyZWQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1752424790),
('287iii7TVufBXnqndQEx73yk5hwxp8K2v7Q6aIrV', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiM2ZTRTFVMzVMZGdqODJnaXpCY2dJcWFHZkFXSVM5dFFXR2tGS2JrTyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzLzE1Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1752425527),
('2F03zW9n2KnLMvqObFauFPq9894tPCKBl2r8iy8M', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWEFNM0NFbHlRMHB0aENFcXZFbjdNQUpOTVpoYXZDMGh0N0ZtbmpvdCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvYWRtaW4vcHJvZmlsZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752422666),
('3DpDJP1M4xO9eU0z9gJE1f2d6aceJHoMr6IlRXyF', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWWV0S093cUwwSUlITEl3RGFZUzIwUFdZd0tTMEM1cklYVGpXc083aiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2xpbWl0PTEwJnNvcnQ9cG9wdWxhciI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752423128),
('3R3o82pPgwLsLdLcer9QMcVnGIpNRb41OcTOiGGI', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRjFmd2ZFU1dWaGtsQkNQSkVDcWNpTVhZcGdXaUhVdTFjT3A2UkJLWCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvcHJvZmlsZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752424917),
('6t8ptyQuemi6gKU3YdfebouQ7TKsJkpog8gQRolM', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNGtOUmRJM216OUVpTVhwZFJhNHBXSVdwMnF1VDMyTW5PeGx1VVlhZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZ2V0LXRpY2tldHMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1752424831),
('6tzZJhHhg8DhlIJNoGwZDHi0y5e0NTXqCG8HoUiT', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSDY3ZzVSamRqYzJPUTVlS0tPUk9qYURLbHg2c2phNWNzSkhuclRVViI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvcHJvZmlsZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752424901),
('6WYq51Dx8e1K5mYRvZysavBhRebtPlTogWiJoDKp', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWDdBZEdlZUJKVTEwbVJONVNLZU1TZkdDYTZkeTRWd09EaFQyeXJidyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvYWRtaW4vcHJvZmlsZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752425560),
('8As2GRlY1D2x5e3ecQVTBy5Mt2dPXkxHPpbPOX3E', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiV0ppVVRtWVU4ZTdpTW5yYXpneDFMMm9yeHdENk85SUQ3REszYlJJbCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDk6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2ZpbHRlcj0ma2V5d29yZD0iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1752425602),
('8MEK6Any7wfUmnz7fsg8c33ax3dvVLJp9spFg274', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoickhoT253eTVzYXQzYnlLZjQ5cnQ4Umh0anRCRGl6S1RkRDA5OFN1NiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2xpbWl0PTEwJnNvcnQ9cG9wdWxhciI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752424380),
('9QUhTDKJnbFk1YVa9OpQHBcm6mNhBMsOsUSrIjup', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoic3ROUlVKRFpCY0xLRU5XZ0JnR2I5dW4yZHFCYlo3c3VtUkhWMjhiRSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2xpbWl0PTEwJnNvcnQ9cG9wdWxhciI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752424855),
('9yNONWIDubszIlG3S7B8hiVZbacApnw0Yr7Hh4RA', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidVBVZjl1TUkzdnkwY3RVemk2Ym1kak5UQ1RBRGc3QzdPc1VxQktoOCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2xpbWl0PTEwJnNvcnQ9cG9wdWxhciI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752424790),
('aoLv5XU55xe5u210qLEK5qkcMwvTSEVeTJSZsDHP', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN2NxYzhXY0Y3WGF3bjNlTW5hSFFSM2htMEVOSE9MZ3BDamNQYkF5QSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2xpbWl0PTEwJnNvcnQ9ZmVhdHVyZWQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1752424702),
('ar6oeW5Q5tZ3Jo7wmewYNm2KBtwmCZ6QpaKGeNAO', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMDVHVU5Rc2FRUFpGdVAxWlRzR3lnQ254cDRKOGt6UWR2V3VCb29YbSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2tleXdvcmQ9Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1752424790),
('b9KFUdcGQRS0ND0bK3pH3PsumcQ6qf7exZb3SRs5', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRm9YakxmSFp4T21CNExjd3g4ajBTbVpLSFhxWHVqb3lSOW5vUWpmayI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZ2V0LXRpY2tldHMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1752424917),
('beamHPIGp1ONNj7UMyXaq6iS8d5eIm7x3Dz29eDL', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNVNSY0l3NEhab1U5ZHQ5RjNkQkJyd2RmdHF3M2lhNktQYVNxQmJURSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZ2V0LXRpY2tldHMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1752424901),
('CccPXx3q2j1yHxmkUCCA5tKV7yoYbfoLx9JvImql', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidE1sV0VhRnlEQlcwbHdPWE1kYUxTekVWZjdVRUptcVlTa1N3QnV0eSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzL3VuZGVmaW5lZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752424863),
('cYi7pQ8M0Qt4t0CKg64AqzIBM8xnobe37BxPl9PT', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVnNxckdOTUpHdGZ6U25UbTBJckZJVWNIUW9vRlR1SktGQ3c2YzRERSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2tleXdvcmQ9Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1752424380),
('delC4qVii0CE5LLSYywQrsgghv6Go4nTn6zSljaH', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibm5adDRrY0g4MjdCTDZsM1M4TmRRTlF4dDVMWEJzOUk2d2lwRElkMiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2xpbWl0PTEwJnNvcnQ9ZmVhdHVyZWQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1752424380),
('dG8fFUNTI7LLBY5g1dz64mQHp3EkHgxpC8rcOwi8', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMkpBVVF1d3dXQ3lnU2V1RVZQUE1WMG1DMHp2SVhyR3VMbEhYWk1YaiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZ2V0LXRpY2tldHMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1752425339),
('DiSg8g7v92yExaeZwZp6nPAo6g7NUhRAmAQbz5ZO', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaW9zWmpoZFBOSWtxdXdsRmlDZ2Z0aWNLWTRPUmV3b3owY01wWFF6WSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2tleXdvcmQ9Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1752425521),
('dkOdu2XojX8DbDWRszeeB6FAbo76wfR5j9nvl61O', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUFA2ZnNJVFM0R0tVSmQ2Rm5sdUNCWVQxaU9zUThuaFlQUW5CVkx2MyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvcHJvZmlsZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752424841),
('DQrid0xbzNJrKAu1p6ARuV6ggIEWt6ZemN0fld9M', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMTdLRDh4YlRhRWQ1bDlrNVZ4TkkyV2ZlVFVRUWh4aEVteXdNZGMxTCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzL3VuZGVmaW5lZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752424812),
('dr7eIqQDgqvptVzeDEAXF6OEiaY52KEdNPsa5Fzy', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoid1VqNUJZaHlDVktwbUtyN29ScUQ3QWFXMWM4NDNiNnhoT25VcEg3YSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2xpbWl0PTEwJnNvcnQ9ZmVhdHVyZWQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1752425527),
('E3aNxGe2wuwdPdPJYz5xNVuy7WF9WohKgtCo9BxM', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiazJXYmw3bHp6dGgxZDFSY2VocndMdGliNmRHYXh2a1I1OU5FeEZocyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2xpbWl0PTEwJnNvcnQ9ZmVhdHVyZWQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1752424829),
('eE3ZXzqfCGLXzNjgkT1gvuZnL2IeF2TpLchvQfr3', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibUxORmEzb3lDa2pwVWRickJONXNkQXFRcmFOVlJrNzBRYTRxRTZ5byI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzL3VuZGVmaW5lZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752424831),
('eexIws5zTt0ORuEkD6m6hF61x1Z5wL2gfM51a5Uo', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOU5zSkYwMGlaUFNXbWZWSnhqcXpUTUNzWWVaQXFORGNZWlhRVzZLUCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvcHJvZmlsZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752425339),
('fGRMGKqnAQ6WkPuSsRUJFRMDxmegpoHTsPIjOI87', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTDl2NUN5YTJTYnl2YUN3eHNEdU5hTFJjNFY4NWszRWowV1N2empydSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2tleXdvcmQ9Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1752425350),
('FlOqbenAoC5Cr8dKbEjQkzYu3V5Fd9nH8PCCv8NN', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibTBnbVFleEhpcTBvbElEY3A2aGx0WFBzNzNJNm1XWjcwTHBCTlZIYiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2tleXdvcmQ9Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1752424382),
('GDI4hJCYrLzsnvDhfStMGZq3Fsn4uhseWb5U2tJL', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWHdMTGZiVXBOb043SHBka2MwN0xadWVheXYwTTVqYmZORDVtZHVqciI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2xpbWl0PTEwJnNvcnQ9ZmVhdHVyZWQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1752424867),
('GNYlw8Mg68tQQJ2rphEu7Eu9dXqMqtTho1I8VTzW', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiclQ2Yzd6TjgwYnVqajRpQ2hzelBDbWJVejJscUxpQnh6aEZqVWNyOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZ2V0LXRpY2tldHMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1752424886),
('gpwpFFX2auXOMkKvDxm2hlg3FGosZEIDTUkAVi5v', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRkN2WW5kek14aURST3liN2hveW9sU2oyVkU1VnZ4M2JOSVpMR1RBcyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2xpbWl0PTEwJnNvcnQ9ZmVhdHVyZWQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1752425349),
('Gz9to48pePI8ace63YpTS32rmdKNYw3P4AUAQxbe', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicmVTV3ViN085ZEtCcktMaU92ZWlrMUtzNnhGd3FZdktyWWVzdHFZaCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZ2V0LXRpY2tldHMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1752424898),
('H4pze7qhGO32o6gmKelBdSTEMYZWAle0nvtomwTh', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSkZBUTFGSEdqb0MwakNnV0daTlpkMzdaeEQ3clZvcERrcnNkN2Q5TSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZ2V0LXRpY2tldHMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1752425536),
('huQNL009dVXS2amnMUMWiJZw9rFjy3snzezaFEI6', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicTVnNzJwVjhsZFY2R2xPQTF6dHREdUJhZUs4d1BTdUpqZXJZa0U2NiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2tleXdvcmQ9Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1752424702),
('iKBIKrK85J5RGp1QxKpCGIqrUnxBAs6gPctviKNE', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWW5sd2NDZVptdUEyS2RmRHdJRzNwZmZVUkVvandOZ2RZS3VvUjByaSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvcHJvZmlsZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752424853),
('IwnrC0zb5D29kroF5CgXh7ejOBtaj8Vn9KsDnRfE', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMng5STM5N21XQmdFMDJLdjRtSzNLWDZMWXZFUjBrRzZtWE1jMEVrZCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2xpbWl0PTEwJnNvcnQ9cG9wdWxhciI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752424702),
('jAzLczrfnY5p8WXFqeTHA3ZXOPro1xg3EZpHaIDy', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUmd0b0UxbHdUSEg2Sng2dXpqMVBhS3NoT0pwdmdJbXBhZkpLWURYTCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2xpbWl0PTEwJnNvcnQ9ZmVhdHVyZWQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1752424790),
('lHqfjcHTiL49LFlmMYnCXocb5UYDU2Mp1cGQcN4n', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicnA0dkVmUm9wZTJmU29scXRQYVlQdGF4WjZrYVB5aFRKMEFZTWNrQiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzL3VuZGVmaW5lZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752424884),
('LKsRmU8Rip7bvRsfYyqXKPkvPPuULREij94KntFE', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTzFhWnBCUlI5MFpkSmo0TTVtV2lYVWEzZWJVdHZEbkZvSTFOZWJDZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzL3VuZGVmaW5lZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752425531),
('LMN2hws2Lq8KWZHGf7ec7Y6m0xO9SzwQcVB7tHEx', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUzRFS3RWT1Bta294anFwaDRmdmlyd09YUzVkdExLMUpvMlNTWkFOWCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzLzE0Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1752424792),
('lmPraCZWxIK7m8qFFbOzE9gre52sLjujkebHHl1o', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaTZFU3ZSbmo1eW5ma3BXV2R5c0NjWE5BYVJEREtzbUczRk1IdzNabiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2xpbWl0PTEwJnNvcnQ9ZmVhdHVyZWQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1752424793),
('lxArDzedRgq0zpPZ9Va1tkUO9puBlcU5LcEm5ooP', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoid2d5NHhCWjdOdkp2VXRKcmhXYlJ4dDNmenZJYjJHWVAxdTFnSEJGeiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzLzE0Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1752424867),
('mBewaQ64CGN5ClkbFYrd3MBFRRq6Gd4CELIzCEvT', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTW9OZU93ZDNINVN3N3M5bjZlU2s1amhLTGxvMmM1QzVvZFltR2pMQiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzLzE0Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1752424856),
('mcgAC4hmr0Wo7IvkjrqJuTJVwtTSrjqpdANnCB3q', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieHRZeURkTk5oNkJrUk1zZm5mcmFXYU8xVVJvbW5JakVQQjFYa1hIZiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvcHJvZmlsZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752425536),
('MdyNo1V6IbQBtewBDqqwcueXy2Ycy5y6RoIhDZnI', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoia25vQktFYTl1bkFiZzA2VUZ6bER1c29Ya3c2bkZCc09rN0RwemZIcSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzLzE0Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1752424704),
('MIbZ0Lmc50QlXF03jwhNV9XQoKeZUWafGDgDJgXs', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVVB0MU56QVFqOWlSakJGbmxPWWxPRmlJQkNzN2pxRmpqNUhPdHRUOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2xpbWl0PTEwJnNvcnQ9ZmVhdHVyZWQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1752425521),
('nPI7XrqEBhDCZIOhC9QBdA2vH7Op786lR7UpcKaX', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoib3ZjamJDZmQzRk0xVWxoSVFQdFV4Z0JWbUxUVU1yMGYwOGhwQXVjeSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2xpbWl0PTEwJnNvcnQ9ZmVhdHVyZWQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1752423128),
('ocIeQZXsGEZbnhjUboSLJA2yMgx0c5wBOLItxqzV', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWGprOTY0RWJFUXZ4RHJBNmtzUEFaQlpMUHYwUjVGSEg0NmxUT3IzbSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZ2V0LXRpY2tldHMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1752425600),
('PDCjGWrOIgh1v4ywGuRy4QlJJe5rB59pVhIGKKfP', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN0F0aDZya0Mxb1A5MFRKT3ZubUN0SVpmQVVlMWlEdExhd3RDMFgxciI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2tleXdvcmQ9Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1752424790),
('pEuryZbn4aMXVDynV34DAHlfmAvoQ4L29Mbs3VXp', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTktKS3dSWVo0ejBZOFNuSFV4a1R1UldzWkZEdzI3b1FOWkZMRmZhcSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2xpbWl0PTEwJnNvcnQ9ZmVhdHVyZWQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1752424790),
('pRP1OvL4JSmcYtTa5sRlzmgAimZPgGqvzVcBtcsA', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZXBJWlJpUVgyRDFUYW40N1RLb0ZBRTdIZTBvcFo2UG9KSFlNZ1JidSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2xpbWl0PTEwJnNvcnQ9cG9wdWxhciI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752424790),
('PTF4hyVWRTOa9oiRU4SN2baFh4MSKfU5mOXfmBJS', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQXlVOHM3VnhLWkdxTFdkMWZxdFREc3g5RE4xTTdGQnAyUEVZbW1waCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2xpbWl0PTEwJnNvcnQ9ZmVhdHVyZWQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1752424856),
('PWmc8hCXq8ssIHSS4wwoBaO4kFYXFWszZ3LXOpWF', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicHJEc0ZnZ2w2SHpmZldKeWllRHQ1OTBhem1YT2JkZjk3aHkxenRVTSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2tleXdvcmQ9Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1752424855),
('Q0727sZV7tuXlmy0vNlEQ0rU1Nn6w86O9bEz7JIX', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoia1Jqc29GMUQ3WVhoVUVEdTRkajg4eVFzZHdBUDQ3OVVsWTNRZE5vaiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvcHJvZmlsZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752424831),
('QduQOorHCKJXHTPRh2tgNYsQQx99VkgJfJITHpm2', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiU2E1OVV4VFlRVkJKZzRVdWlFYnJ3UmNUaDhZSERkeGdxMndjZzdINiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2xpbWl0PTEwJnNvcnQ9cG9wdWxhciI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752425349),
('r5FNIt0YwkvE9654CldMvAZj2XphpRwHdFDysmW1', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMUR2U2pvdkYwNllqNHZ5NnUzSElZdHZGTERHNEpIZkhvYWNla0hCbCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvcHJvZmlsZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752424898),
('rFDqeol8VKDNlOsYRH51X5ErqSVOCpBwJXk17I7M', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicGRTYjJFdTNsN1lrcFRGbnB3SUQ1Y3lRRnBVVUxFRWYzdzlLN0V3RyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvcHJvZmlsZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752424918),
('RfSs3CfcE0KHO4iAAgVcvw6DIVGlx5madLnZlKhq', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN05YSENoM09MUDQ2eHR5NW9xWUtvMEFsaHpXU1pXWnZVQUIyT2J5aSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2tleXdvcmQ9Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1752423128),
('rQbOUGBIoz9CfmYTapdcRHFp7JiXU0ukHy0jTlDi', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiU3E1R2o4VlY1QnVkSHFGWTBIUDFac1hDMHZrbUhUa0tuNXl4V0dvTSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzLzE0Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1752424829),
('UzJpOAqunjdsM9DuKrE9xfhq2oInvbyySi9VEONM', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieG5VS2xHUDVNN0U0RW1DZDJyNk45QmJPNEJuOEs2S3dtbEJhRWVMNSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2xpbWl0PTEwJnNvcnQ9cG9wdWxhciI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752425350),
('V0iHFUmKuIr0kymP6oQpKnaxGYioexLiVdihSVL7', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibUZ5Y3BvaGp4UWYxMGZSampCaHlFWU1ldEJQVXZOZWo2OXdDYTUwTiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvYWRtaW4vcHJvZmlsZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752424763),
('Vs0nUBf63QC3QPAzNeOWzk4RLBeGZ5t2zo6861hf', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSUVDaEtYdVVsT3V2UUVSNFd5eUxxQkxwZGNHdVlTY2I2WjNpbm4zdiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2xpbWl0PTEwJnNvcnQ9ZmVhdHVyZWQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1752424382),
('wBHdxtuLflb4fNC2UpD8lz3MjSh0LQQNj2ybYXgo', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicWQ4bTBockVOVW9DdEJyUlAzbE1Tb0E0dnFZY1VsbnhnQllXMlFsNyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvYWRtaW4vcHJvZmlsZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752424741),
('wElCXu7szqFBr8fBQRZB0koVpiTTis5TjGbQjksC', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMk56a0J0MHpvaDhTbUozS2xPSjNEc2VxMHRMdkl4R1hYdlJJZDVMdSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvYWRtaW4vcHJvZmlsZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752422921),
('WImMaLMyMvG99ixW2rvvmVlNDrdr0WcKcAJjRPsO', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYmRPOUdLQWJmdm5kNURzZTlPbG5HcjlNZUJsc2tvOHI2Z2ZhUnl6VCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDk6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2ZpbHRlcj0ma2V5d29yZD0iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1752425533),
('wvyxhUpaTrNsjgrwYnYWCsuycNRd3jxjMURVrS9d', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYnd3bXJrR21aTnl6NXJWZmdSOERQdXN5STFHc29Nelh3eWZyM1NvUSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvcHJvZmlsZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752424886),
('WwU0P2KG0C9iUAeUYULzeM23Hy3aY8XcAvBXbsvB', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibDdaODRyYWpVZjh2Rnc1WXpkNmo3ZmtnODc5MG9MbzZPbE9DazFtdSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZ2V0LXRpY2tldHMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1752424853),
('wzL2eORzKFZhvdjcnZKVTXzVByYeUlovdpZ5yhU5', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiS1lqdzNaZHpQZVFZclFxUkJieWNwSTJYRFFyRmNUOE9Nb0dPRldUaSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2xpbWl0PTEwJnNvcnQ9cG9wdWxhciI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752425521),
('XIgRnPPrbElnPM8BmJffxvITU8VP6DhIl8zRCHCl', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOW4zb1dRa1l5Sjh5R0Z3Mk05WlU5UnUwUXM4WmtrSmlMZFhLRXJCRyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvcHJvZmlsZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752425600),
('XX9zT60El39B5t13DPDDgWEFDsxGvVp1QgrnteSa', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiYkNENDhWVnVHcExRYzROakRyUk9wdXltZmF0UUxiV0FReGF1MEFCNyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzg6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvYWRtaW4vZXZlbnRzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MjoibG9naW5fYWRtaW5fNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO3M6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjA6IiQyeSQxMiQ0V0hkYnVvVEhKandkSHg4Z0REeFR1LlNncHc3RmZsQWhRcFROaXJ6cjBhcHFmMENHYzI2dSI7fQ==', 1752425972),
('XyJBVYQMoNiN0r5Yk9GFhHWLpS2TEjYBnSi2It1P', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMTlURTJSUm9RNHhvZ3RQWGRON0dtY1Z1d2UwaEdMdWwxYXhOYUVMNSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvYWRtaW4vcHJvZmlsZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752425563),
('yefT6hK5dw8jBZgIdfSR1ftK1dPpjlX6PffB5bM8', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUWs5V3JvbXY4NkExYWdOajRhOXl3NHk1bzUyemZYb2xXS25jYmtrNyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2xpbWl0PTEwJnNvcnQ9ZmVhdHVyZWQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1752425350),
('yW1NE4RVuJoZiO32gKE5fLJTWOO7dLBPT7AVd79Z', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibWU1eUJ4Y29IaExLTlV2bzl1eno4SWt2b01DcDlPcm90NVBXalc4YiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2xpbWl0PTEwJnNvcnQ9ZmVhdHVyZWQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1752424855),
('yxnkAYOwYBjpKx2cbiUesPJKU8SFqF4bD0n7v00i', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiakJoZGdtajFhdUh5Yk9FZ0dIbUhVcjFqZkxZZExZN2RmNDhrVUtJWiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2xpbWl0PTEwJnNvcnQ9cG9wdWxhciI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752424382),
('ZEdJW3OXdF68qSRAd0MRfppfFUauk9VWzOrCa1Md', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYUl3RVhZRmp4RmJzV0I3TjZ0eTZCWU12ZnczYWw3ZlY1SHZKQVhMWSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2xpbWl0PTEwJnNvcnQ9ZmVhdHVyZWQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1752424704),
('Zfbwy7qtcmuzD3eE6Ndu3fmOrzhzeSMfZE3JSNcD', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicHc4NkI3Ykw3dkxPOW1sZGVUSk1NM3Rwa2tNVjJsajRvNEU0ZllPdiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzL3VuZGVmaW5lZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752424710),
('ZlAvlf3Mht79lC3pqpdNCUfHySm3JeEYhqVzvbSy', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUm4zd2dMUDIxSUhVdEtpRFIzejF6QXRYbnBxaW5ubFBGWHozWTNVUiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2tleXdvcmQ9Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1752425349),
('ZLCEkBl74VdMSLkYI5eyTzf29omKLMbrcWD52z75', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTmZVVzFKY1VHb2lPVzdhbWpxZFRvSmJ3MkROWUx5TGsxdmZzUzBtdyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZ2V0LXRpY2tldHMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1752424841),
('ZRoaBGirTwD8N51Z10qER6RH0KSfQCMpq9mT7R9B', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWWJ3eUNXaWZobHlmUlZjV056OGZ6V0t3djRDZG0xZ3d1OURleGFoZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZXZlbnRzP2xpbWl0PTEwJnNvcnQ9cG9wdWxhciI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752424790);

-- --------------------------------------------------------

--
-- Table structure for table `ticket`
--

CREATE TABLE `ticket` (
  `ticket_id` bigint UNSIGNED NOT NULL,
  `event_id` bigint UNSIGNED NOT NULL,
  `purchase_date` timestamp NOT NULL,
  `payment_id` int DEFAULT NULL,
  `ticket_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_price` decimal(8,2) NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `event_date_id` bigint UNSIGNED DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ticket`
--

INSERT INTO `ticket` (`ticket_id`, `event_id`, `purchase_date`, `payment_id`, `ticket_code`, `total_price`, `user_id`, `event_date_id`, `status`) VALUES
(90, 14, '2025-07-13 09:41:25', 56, '56-01', 200.00, 1, 25, 'bought'),
(91, 14, '2025-07-13 09:41:25', 56, '56-02', 200.00, 1, 25, 'bought'),
(92, 14, '2025-07-13 09:41:25', 56, '56-03', 200.00, 1, 25, 'bought');

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `transaction_id` bigint UNSIGNED NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `org_id` bigint UNSIGNED DEFAULT NULL,
  `event_id` int NOT NULL,
  `payment_id` int NOT NULL,
  `transaction_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `commission_amount` double NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`transaction_id`, `amount`, `user_id`, `org_id`, `event_id`, `payment_id`, `transaction_date`, `commission_amount`, `updated_at`, `created_at`) VALUES
(27, 600.00, 1, 1, 14, 56, '2025-07-13 16:41:25', 30, '2025-07-13 09:41:25', '2025-07-13 09:41:25');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` bigint UNSIGNED NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00',
  `profile_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `username`, `email`, `password`, `balance`, `profile_image`, `status`, `created_at`, `updated_at`) VALUES
(1, 'User', 'user@gmail.com', '$2y$12$4WHdbuoTHJjwdHx8gDDxTu.Sgpw7FflAhQpTNirzr0apqf0CGc26u', 999600.00, NULL, 1, '2025-07-13 09:21:33', '2025-07-13 09:40:52');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_log`
--
ALTER TABLE `activity_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subject` (`subject_type`,`subject_id`),
  ADD KEY `causer` (`causer_type`,`causer_id`),
  ADD KEY `activity_log_log_name_index` (`log_name`);

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `checkin_log`
--
ALTER TABLE `checkin_log`
  ADD PRIMARY KEY (`checkin_id`),
  ADD UNIQUE KEY `checkin_log_ticket_id_unique` (`ticket_id`),
  ADD UNIQUE KEY `ticket_code` (`ticket_code`),
  ADD KEY `checkin_log_user_id_foreign` (`user_id`),
  ADD KEY `checkin_log_event_id_foreign` (`event_id`);

--
-- Indexes for table `event`
--
ALTER TABLE `event`
  ADD PRIMARY KEY (`event_id`),
  ADD KEY `event_org_id_foreign` (`org_id`),
  ADD KEY `event_admin_id_foreign` (`admin_id`),
  ADD KEY `event_event_category_id_foreign` (`event_category_id`);

--
-- Indexes for table `event_category`
--
ALTER TABLE `event_category`
  ADD PRIMARY KEY (`event_category_id`);

--
-- Indexes for table `event_date`
--
ALTER TABLE `event_date`
  ADD PRIMARY KEY (`event_date_id`),
  ADD KEY `fk_event_date_event` (`event_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `organization`
--
ALTER TABLE `organization`
  ADD PRIMARY KEY (`org_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `payment_user_id_foreign` (`user_id`),
  ADD KEY `payment_event_id_foreign` (`event_id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `rating`
--
ALTER TABLE `rating`
  ADD PRIMARY KEY (`rating_id`),
  ADD KEY `rating_user_id_foreign` (`user_id`),
  ADD KEY `rating_rating_category_id_foreign` (`rating_category_id`),
  ADD KEY `rating_event_id_foreign` (`event_id`);

--
-- Indexes for table `rating_category`
--
ALTER TABLE `rating_category`
  ADD PRIMARY KEY (`rating_category_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `ticket`
--
ALTER TABLE `ticket`
  ADD PRIMARY KEY (`ticket_id`),
  ADD UNIQUE KEY `ticket_code_unique` (`ticket_code`),
  ADD KEY `ticket_event_id_foreign` (`event_id`),
  ADD KEY `ticket_user_id_foreign` (`user_id`),
  ADD KEY `event_date_id` (`event_date_id`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `transaction_user_id_foreign` (`user_id`),
  ADD KEY `transaction_org_id_foreign` (`org_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_log`
--
ALTER TABLE `activity_log`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=616;

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `admin_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `checkin_log`
--
ALTER TABLE `checkin_log`
  MODIFY `checkin_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `event`
--
ALTER TABLE `event`
  MODIFY `event_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `event_category`
--
ALTER TABLE `event_category`
  MODIFY `event_category_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `event_date`
--
ALTER TABLE `event_date`
  MODIFY `event_date_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `organization`
--
ALTER TABLE `organization`
  MODIFY `org_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `payment_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=153;

--
-- AUTO_INCREMENT for table `rating`
--
ALTER TABLE `rating`
  MODIFY `rating_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `rating_category`
--
ALTER TABLE `rating_category`
  MODIFY `rating_category_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `ticket`
--
ALTER TABLE `ticket`
  MODIFY `ticket_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `transaction_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `checkin_log`
--
ALTER TABLE `checkin_log`
  ADD CONSTRAINT `checkin_log_event_id_foreign` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `checkin_log_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`ticket_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `checkin_log_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `event`
--
ALTER TABLE `event`
  ADD CONSTRAINT `event_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`),
  ADD CONSTRAINT `event_event_category_id_foreign` FOREIGN KEY (`event_category_id`) REFERENCES `event_category` (`event_category_id`),
  ADD CONSTRAINT `event_org_id_foreign` FOREIGN KEY (`org_id`) REFERENCES `organization` (`org_id`);

--
-- Constraints for table `event_date`
--
ALTER TABLE `event_date`
  ADD CONSTRAINT `fk_event_date_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE;

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_event_id_foreign` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`),
  ADD CONSTRAINT `payment_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `rating`
--
ALTER TABLE `rating`
  ADD CONSTRAINT `rating_event_id_foreign` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`),
  ADD CONSTRAINT `rating_rating_category_id_foreign` FOREIGN KEY (`rating_category_id`) REFERENCES `rating_category` (`rating_category_id`),
  ADD CONSTRAINT `rating_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `ticket`
--
ALTER TABLE `ticket`
  ADD CONSTRAINT `ticket_event_id_foreign` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`),
  ADD CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`event_date_id`) REFERENCES `event_date` (`event_date_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ticket_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `transaction_org_id_foreign` FOREIGN KEY (`org_id`) REFERENCES `organization` (`org_id`),
  ADD CONSTRAINT `transaction_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
