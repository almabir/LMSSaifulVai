-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 24, 2025 at 08:55 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lms`
--

-- --------------------------------------------------------

--
-- Table structure for table `about_sections`
--

CREATE TABLE `about_sections` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `video_url` varchar(255) DEFAULT NULL,
  `button_url` varchar(255) DEFAULT NULL,
  `year_experience` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `about_sections`
--

INSERT INTO `about_sections` (`id`, `image`, `video_url`, `button_url`, `year_experience`, `created_at`, `updated_at`) VALUES
(1, NULL, NULL, NULL, NULL, '2025-05-12 13:38:00', '2025-05-12 13:38:00');

-- --------------------------------------------------------

--
-- Table structure for table `about_section_translations`
--

CREATE TABLE `about_section_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `about_section_id` bigint(20) UNSIGNED NOT NULL,
  `lang_code` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `button_text` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `bio` text DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `forget_password_token` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `email`, `image`, `password`, `bio`, `status`, `created_at`, `updated_at`, `forget_password_token`) VALUES
(1, 'John Doe', 'admin@gmail.com', 'uploads/website-images/admin.jpg', '$2y$12$/hIFcvRiPwZTBKZ8KPSL1uktty/NJKkojKB9LV6dXY6zbONR8TufO', NULL, 'active', '2025-05-12 13:38:00', '2025-05-12 13:38:00', NULL),
(2, 'Omar Faruque', 'abir43tee@gmail.com', NULL, '$2y$12$o8UATM2xsehDAYjuTVFlReHPL.mHIM/Fm3ORlh9vDGFdHMwV4uYy6', NULL, 'active', '2025-06-16 15:50:49', '2025-06-16 15:50:49', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `affiliate_commissions`
--

CREATE TABLE `affiliate_commissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `course_id` bigint(20) UNSIGNED NOT NULL,
  `commission_amount` decimal(10,2) NOT NULL,
  `status` enum('pending','paid','cancelled') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `affiliate_commissions`
--

INSERT INTO `affiliate_commissions` (`id`, `user_id`, `order_id`, `course_id`, `commission_amount`, `status`, `created_at`, `updated_at`) VALUES
(1, 1002, 1, 1, 10.00, 'paid', NULL, '2025-06-24 18:32:15'),
(2, 1001, 11, 2, 1000.00, 'paid', '2025-06-21 14:36:09', '2025-06-24 18:07:11'),
(3, 1001, 1, 1, 100.00, 'pending', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `affiliate_links`
--

CREATE TABLE `affiliate_links` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `course_id` bigint(20) UNSIGNED NOT NULL,
  `referral_code` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `affiliate_links`
--

INSERT INTO `affiliate_links` (`id`, `user_id`, `course_id`, `referral_code`, `created_at`, `updated_at`) VALUES
(1, 1002, 1, '123', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, 1001, 1, 'HIAYqmjGNc', '2025-06-20 18:04:06', '2025-06-20 18:04:06'),
(3, 1002, 2, 'fzgkmmQ9sP', '2025-06-21 12:43:58', '2025-06-21 12:43:58'),
(4, 1001, 2, 'i0lekiaYus', '2025-06-21 13:54:30', '2025-06-21 13:54:30');

-- --------------------------------------------------------

--
-- Table structure for table `affiliate_requests`
--

CREATE TABLE `affiliate_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `reason` text DEFAULT NULL,
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `affiliate_requests`
--

INSERT INTO `affiliate_requests` (`id`, `user_id`, `reason`, `status`, `created_at`, `updated_at`) VALUES
(1, 1002, 'ddd', 'approved', '2025-06-18 19:09:30', '2025-06-20 16:53:08'),
(2, 1001, NULL, 'approved', '2025-06-20 17:55:48', '2025-06-20 17:58:25');

-- --------------------------------------------------------

--
-- Table structure for table `aff_withdraw_methods`
--

CREATE TABLE `aff_withdraw_methods` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `min_amount` decimal(8,2) NOT NULL DEFAULT 0.00,
  `max_amount` decimal(8,2) NOT NULL DEFAULT 0.00,
  `description` text DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `aff_withdraw_methods`
--

INSERT INTO `aff_withdraw_methods` (`id`, `name`, `min_amount`, `max_amount`, `description`, `status`, `created_at`, `updated_at`) VALUES
(3, 'Nagad', 100.00, 10000.00, 'Write you Nagad Number, for details contact 01711427737.', 'active', '2025-06-21 18:52:17', '2025-06-22 14:15:48'),
(4, 'Cash', 0.10, 5000.00, 'To receive your payment in cash, please provide your full name and a contact phone number. We will call you to arrange a time and place for pickup.', 'active', '2025-06-22 14:14:41', '2025-06-22 15:22:04'),
(5, 'bKash', 5.00, 50.00, 'call 0000', 'active', '2025-06-22 15:01:24', '2025-06-22 15:01:24');

-- --------------------------------------------------------

--
-- Table structure for table `aff_withdraw_requests`
--

CREATE TABLE `aff_withdraw_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `method` varchar(255) NOT NULL,
  `current_amount` decimal(8,2) NOT NULL DEFAULT 0.00,
  `withdraw_amount` decimal(8,2) NOT NULL DEFAULT 0.00,
  `account_info` text NOT NULL,
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `approved_date` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `aff_withdraw_requests`
--

INSERT INTO `aff_withdraw_requests` (`id`, `user_id`, `method`, `current_amount`, `withdraw_amount`, `account_info`, `status`, `approved_date`, `created_at`, `updated_at`) VALUES
(5, 1001, 'Cash', 0.50, 0.50, '559', 'approved', NULL, '2025-06-22 15:37:46', '2025-06-22 15:37:46'),
(6, 1001, 'Cash', 900.00, 100.00, '6666', 'approved', '2025-06-23 00:47:54', '2025-06-22 15:54:05', '2025-06-22 18:47:54'),
(7, 1001, 'Cash', 1089.20, 10.00, '45245', 'approved', '2025-06-22 23:08:58', '2025-06-22 17:00:32', '2025-06-22 17:08:58'),
(8, 1001, 'bKash', 2079.20, 100.00, '1254', 'approved', '2025-06-22 23:51:47', '2025-06-22 17:45:10', '2025-06-22 17:51:47'),
(9, 1001, 'Cash', 1779.20, 10.00, '100', 'approved', '2025-06-23 00:05:29', '2025-06-22 18:04:06', '2025-06-22 18:05:29'),
(10, 1001, 'Cash', 779.50, 100.00, '100', 'approved', '2025-06-23 00:36:16', '2025-06-22 18:24:31', '2025-06-22 18:36:16'),
(11, 1001, 'Cash', 2779.50, 10.00, '123', 'approved', '2025-06-23 00:43:58', '2025-06-22 18:43:42', '2025-06-24 18:32:15'),
(12, 1001, 'Nagad', 2629.50, 150.00, '123456', 'approved', '2025-06-25 00:34:45', '2025-06-24 18:34:07', '2025-06-24 18:34:45');

-- --------------------------------------------------------

--
-- Table structure for table `announcements`
--

CREATE TABLE `announcements` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `course_id` bigint(20) UNSIGNED NOT NULL,
  `instructor_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `announcement` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `badges`
--

CREATE TABLE `badges` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `condition_from` int(11) NOT NULL DEFAULT 0,
  `condition_to` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `badges`
--

INSERT INTO `badges` (`id`, `key`, `image`, `name`, `description`, `condition_from`, `condition_to`, `status`, `created_at`, `updated_at`) VALUES
(1, 'registration_badge_one', 'uploads/custom-images/wsus-img-2024-06-05-08-13-59-9888.png', 'Badge 1', NULL, 1, 2, 1, '2024-06-05 02:13:58', '2024-06-05 02:13:59'),
(2, 'registration_badge_two', 'uploads/custom-images/wsus-img-2024-06-05-08-14-23-4795.png', 'badge 2', NULL, 3, 4, 1, '2024-06-05 02:14:23', '2024-06-05 02:14:23'),
(3, 'registration_badge_three', 'uploads/custom-images/wsus-img-2024-06-05-08-14-55-9047.png', 'Badge 3', NULL, 5, 6, 1, '2024-06-05 02:14:55', '2024-06-05 02:14:55'),
(4, 'course_count_badge_one', 'uploads/custom-images/wsus-img-2024-06-05-08-15-33-5592.png', 'Badge 1', NULL, 1, 2, 1, '2024-06-05 02:15:33', '2024-06-05 02:15:33'),
(5, 'course_count_badge_two', 'uploads/custom-images/wsus-img-2024-06-05-08-16-01-1865.png', 'Badge 2', NULL, 3, 4, 1, '2024-06-05 02:16:01', '2024-06-05 02:16:01'),
(6, 'course_count_badge_three', 'uploads/custom-images/wsus-img-2024-06-05-08-16-24-6251.png', 'Badge 3', NULL, 4, 5, 1, '2024-06-05 02:16:24', '2024-06-05 02:16:24'),
(7, 'course_rating_badge_one', 'uploads/custom-images/wsus-img-2024-06-05-08-16-57-4076.png', 'Badge 1', NULL, 0, 1, 1, '2024-06-05 02:16:57', '2024-06-05 02:18:18'),
(8, 'course_rating_badge_two', 'uploads/custom-images/wsus-img-2024-06-05-08-17-26-1574.png', 'Badge 2', NULL, 2, 3, 1, '2024-06-05 02:17:26', '2024-06-05 02:18:28'),
(9, 'course_rating_badge_three', 'uploads/custom-images/wsus-img-2024-06-05-08-18-48-6887.png', 'Badge 3', NULL, 4, 5, 1, '2024-06-05 02:17:52', '2024-06-05 02:18:48'),
(10, 'course_enroll_badge_one', 'uploads/custom-images/wsus-img-2024-06-05-08-19-08-6764.png', 'Badge 1', NULL, 1, 2, 1, '2024-06-05 02:19:08', '2024-06-05 02:19:08'),
(11, 'course_enroll_badge_two', 'uploads/custom-images/wsus-img-2024-06-05-08-19-24-6958.png', 'Badge 2', NULL, 2, 3, 1, '2024-06-05 02:19:24', '2024-06-05 02:19:24'),
(12, 'course_enroll_badge_three', 'uploads/custom-images/wsus-img-2024-06-05-08-19-52-2846.png', 'Badge 3', NULL, 4, 5, 1, '2024-06-05 02:19:52', '2024-06-05 02:19:52');

-- --------------------------------------------------------

--
-- Table structure for table `banned_histories`
--

CREATE TABLE `banned_histories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `reasone` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `banner_sections`
--

CREATE TABLE `banner_sections` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `instructor_image` varchar(255) DEFAULT NULL,
  `student_image` varchar(255) DEFAULT NULL,
  `bg_image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `basic_payments`
--

CREATE TABLE `basic_payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `basic_payments`
--

INSERT INTO `basic_payments` (`id`, `key`, `value`, `created_at`, `updated_at`) VALUES
(1, 'stripe_key', 'stripe_key', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(2, 'stripe_secret', 'stripe_secret', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(3, 'stripe_currency_id', '1', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(4, 'stripe_status', 'active', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(5, 'stripe_charge', '0', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(6, 'stripe_image', 'uploads/website-images/stripe.png', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(7, 'paypal_app_id', 'paypal_app_id', '2025-05-12 13:37:56', '2025-05-27 16:28:57'),
(8, 'paypal_client_id', 'paypal_client_id', '2025-05-12 13:37:56', '2025-05-27 16:28:57'),
(9, 'paypal_secret_key', 'paypal_secret_key', '2025-05-12 13:37:56', '2025-05-27 16:28:57'),
(10, 'paypal_account_mode', 'sandbox', '2025-05-12 13:37:56', '2025-05-27 16:28:57'),
(11, 'paypal_currency_id', '1', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(12, 'paypal_charge', '0', '2025-05-12 13:37:56', '2025-05-27 16:28:57'),
(13, 'paypal_status', 'active', '2025-05-12 13:37:56', '2025-05-27 16:28:57'),
(14, 'paypal_image', 'uploads/website-images/paypal.jpg', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(15, 'bank_information', 'Bank Name => Your bank name\r\nAccount Number =>  Your bank account number\r\nRouting Number => Your bank routing number\r\nBranch => Your bank branch name', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(16, 'bank_status', 'active', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(17, 'bank_image', 'uploads/website-images/bank-pay.png', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(18, 'bank_charge', '0', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(19, 'bank_currency_id', '1', '2025-05-12 13:37:56', '2025-05-12 13:37:56');

-- --------------------------------------------------------

--
-- Table structure for table `blogs`
--

CREATE TABLE `blogs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `admin_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `blog_category_id` bigint(20) UNSIGNED NOT NULL,
  `slug` text NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `views` bigint(20) NOT NULL DEFAULT 0,
  `show_homepage` tinyint(1) NOT NULL DEFAULT 0,
  `is_popular` tinyint(1) NOT NULL DEFAULT 0,
  `tags` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `blog_categories`
--

CREATE TABLE `blog_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `slug` varchar(255) NOT NULL,
  `position` int(11) NOT NULL DEFAULT 0,
  `parent_id` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `blog_category_translations`
--

CREATE TABLE `blog_category_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `blog_category_id` bigint(20) UNSIGNED NOT NULL,
  `lang_code` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `short_description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `blog_comments`
--

CREATE TABLE `blog_comments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `blog_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `comment` text NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `blog_translations`
--

CREATE TABLE `blog_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `blog_id` bigint(20) UNSIGNED NOT NULL,
  `lang_code` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `seo_title` text DEFAULT NULL,
  `seo_description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `certificate_builders`
--

CREATE TABLE `certificate_builders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `background` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `sub_title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `certificate_builders`
--

INSERT INTO `certificate_builders` (`id`, `background`, `title`, `sub_title`, `description`, `signature`, `created_at`, `updated_at`) VALUES
(1, 'uploads/website-images/certificate.png', 'Awarded to [student_name]', 'For completing [course]', 'This certificate is awarded to recognize the successful completion of the course [course] offered on the platform [platform_name] by [instructor_name]. The recipient,[student_name], has demonstrated commendable dedication and proficiency.', 'uploads/website-images/signature.png', '2024-05-15 21:56:38', '2024-05-16 04:02:12');

-- --------------------------------------------------------

--
-- Table structure for table `certificate_builder_items`
--

CREATE TABLE `certificate_builder_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `element_id` varchar(255) DEFAULT NULL,
  `x_position` varchar(255) DEFAULT NULL,
  `y_position` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `certificate_builder_items`
--

INSERT INTO `certificate_builder_items` (`id`, `element_id`, `x_position`, `y_position`, `created_at`, `updated_at`) VALUES
(1, 'title', '326.99993896484375', '208', NULL, '2024-05-15 23:00:14'),
(2, 'sub_title', '377.00006103515625', '249', NULL, '2024-05-16 04:05:19'),
(3, 'description', '25', '306', NULL, '2024-05-16 04:45:02'),
(4, 'signature', '401', '412.99998474121094', NULL, '2024-05-16 04:14:05');

-- --------------------------------------------------------

--
-- Table structure for table `cities`
--

CREATE TABLE `cities` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `state_id` bigint(20) UNSIGNED NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `configurations`
--

CREATE TABLE `configurations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `config` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `configurations`
--

INSERT INTO `configurations` (`id`, `config`, `value`, `created_at`, `updated_at`) VALUES
(1, 'setup_complete', '1', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(2, 'setup_stage', '5', '2025-05-12 13:37:56', '2025-05-12 13:37:56');

-- --------------------------------------------------------

--
-- Table structure for table `contact_messages`
--

CREATE TABLE `contact_messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contact_sections`
--

CREATE TABLE `contact_sections` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone_one` varchar(255) DEFAULT NULL,
  `phone_two` varchar(255) DEFAULT NULL,
  `email_one` varchar(255) DEFAULT NULL,
  `email_two` varchar(255) DEFAULT NULL,
  `map` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `counter_sections`
--

CREATE TABLE `counter_sections` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `total_student_count` int(11) DEFAULT NULL,
  `total_instructor_count` int(11) DEFAULT NULL,
  `total_courses_count` int(11) DEFAULT NULL,
  `total_awards_count` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `counter_section_translations`
--

CREATE TABLE `counter_section_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `counter_section_id` bigint(20) UNSIGNED NOT NULL,
  `lang_code` varchar(255) NOT NULL,
  `section_title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE `countries` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `author_id` int(11) NOT NULL DEFAULT 0,
  `coupon_code` varchar(255) NOT NULL,
  `offer_percentage` decimal(8,2) NOT NULL,
  `expired_date` varchar(255) NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `min_price` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `coupon_histories`
--

CREATE TABLE `coupon_histories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `author_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `coupon_code` varchar(255) NOT NULL,
  `coupon_id` int(11) NOT NULL,
  `discount_amount` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `instructor_id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `type` enum('course','webinar') NOT NULL DEFAULT 'course',
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `seo_description` varchar(255) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `timezone` varchar(255) DEFAULT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `demo_video_storage` enum('upload','youtube','vimeo','external_link','aws') NOT NULL DEFAULT 'upload',
  `demo_video_source` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  `price` double NOT NULL DEFAULT 0,
  `affiliate_commission_percentage` decimal(5,2) NOT NULL DEFAULT 0.00,
  `discount` double DEFAULT NULL,
  `certificate` tinyint(1) NOT NULL DEFAULT 0,
  `downloadable` tinyint(1) NOT NULL DEFAULT 0,
  `partner_instructor` tinyint(1) NOT NULL DEFAULT 0,
  `qna` tinyint(1) NOT NULL DEFAULT 0,
  `message_for_reviewer` text DEFAULT NULL,
  `status` enum('active','is_draft','inactive') NOT NULL DEFAULT 'is_draft',
  `is_approved` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`id`, `instructor_id`, `category_id`, `type`, `title`, `slug`, `seo_description`, `start_date`, `duration`, `timezone`, `thumbnail`, `demo_video_storage`, `demo_video_source`, `description`, `capacity`, `price`, `affiliate_commission_percentage`, `discount`, `certificate`, `downloadable`, `partner_instructor`, `qna`, `message_for_reviewer`, `status`, `is_approved`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1001, 2, 'course', 'Bangla', 'bangla', 'New Bangla course for all students', '2025-05-05', 1200, NULL, '/uploads/store/photos/1001/fa149ed7-088d-4ba5-9389-158986952515.jpg', 'upload', NULL, '<p>dfgdfg dfgdegsdfg</p>', 50, 100, 3.00, 10, 1, 0, 0, 1, 'Please Rate us', 'active', 'approved', '2025-05-27 16:38:22', '2025-06-20 15:58:56', NULL),
(2, 1001, 2, 'course', 'ENglish', 'english', NULL, NULL, 1200, NULL, '/uploads/store/photos/1001/ChatGPT Image Jun 9, 2025, 08_22_42 PM.png', 'youtube', 'https://www.youtube.com/watch?v=rnRgEIyiES8', '<p>a fs dsf sdf</p>', 100, 120, 5.00, 10, 1, 0, 0, 1, 'dfgdf', 'active', 'approved', '2025-06-21 12:38:10', '2025-06-21 12:52:44', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `course_categories`
--

CREATE TABLE `course_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `show_at_trending` tinyint(1) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course_categories`
--

INSERT INTO `course_categories` (`id`, `slug`, `order`, `icon`, `parent_id`, `show_at_trending`, `status`, `created_at`, `updated_at`) VALUES
(2, 'language-english', NULL, 'uploads/custom-images/wsus-img-2025-05-27-10-45-24-1489.jpg', 3, 1, 1, '2025-05-27 16:45:24', '2025-05-27 16:45:24'),
(3, 'math', NULL, 'uploads/custom-images/wsus-img-2025-05-27-10-48-27-9963.jpg', NULL, 0, 1, '2025-05-27 16:48:27', '2025-05-27 16:48:27');

-- --------------------------------------------------------

--
-- Table structure for table `course_category_translations`
--

CREATE TABLE `course_category_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `course_category_id` bigint(20) UNSIGNED NOT NULL,
  `lang_code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course_category_translations`
--

INSERT INTO `course_category_translations` (`id`, `course_category_id`, `lang_code`, `name`, `created_at`, `updated_at`) VALUES
(1, 1, 'en', 'Language', '2025-05-27 16:40:02', '2025-05-27 16:40:02'),
(2, 1, 'bn', 'Language', '2025-05-27 16:40:02', '2025-05-27 16:40:02'),
(3, 1, 'hi', 'Language', '2025-05-27 16:40:02', '2025-05-27 16:40:02'),
(4, 2, 'en', 'Language English', '2025-05-27 16:45:24', '2025-05-27 16:45:24'),
(5, 2, 'bn', 'Language English', '2025-05-27 16:45:24', '2025-05-27 16:45:24'),
(6, 2, 'hi', 'Language English', '2025-05-27 16:45:24', '2025-05-27 16:45:24'),
(7, 3, 'en', 'Math', '2025-05-27 16:48:27', '2025-05-27 16:48:27'),
(8, 3, 'bn', 'Math', '2025-05-27 16:48:27', '2025-05-27 16:48:27'),
(9, 3, 'hi', 'Math', '2025-05-27 16:48:27', '2025-05-27 16:48:27');

-- --------------------------------------------------------

--
-- Table structure for table `course_chapters`
--

CREATE TABLE `course_chapters` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `instructor_id` bigint(20) UNSIGNED NOT NULL,
  `course_id` bigint(20) UNSIGNED NOT NULL,
  `order` int(11) NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course_chapters`
--

INSERT INTO `course_chapters` (`id`, `title`, `instructor_id`, `course_id`, `order`, `status`, `created_at`, `updated_at`) VALUES
(1, '1st Chapter', 1001, 1, 1, 'active', '2025-05-27 17:06:25', '2025-05-27 17:06:25'),
(2, '1st Chapter', 1001, 1, 2, 'active', '2025-05-27 17:06:29', '2025-05-27 17:06:29'),
(3, '1st Chapter', 1001, 2, 1, 'active', '2025-06-21 12:39:06', '2025-06-21 12:39:06');

-- --------------------------------------------------------

--
-- Table structure for table `course_chapter_items`
--

CREATE TABLE `course_chapter_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `instructor_id` bigint(20) UNSIGNED NOT NULL,
  `chapter_id` bigint(20) UNSIGNED NOT NULL,
  `type` enum('lesson','document','quiz','live') NOT NULL DEFAULT 'lesson',
  `order` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course_chapter_items`
--

INSERT INTO `course_chapter_items` (`id`, `instructor_id`, `chapter_id`, `type`, `order`, `created_at`, `updated_at`) VALUES
(1, 1001, 2, 'quiz', 1, '2025-05-27 17:37:52', '2025-05-27 17:37:52'),
(2, 1001, 1, 'quiz', 2, '2025-06-16 03:16:18', '2025-06-16 03:45:59'),
(3, 1001, 1, 'lesson', 1, '2025-06-16 03:45:27', '2025-06-16 03:45:59'),
(4, 1001, 2, 'quiz', 2, '2025-06-16 04:39:15', '2025-06-16 04:39:15'),
(5, 1001, 3, 'lesson', 1, '2025-06-21 12:39:44', '2025-06-21 12:39:44'),
(6, 1001, 3, 'quiz', 2, '2025-06-21 12:40:22', '2025-06-21 12:40:22');

-- --------------------------------------------------------

--
-- Table structure for table `course_chapter_lessons`
--

CREATE TABLE `course_chapter_lessons` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `instructor_id` bigint(20) UNSIGNED NOT NULL,
  `course_id` bigint(20) UNSIGNED NOT NULL,
  `chapter_id` bigint(20) UNSIGNED NOT NULL,
  `chapter_item_id` bigint(20) UNSIGNED NOT NULL,
  `file_path` text DEFAULT NULL,
  `storage` enum('upload','youtube','vimeo','external_link','google_drive','iframe','aws') NOT NULL DEFAULT 'upload',
  `volume` varchar(255) DEFAULT NULL,
  `duration` varchar(255) DEFAULT NULL,
  `file_type` enum('video','audio','pdf','txt','docx','iframe','image','file','other') NOT NULL DEFAULT 'video',
  `downloadable` tinyint(1) NOT NULL DEFAULT 1,
  `order` int(11) DEFAULT NULL,
  `is_free` tinyint(1) DEFAULT 0,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course_chapter_lessons`
--

INSERT INTO `course_chapter_lessons` (`id`, `title`, `slug`, `description`, `instructor_id`, `course_id`, `chapter_id`, `chapter_item_id`, `file_path`, `storage`, `volume`, `duration`, `file_type`, `downloadable`, `order`, `is_free`, `status`, `created_at`, `updated_at`) VALUES
(1, 'sfsdfs', NULL, 'xsczxczxczxc', 1001, 1, 1, 3, 'https://www.youtube.com/watch?v=857x4fYWN4Y', 'youtube', NULL, '5', 'video', 1, NULL, 1, 'active', '2025-06-16 03:45:27', '2025-06-16 03:45:27'),
(2, 'Lession', NULL, 'adasd', 1001, 2, 3, 5, 'https://www.youtube.com/watch?v=rnRgEIyiES8', 'youtube', NULL, '120', 'video', 1, NULL, 1, 'active', '2025-06-21 12:39:44', '2025-06-21 12:39:44');

-- --------------------------------------------------------

--
-- Table structure for table `course_delete_requests`
--

CREATE TABLE `course_delete_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `course_id` bigint(20) UNSIGNED NOT NULL,
  `message` text NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `course_languages`
--

CREATE TABLE `course_languages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course_languages`
--

INSERT INTO `course_languages` (`id`, `name`, `status`, `created_at`, `updated_at`) VALUES
(1, 'English', 1, '2025-05-27 16:45:50', '2025-05-27 16:45:50');

-- --------------------------------------------------------

--
-- Table structure for table `course_levels`
--

CREATE TABLE `course_levels` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `slug` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course_levels`
--

INSERT INTO `course_levels` (`id`, `slug`, `status`, `created_at`, `updated_at`) VALUES
(1, 'primary', 1, '2025-05-27 16:40:50', '2025-05-27 16:40:50');

-- --------------------------------------------------------

--
-- Table structure for table `course_level_translations`
--

CREATE TABLE `course_level_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `course_level_id` bigint(20) UNSIGNED NOT NULL,
  `lang_code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course_level_translations`
--

INSERT INTO `course_level_translations` (`id`, `course_level_id`, `lang_code`, `name`, `created_at`, `updated_at`) VALUES
(1, 1, 'en', 'Primary', '2025-05-27 16:40:50', '2025-05-27 16:40:50'),
(2, 1, 'bn', 'Primary', '2025-05-27 16:40:50', '2025-05-27 16:40:50'),
(3, 1, 'hi', 'Primary', '2025-05-27 16:40:50', '2025-05-27 16:40:50');

-- --------------------------------------------------------

--
-- Table structure for table `course_live_classes`
--

CREATE TABLE `course_live_classes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `lesson_id` bigint(20) UNSIGNED NOT NULL,
  `start_time` varchar(255) DEFAULT NULL,
  `type` enum('zoom','jitsi') NOT NULL DEFAULT 'zoom',
  `meeting_id` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `join_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `course_partner_instructors`
--

CREATE TABLE `course_partner_instructors` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `course_id` bigint(20) UNSIGNED NOT NULL,
  `instructor_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `course_progress`
--

CREATE TABLE `course_progress` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `course_id` bigint(20) UNSIGNED DEFAULT NULL,
  `chapter_id` bigint(20) UNSIGNED DEFAULT NULL,
  `lesson_id` bigint(20) UNSIGNED DEFAULT NULL,
  `watched` tinyint(1) NOT NULL DEFAULT 0,
  `current` tinyint(1) NOT NULL DEFAULT 0,
  `type` enum('lesson','quiz','document','live') NOT NULL DEFAULT 'lesson',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course_progress`
--

INSERT INTO `course_progress` (`id`, `user_id`, `course_id`, `chapter_id`, `lesson_id`, `watched`, `current`, `type`, `created_at`, `updated_at`) VALUES
(1, 1002, 1, 1, 2, 0, 1, 'quiz', '2025-06-16 03:42:44', '2025-06-16 12:30:54'),
(2, 1002, 1, 1, 1, 0, 0, 'lesson', '2025-06-16 03:46:25', '2025-06-16 12:30:54'),
(3, 1002, 1, 2, 1, 0, 0, 'quiz', '2025-06-16 03:48:52', '2025-06-16 12:30:54');

-- --------------------------------------------------------

--
-- Table structure for table `course_reviews`
--

CREATE TABLE `course_reviews` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `course_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `rating` int(11) NOT NULL,
  `review` text NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course_reviews`
--

INSERT INTO `course_reviews` (`id`, `course_id`, `user_id`, `rating`, `review`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 1002, 5, 'Good', 1, '2025-06-16 03:47:41', '2025-06-21 12:52:11');

-- --------------------------------------------------------

--
-- Table structure for table `course_selected_filter_options`
--

CREATE TABLE `course_selected_filter_options` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `course_id` bigint(20) UNSIGNED NOT NULL,
  `filter_id` bigint(20) UNSIGNED NOT NULL,
  `filter_option_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `course_selected_languages`
--

CREATE TABLE `course_selected_languages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `course_id` bigint(20) UNSIGNED NOT NULL,
  `language_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course_selected_languages`
--

INSERT INTO `course_selected_languages` (`id`, `course_id`, `language_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2025-05-27 17:04:01', '2025-05-27 17:04:01'),
(2, 2, 1, '2025-06-21 12:38:48', '2025-06-21 12:38:48');

-- --------------------------------------------------------

--
-- Table structure for table `course_selected_levels`
--

CREATE TABLE `course_selected_levels` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `course_id` bigint(20) UNSIGNED NOT NULL,
  `level_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course_selected_levels`
--

INSERT INTO `course_selected_levels` (`id`, `course_id`, `level_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2025-05-27 17:04:01', '2025-05-27 17:04:01'),
(2, 2, 1, '2025-06-21 12:38:48', '2025-06-21 12:38:48');

-- --------------------------------------------------------

--
-- Table structure for table `custom_codes`
--

CREATE TABLE `custom_codes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `css` text DEFAULT NULL,
  `javascript` text DEFAULT NULL,
  `header_javascript` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `custom_pages`
--

CREATE TABLE `custom_pages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `slug` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `custom_page_translations`
--

CREATE TABLE `custom_page_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `custom_page_id` bigint(20) UNSIGNED NOT NULL,
  `lang_code` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `custom_paginations`
--

CREATE TABLE `custom_paginations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `section_name` varchar(255) NOT NULL,
  `item_qty` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `custom_paginations`
--

INSERT INTO `custom_paginations` (`id`, `section_name`, `item_qty`, `created_at`, `updated_at`) VALUES
(1, 'Blog List', 10, '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(2, 'Blog Comment', 10, '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(3, 'Media List', 10, '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(4, 'Language List', 50, '2025-05-12 13:37:57', '2025-05-12 13:37:57');

-- --------------------------------------------------------

--
-- Table structure for table `email_templates`
--

CREATE TABLE `email_templates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `message` longtext NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `email_templates`
--

INSERT INTO `email_templates` (`id`, `name`, `subject`, `message`, `created_at`, `updated_at`) VALUES
(1, 'password_reset', 'Password Reset', '<p>Dear {{user_name}},</p>\n                <p>Do you want to reset your password? Please Click the following link and Reset Your Password.</p>', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(2, 'contact_mail', 'Contact Email', '<p>Hello there,</p>\n                <p>&nbsp;Mr. {{name}} has sent a new message. you can see the message details below.&nbsp;</p>\n                <p>Email: {{email}}</p>\n                <p>Phone: {{phone}}</p>\n                <p>Subject: {{subject}}</p>\n                <p>Message: {{message}}</p>', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(3, 'subscribe_notification', 'Subscribe Notification', '<p>Hi there, Congratulations! Your Subscription has been created successfully. Please Click the following link and Verified Your Subscription. If you will not approve this link, you can not get any newsletter from us.</p>', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(4, 'user_verification', 'User Verification', '<p>Dear {{user_name}},</p>\n                <p>Congratulations! Your Account has been created successfully. Please Click the following link and Active your Account.</p>', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(5, 'approved_refund', 'Refund Request Approval', '<p>Dear {{user_name}},</p>\n                <p>We are happy to say that, we have send {{refund_amount}} USD to your provided bank information. </p>', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(6, 'new_refund', 'New Refund Request', '<p>Hello websolutionus, </p>\n\n                <p>Mr. {{user_name}} has send a new refund request to you.</p>', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(7, 'pending_wallet_payment', 'Wallet Payment Approval', '<p>Hello {{user_name}},</p>\n                <p>We have received your wallet payment request. we find your payment to our bank account.</p>\n                <p>Thanks &amp; Regards</p>', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(8, 'approved_withdraw', 'Withdraw Request Approval', '<p>Dear {{user_name}},</p>\n                <p>We are happy to say that, we have send a withdraw amount to your provided bank information.</p>\n                <p>Thanks &amp; Regards</p>\n                <p>WebSolutionUs</p>', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(9, 'rejected_withdraw', 'Withdraw Request Rejected', '<p>Dear {{user_name}},</p>\n                <p> your withdraw request has been rejected.</p>\n                <p>Thanks &amp; Regards</p>\n                <p>WebSolutionUs</p>', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(10, 'pending_withdraw', 'Withdraw Request Pending', '<p>Dear {{user_name}},</p>\n                <p> your withdraw request is waiting for approval.</p>\n                <p>Thanks &amp; Regards</p>\n                <p>WebSolutionUs</p>', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(11, 'instructor_request_approved', 'Instructor Request Approval', '<p>Dear {{user_name}},</p>\n                <p>you are now approved as an instructor.</p>', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(12, 'instructor_request_rejected', 'Instructor Request Rejected', '<p>Dear {{user_name}},</p>\n                <p>your request has been rejected. please resubmit your request with proper document. or contact us.</p>', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(13, 'instructor_request_pending', 'Instructor Request is waiting for approval', '<p>Dear {{user_name}},</p>\n                <p>your request for become an instructor is waiting for approval. please wait. we will send you an email when your request is approved.</p>', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(14, 'instructor_quick_contact', 'Mail for instructor contact form', '<p>Name: {{name}}</p>\n                <p>Email: {{email}}</p>\n                <p>Subject: {{subject}}</p>\n                <p>{{message}}</p>', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(15, 'order_completed', 'Your order has been placed', '<p>HI, {{name}}</p>\n                <p>product id: {{order_id}}</p>\n                <p>paid amount: {{paid_amount}}</p>\n                <p>payment method: {{payment_method}}</p>', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(16, 'qna_reply_mail', 'QNA Replay mail', '<p>Hi {{user_name}}, your instructor has replied to your question. Please see the answer below:</p><p>Course: {{course}}</p><p>Lesson: {{lesson}}</p><p>Question: {{question}}</p>', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(17, 'live_class_mail', 'Live class notification mail', '<p>Hi {{user_name}},</p>\n                <p>Your live class is starting at {{start_time}}. Please see the details below:</p>\n                <p><strong>Course:</strong> {{course}}</p>\n                <p><strong>Lesson:</strong> {{lesson}}</p>\n                <p><strong>Meeting Link:</strong> <a href=\"{{join_url}}\">{{join_url}}</a></p>', '2025-05-12 13:37:57', '2025-05-12 13:37:57');

-- --------------------------------------------------------

--
-- Table structure for table `enrollments`
--

CREATE TABLE `enrollments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `course_id` bigint(20) UNSIGNED NOT NULL,
  `has_access` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `enrollments`
--

INSERT INTO `enrollments` (`id`, `order_id`, `user_id`, `course_id`, `has_access`, `created_at`, `updated_at`) VALUES
(1, 1, 1002, 1, 1, '2025-06-16 03:42:06', '2025-06-16 03:42:06'),
(6, 11, 1002, 2, 1, '2025-06-21 14:37:12', '2025-06-21 14:37:12');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `faqs`
--

CREATE TABLE `faqs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `faq_sections`
--

CREATE TABLE `faq_sections` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `faq_sections`
--

INSERT INTO `faq_sections` (`id`, `image`, `created_at`, `updated_at`) VALUES
(1, NULL, '2025-05-12 13:38:00', '2025-05-12 13:38:00');

-- --------------------------------------------------------

--
-- Table structure for table `faq_section_translations`
--

CREATE TABLE `faq_section_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `faq_section_id` bigint(20) UNSIGNED NOT NULL DEFAULT 1,
  `lang_code` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `sub_title` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `faq_translations`
--

CREATE TABLE `faq_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `faq_id` bigint(20) UNSIGNED NOT NULL,
  `lang_code` varchar(255) NOT NULL,
  `question` varchar(255) DEFAULT NULL,
  `answer` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `featured_course_sections`
--

CREATE TABLE `featured_course_sections` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `all_category` int(11) DEFAULT NULL,
  `all_category_ids` text DEFAULT NULL,
  `all_category_status` tinyint(1) NOT NULL DEFAULT 1,
  `category_one` int(11) DEFAULT NULL,
  `category_one_ids` text DEFAULT NULL,
  `category_one_status` tinyint(1) NOT NULL DEFAULT 1,
  `category_two` int(11) DEFAULT NULL,
  `category_two_ids` text DEFAULT NULL,
  `category_two_status` tinyint(1) NOT NULL DEFAULT 1,
  `category_three` int(11) DEFAULT NULL,
  `category_three_ids` text DEFAULT NULL,
  `category_three_status` tinyint(1) NOT NULL DEFAULT 1,
  `category_four` int(11) DEFAULT NULL,
  `category_four_ids` text DEFAULT NULL,
  `category_four_status` tinyint(1) NOT NULL DEFAULT 1,
  `category_five` int(11) DEFAULT NULL,
  `category_five_ids` text DEFAULT NULL,
  `category_five_status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `featured_instructors`
--

CREATE TABLE `featured_instructors` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `button_url` varchar(255) DEFAULT NULL,
  `instructor_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`instructor_ids`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `featured_instructors`
--

INSERT INTO `featured_instructors` (`id`, `button_url`, `instructor_ids`, `created_at`, `updated_at`) VALUES
(1, NULL, NULL, '2025-05-12 13:38:00', '2025-05-12 13:38:00');

-- --------------------------------------------------------

--
-- Table structure for table `featured_instructor_translations`
--

CREATE TABLE `featured_instructor_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `featured_instructor_section_id` bigint(20) UNSIGNED NOT NULL DEFAULT 1,
  `lang_code` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `sub_title` varchar(255) DEFAULT NULL,
  `button_text` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `footer_settings`
--

CREATE TABLE `footer_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `footer_text` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `get_in_touch_text` varchar(255) DEFAULT NULL,
  `google_play_link` varchar(255) DEFAULT NULL,
  `apple_store_link` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hero_sections`
--

CREATE TABLE `hero_sections` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `action_button_url` text DEFAULT NULL,
  `video_button_url` text DEFAULT NULL,
  `banner_image` varchar(255) DEFAULT NULL,
  `banner_background` varchar(255) DEFAULT NULL,
  `hero_background` varchar(255) DEFAULT NULL,
  `enroll_students_image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hero_sections`
--

INSERT INTO `hero_sections` (`id`, `action_button_url`, `video_button_url`, `banner_image`, `banner_background`, `hero_background`, `enroll_students_image`, `created_at`, `updated_at`) VALUES
(1, '#', '#', 'uploads/custom-images/wsus-img-2025-06-23-01-01-29-7038.png', 'uploads/custom-images/wsus-img-2025-06-23-01-01-29-5660.png', 'uploads/custom-images/wsus-img-2025-06-23-01-01-29-4526.png', 'uploads/custom-images/wsus-img-2025-06-23-01-01-29-5519.png', '2025-05-12 13:38:00', '2025-06-22 19:01:29');

-- --------------------------------------------------------

--
-- Table structure for table `hero_section_translations`
--

CREATE TABLE `hero_section_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `hero_section_id` bigint(20) UNSIGNED NOT NULL,
  `lang_code` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `sub_title` varchar(255) NOT NULL,
  `action_button_text` varchar(255) DEFAULT NULL,
  `video_button_text` varchar(255) DEFAULT NULL,
  `total_student` varchar(255) DEFAULT NULL,
  `total_instructor` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hero_section_translations`
--

INSERT INTO `hero_section_translations` (`id`, `hero_section_id`, `lang_code`, `title`, `sub_title`, `action_button_text`, `video_button_text`, `total_student`, `total_instructor`, `created_at`, `updated_at`) VALUES
(1, 1, 'en', 'ToLearnTeam', 'ToLearnTeam', NULL, NULL, NULL, NULL, '2025-05-12 14:58:46', '2025-05-12 14:58:46'),
(2, 1, 'bn', 'ToLearnTeam', 'ToLearnTeam', NULL, NULL, NULL, NULL, '2025-05-12 14:58:46', '2025-05-12 14:58:46'),
(3, 1, 'hi', 'ToLearnTeam', 'ToLearnTeam', NULL, NULL, NULL, NULL, '2025-05-12 14:58:46', '2025-05-12 14:58:46');

-- --------------------------------------------------------

--
-- Table structure for table `instructor_requests`
--

CREATE TABLE `instructor_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `certificate` text DEFAULT NULL,
  `identity_scan` text DEFAULT NULL,
  `payout_account` varchar(255) DEFAULT NULL,
  `payout_information` text DEFAULT NULL,
  `extra_information` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `instructor_requests`
--

INSERT INTO `instructor_requests` (`id`, `user_id`, `status`, `certificate`, `identity_scan`, `payout_account`, `payout_information`, `extra_information`, `created_at`, `updated_at`) VALUES
(1, 1001, 'approved', NULL, NULL, 'bKash', 'sdfsdfsdf', 'sdfsdfs', '2025-05-27 16:35:21', '2025-05-27 16:36:05');

-- --------------------------------------------------------

--
-- Table structure for table `instructor_request_settings`
--

CREATE TABLE `instructor_request_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `need_certificate` tinyint(1) NOT NULL DEFAULT 1,
  `need_identity_scan` tinyint(1) NOT NULL DEFAULT 1,
  `bank_information` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `instructor_request_setting_translations`
--

CREATE TABLE `instructor_request_setting_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `instructor_request_setting_id` bigint(20) UNSIGNED NOT NULL,
  `lang_code` varchar(255) NOT NULL,
  `instructions` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jitsi_settings`
--

CREATE TABLE `jitsi_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `instructor_id` bigint(20) UNSIGNED NOT NULL,
  `api_key` varchar(255) NOT NULL,
  `app_id` varchar(255) NOT NULL,
  `permissions` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `direction` varchar(255) NOT NULL DEFAULT 'ltr',
  `status` varchar(255) NOT NULL DEFAULT '1',
  `is_default` varchar(255) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `name`, `code`, `icon`, `direction`, `status`, `is_default`, `created_at`, `updated_at`) VALUES
(1, 'English', 'en', NULL, 'ltr', '1', '1', '2025-05-12 13:37:56', '2025-05-12 14:52:34'),
(4, 'Bangla', 'bn', NULL, 'ltr', '1', '0', '2025-05-12 14:52:06', '2025-05-12 14:52:18'),
(5, 'Hindi', 'hi', NULL, 'ltr', '1', '0', '2025-05-12 14:55:42', '2025-05-12 14:55:42');

-- --------------------------------------------------------

--
-- Table structure for table `lesson_questions`
--

CREATE TABLE `lesson_questions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `course_id` bigint(20) UNSIGNED NOT NULL,
  `lesson_id` bigint(20) UNSIGNED NOT NULL,
  `question_title` varchar(255) NOT NULL,
  `question_description` text NOT NULL,
  `seen` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lesson_replies`
--

CREATE TABLE `lesson_replies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `question_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `reply` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `marketing_settings`
--

CREATE TABLE `marketing_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `marketing_settings`
--

INSERT INTO `marketing_settings` (`id`, `key`, `value`, `created_at`, `updated_at`) VALUES
(1, 'register', '1', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(2, 'course_details', '1', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(3, 'add_to_cart', '1', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(4, 'remove_from_cart', '1', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(5, 'checkout', '1', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(6, 'order_success', '1', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(7, 'order_failed', '1', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(8, 'contact_page', '1', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(9, 'instructor_contact', '1', '2025-05-12 13:37:56', '2025-05-12 13:37:56');

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`id`, `name`, `slug`, `created_at`, `updated_at`) VALUES
(9, 'Nav Menu', 'nav-menu', '2024-05-23 06:10:20', '2025-06-22 18:55:38'),
(10, 'footer_col_one', 'footer-col-one', '2024-05-26 00:25:04', '2024-05-26 00:25:04'),
(13, 'footer_col_two', 'footer-col-two-1PiTN', '2024-05-26 00:25:37', '2024-05-26 00:25:37'),
(14, 'footer_col_three', 'footer-col-three', '2024-05-26 00:32:09', '2024-05-26 00:32:09');

-- --------------------------------------------------------

--
-- Table structure for table `menu_items`
--

CREATE TABLE `menu_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `label` varchar(255) NOT NULL,
  `link` varchar(255) NOT NULL,
  `parent_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `sort` int(11) NOT NULL DEFAULT 0,
  `class` varchar(255) DEFAULT NULL,
  `menu_id` bigint(20) UNSIGNED NOT NULL,
  `depth` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `role_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu_items`
--

INSERT INTO `menu_items` (`id`, `label`, `link`, `parent_id`, `sort`, `class`, `menu_id`, `depth`, `created_at`, `updated_at`, `role_id`) VALUES
(1, 'Instructors', '/all-instructors', 0, 1, NULL, 9, 0, '2025-06-22 18:55:38', '2025-06-22 18:55:58', 0),
(2, 'Home', '/', 0, 0, NULL, 9, 0, '2025-06-22 18:55:52', '2025-06-22 18:55:58', 0),
(3, 'Blog', '/blog', 0, 2, NULL, 9, 0, '2025-06-22 18:56:02', '2025-06-22 18:56:02', 0),
(4, 'About Us', '/about-us', 0, 3, NULL, 9, 0, '2025-06-22 18:56:10', '2025-06-22 18:56:10', 0),
(5, 'Contact', '/contact', 0, 4, NULL, 9, 0, '2025-06-22 18:56:17', '2025-06-22 18:56:17', 0);

-- --------------------------------------------------------

--
-- Table structure for table `menu_item_translations`
--

CREATE TABLE `menu_item_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `menu_item_id` bigint(20) UNSIGNED NOT NULL,
  `lang_code` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu_item_translations`
--

INSERT INTO `menu_item_translations` (`id`, `menu_item_id`, `lang_code`, `label`, `created_at`, `updated_at`) VALUES
(1, 1, 'en', 'Instructors', '2025-06-22 18:55:38', '2025-06-22 18:55:38'),
(2, 1, 'bn', 'Instructors', '2025-06-22 18:55:38', '2025-06-22 18:55:38'),
(3, 1, 'hi', 'Instructors', '2025-06-22 18:55:38', '2025-06-22 18:55:38'),
(4, 2, 'en', 'Home', '2025-06-22 18:55:52', '2025-06-22 18:55:52'),
(5, 2, 'bn', 'Home', '2025-06-22 18:55:52', '2025-06-22 18:55:52'),
(6, 2, 'hi', 'Home', '2025-06-22 18:55:52', '2025-06-22 18:55:52'),
(7, 3, 'en', 'Blog', '2025-06-22 18:56:02', '2025-06-22 18:56:02'),
(8, 3, 'bn', 'Blog', '2025-06-22 18:56:02', '2025-06-22 18:56:02'),
(9, 3, 'hi', 'Blog', '2025-06-22 18:56:02', '2025-06-22 18:56:02'),
(10, 4, 'en', 'About Us', '2025-06-22 18:56:10', '2025-06-22 18:56:10'),
(11, 4, 'bn', 'About Us', '2025-06-22 18:56:10', '2025-06-22 18:56:10'),
(12, 4, 'hi', 'About Us', '2025-06-22 18:56:10', '2025-06-22 18:56:10'),
(13, 5, 'en', 'Contact', '2025-06-22 18:56:17', '2025-06-22 18:56:17'),
(14, 5, 'bn', 'Contact', '2025-06-22 18:56:17', '2025-06-22 18:56:17'),
(15, 5, 'hi', 'Contact', '2025-06-22 18:56:17', '2025-06-22 18:56:17');

-- --------------------------------------------------------

--
-- Table structure for table `menu_translations`
--

CREATE TABLE `menu_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `menu_id` bigint(20) UNSIGNED NOT NULL,
  `lang_code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu_translations`
--

INSERT INTO `menu_translations` (`id`, `menu_id`, `lang_code`, `name`, `created_at`, `updated_at`) VALUES
(7, 9, 'en', 'Nav Menu', '2024-05-23 06:10:20', '2025-06-22 18:55:38'),
(9, 10, 'en', 'footer_col_one', '2024-05-26 00:25:04', '2024-05-26 00:25:04'),
(15, 13, 'en', 'footer_col_two', '2024-05-26 00:25:37', '2024-05-26 00:25:37'),
(17, 14, 'en', 'footer_col_three', '2024-05-26 00:32:09', '2024-05-26 00:32:09'),
(23, 9, 'bn', 'nav_menu', '2024-05-31 11:14:54', '2024-05-31 11:14:54'),
(24, 10, 'bn', 'footer_col_one', '2024-05-31 11:14:54', '2024-05-31 11:14:54'),
(25, 13, 'bn', 'footer_col_two', '2024-05-31 11:14:54', '2024-05-31 11:14:54'),
(26, 14, 'bn', 'footer_col_three', '2024-05-31 11:14:54', '2024-05-31 11:14:54'),
(31, 9, 'bn', 'nav_menu', '2025-05-12 14:52:06', '2025-05-12 14:52:06'),
(32, 10, 'bn', 'footer_col_one', '2025-05-12 14:52:06', '2025-05-12 14:52:06'),
(33, 13, 'bn', 'footer_col_two', '2025-05-12 14:52:06', '2025-05-12 14:52:06'),
(34, 14, 'bn', 'footer_col_three', '2025-05-12 14:52:06', '2025-05-12 14:52:06'),
(35, 9, 'hi', 'nav_menu', '2025-05-12 14:55:42', '2025-05-12 14:55:42'),
(36, 10, 'hi', 'footer_col_one', '2025-05-12 14:55:42', '2025-05-12 14:55:42'),
(37, 13, 'hi', 'footer_col_two', '2025-05-12 14:55:42', '2025-05-12 14:55:42'),
(38, 14, 'hi', 'footer_col_three', '2025-05-12 14:55:42', '2025-05-12 14:55:42');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2023_11_05_045432_create_admins_table', 1),
(6, '2023_11_05_114814_create_languages_table', 1),
(7, '2023_11_06_043247_create_settings_table', 1),
(8, '2023_11_06_054251_create_seo_settings_table', 1),
(9, '2023_11_06_094842_create_custom_paginations_table', 1),
(10, '2023_11_06_115856_create_email_templates_table', 1),
(11, '2023_11_07_051924_create_multi_currencies_table', 1),
(12, '2023_11_07_103108_create_basic_payments_table', 1),
(13, '2023_11_07_104315_create_blog_categories_table', 1),
(14, '2023_11_07_104328_create_blog_category_translations_table', 1),
(15, '2023_11_07_104336_create_blogs_table', 1),
(16, '2023_11_07_104343_create_blog_translations_table', 1),
(17, '2023_11_07_104546_create_blog_comments_table', 1),
(18, '2023_11_09_035236_create_payment_gateways_table', 1),
(19, '2023_11_09_100621_create_jobs_table', 1),
(20, '2023_11_16_035458_add_user_info_to_users', 1),
(21, '2023_11_16_061508_add_forget_info_to_users', 1),
(22, '2023_11_16_063639_add_phone_to_users', 1),
(23, '2023_11_19_055229_add_image_to_users', 1),
(24, '2023_11_19_064341_create_banned_histories_table', 1),
(25, '2023_11_21_043030_create_news_letters_table', 1),
(26, '2023_11_21_094702_create_contact_messages_table', 1),
(27, '2023_11_22_105539_create_permission_tables', 1),
(28, '2023_11_29_055540_create_orders_table', 1),
(29, '2023_11_29_095126_create_coupons_table', 1),
(30, '2023_11_29_104658_create_testimonials_table', 1),
(31, '2023_11_29_104704_create_testimonial_translations_table', 1),
(32, '2023_11_29_105234_create_coupon_histories_table', 1),
(33, '2023_11_29_113632_add_min_price_to_coupon', 1),
(34, '2023_11_30_044838_create_faqs_table', 1),
(35, '2023_11_30_044844_create_faq_translations_table', 1),
(36, '2023_11_30_095404_add_wallet_balance_to_users', 1),
(37, '2023_12_04_071839_create_withraw_methods_table', 1),
(38, '2023_12_04_095319_create_withdraw_requests_table', 1),
(39, '2024_01_01_054644_create_socialite_credentials_table', 1),
(40, '2024_01_03_092007_create_custom_codes_table', 1),
(41, '2024_02_10_060044_create_configurations_table', 1),
(42, '2024_02_28_064128_add_forgot_info_to_admins', 1),
(43, '2024_03_28_095207_create_menus_wp_table', 1),
(44, '2024_03_28_095208_create_menu_translations_table', 1),
(45, '2024_03_28_095209_create_menu_items_wp_table', 1),
(46, '2024_03_28_095210_create_menu_item_translations_table', 1),
(47, '2024_03_28_095211_add-role-id-to-menu-items-table', 1),
(48, '2024_04_03_042331_add_new_columns_to_users', 1),
(49, '2024_04_03_044043_create_user_education_table', 1),
(50, '2024_04_03_044103_create_user_experiences_table', 1),
(51, '2024_04_03_044134_create_user_skill_topics_table', 1),
(52, '2024_04_05_060046_create_countries_table', 1),
(53, '2024_04_05_060133_create_states_table', 1),
(54, '2024_04_05_060149_create_cities_table', 1),
(55, '2024_04_08_041719_create_instructor_requests_table', 1),
(56, '2024_04_08_042513_create_instructor_request_settings_table', 1),
(57, '2024_04_15_103628_create_course_categories_table', 1),
(58, '2024_04_15_112656_create_course_category_translations_table', 1),
(59, '2024_04_18_031942_create_course_languages_table', 1),
(60, '2024_04_18_044110_create_course_levels_table', 1),
(61, '2024_04_18_044125_create_course_level_translations_table', 1),
(62, '2024_04_18_070749_create_courses_table', 1),
(63, '2024_04_21_093245_create_course_partner_instructors_table', 1),
(64, '2024_04_21_094654_create_course_selected_levels_table', 1),
(65, '2024_04_21_094841_create_course_selected_languages_table', 1),
(66, '2024_04_21_095342_create_course_selected_filter_options_table', 1),
(67, '2024_04_22_114039_create_course_chapters_table', 1),
(68, '2024_04_23_090340_create_course_chapter_items_table', 1),
(69, '2024_04_23_090700_create_course_chapter_lessons_table', 1),
(70, '2024_04_24_093046_create_quizzes_table', 1),
(71, '2024_04_24_114441_create_quiz_questions_table', 1),
(72, '2024_04_28_034905_create_quiz_question_answers_table', 1),
(73, '2024_05_06_094927_create_order_items_table', 1),
(74, '2024_05_06_094946_create_enrollments_table', 1),
(75, '2024_05_12_035535_create_course_progress_table', 1),
(76, '2024_05_13_041532_create_quiz_results_table', 1),
(77, '2024_05_13_101033_create_lesson_questions_table', 1),
(78, '2024_05_13_101258_create_lesson_replies_table', 1),
(79, '2024_05_14_095807_create_announcements_table', 1),
(80, '2024_05_14_114640_create_course_reviews_table', 1),
(81, '2024_05_16_034644_create_certificate_builders_table', 1),
(82, '2024_05_16_041919_create_certificate_builder_items_table', 1),
(83, '2024_05_16_110701_create_badges_table', 1),
(84, '2024_05_19_045947_create_hero_sections_table', 1),
(85, '2024_05_19_050000_create_hero_section_translations_table', 1),
(86, '2024_05_20_052819_create_brands_table', 1),
(87, '2024_05_20_063713_create_about_sections_table', 1),
(88, '2024_05_20_063844_create_about_section_translations_table', 1),
(89, '2024_05_20_094331_create_featured_course_sections_table', 1),
(90, '2024_05_21_050808_create_newsletter_sections_table', 1),
(91, '2024_05_21_060612_create_featured_instructors_table', 1),
(92, '2024_05_21_060634_create_featured_instructor_translations_table', 1),
(93, '2024_05_21_091423_create_counter_sections_table', 1),
(94, '2024_05_21_094646_create_faq_sections_table', 1),
(95, '2024_05_21_094700_create_faq_section_translations_table', 1),
(96, '2024_05_21_111253_create_our_features_sections_table', 1),
(97, '2024_05_21_111306_create_our_features_section_translations_table', 1),
(98, '2024_05_22_034753_create_banner_sections_table', 1),
(99, '2024_05_26_032547_create_section_settings_table', 1),
(100, '2024_05_26_052359_create_footer_settings_table', 1),
(101, '2024_05_26_065953_create_social_links_table', 1),
(102, '2024_05_26_164008_create_contact_sections_table', 1),
(103, '2024_05_27_045919_create_custom_pages_table', 1),
(104, '2024_05_27_050016_create_custom_page_translations_table', 1),
(105, '2024_06_02_045115_add_softdelete_to_courses_table', 1),
(106, '2024_06_02_080423_create_course_delete_requests_table', 1),
(107, '2024_09_01_042119_create_zoom_credentials_table', 1),
(108, '2024_09_01_042120_create_course_live_classes_table', 1),
(109, '2024_09_04_122554_create_jitsi_settings_table', 1),
(110, '2024_09_10_103347_create_marketing_settings_table', 1),
(111, '2024_09_28_042505_create_counter_section_translations_table', 1),
(112, '2024_09_29_090219_create_instructor_request_setting_translations_table', 1),
(113, '2025_06_16_180150_add_explanation_to_quiz_questions_table', 2),
(114, '2025_06_19_000605_create_affiliate_system_tables', 3),
(115, '2025_06_21_214105_create_withdrawal_tables', 4),
(116, '2025_06_21_214305_create_withdraw_requests', 4);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\Admin', 1),
(4, 'App\\Models\\Admin', 1),
(4, 'App\\Models\\Admin', 2);

-- --------------------------------------------------------

--
-- Table structure for table `multi_currencies`
--

CREATE TABLE `multi_currencies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `currency_name` varchar(255) NOT NULL,
  `country_code` varchar(255) NOT NULL,
  `currency_code` varchar(255) NOT NULL,
  `currency_icon` varchar(255) NOT NULL,
  `is_default` varchar(255) NOT NULL,
  `currency_rate` double(8,2) NOT NULL,
  `currency_position` varchar(255) NOT NULL DEFAULT 'before_price',
  `status` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `multi_currencies`
--

INSERT INTO `multi_currencies` (`id`, `currency_name`, `country_code`, `currency_code`, `currency_icon`, `is_default`, `currency_rate`, `currency_position`, `status`, `created_at`, `updated_at`) VALUES
(1, '$-USD', 'US', 'USD', '$', 'yes', 1.00, 'before_price', 'active', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(2, '₦-Naira', 'NG', 'NGN', '₦', 'no', 417.35, 'before_price', 'active', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(3, '₹-Rupee', 'IN', 'INR', '₹', 'no', 74.66, 'before_price', 'active', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(4, '₱-Peso', 'PH', 'PHP', '₱', 'no', 55.07, 'before_price', 'active', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(5, '$-CAD', 'CA', 'CAD', '$', 'no', 1.27, 'before_price', 'active', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(6, '৳-Taka', 'BD', 'BDT', '৳', 'no', 80.00, 'before_price', 'active', '2025-05-12 13:37:56', '2025-05-12 13:37:56');

-- --------------------------------------------------------

--
-- Table structure for table `newsletter_sections`
--

CREATE TABLE `newsletter_sections` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `news_letters`
--

CREATE TABLE `news_letters` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'not_verified',
  `verify_token` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `invoice_id` text DEFAULT NULL,
  `buyer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `seller_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` enum('pending','processing','completed','declined') NOT NULL DEFAULT 'pending',
  `has_coupon` tinyint(1) NOT NULL DEFAULT 0,
  `coupon_code` varchar(255) DEFAULT NULL,
  `coupon_discount_percent` int(11) DEFAULT NULL,
  `coupon_discount_amount` double DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `payment_status` varchar(255) DEFAULT NULL,
  `payable_amount` double DEFAULT NULL,
  `gateway_charge` double DEFAULT NULL,
  `payable_with_charge` double DEFAULT NULL,
  `paid_amount` double DEFAULT NULL,
  `conversion_rate` double DEFAULT NULL,
  `payable_currency` varchar(255) DEFAULT NULL,
  `payment_details` text DEFAULT NULL,
  `transaction_id` varchar(255) DEFAULT NULL,
  `commission_rate` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `invoice_id`, `buyer_id`, `seller_id`, `status`, `has_coupon`, `coupon_code`, `coupon_discount_percent`, `coupon_discount_amount`, `payment_method`, `payment_status`, `payable_amount`, `gateway_charge`, `payable_with_charge`, `paid_amount`, `conversion_rate`, `payable_currency`, `payment_details`, `transaction_id`, `commission_rate`, `created_at`, `updated_at`) VALUES
(1, 'HxnAk4vVz6', 1002, NULL, 'completed', 0, NULL, NULL, NULL, 'Bank', 'paid', 100, 0, 100, 100, 1, 'USD', '{\"bank_name\":\"City Bank\",\"account_number\":\"24234\",\"routing_number\":\"121\",\"branch\":\"Dhaka\"}', 'C9QIoGlipy', 5, '2025-06-16 03:40:35', '2025-06-16 03:42:06'),
(11, 'SU47O7LjV5', 1002, NULL, 'completed', 0, NULL, NULL, NULL, 'Bank', 'paid', 10, 0, 10, 10, 1, 'USD', '{\"bank_name\":\"Trust Bank\",\"account_number\":\"0007035246587965421\",\"routing_number\":\"12547896\",\"branch\":\"Rangpur\"}', 'SVBGzULm1V', 5, '2025-06-21 14:36:09', '2025-06-21 14:37:12');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `qty` int(11) NOT NULL DEFAULT 1,
  `price` double NOT NULL,
  `item_type` enum('course','product') NOT NULL DEFAULT 'course',
  `product_id` bigint(20) UNSIGNED DEFAULT NULL,
  `course_id` bigint(20) UNSIGNED NOT NULL,
  `commission_rate` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `qty`, `price`, `item_type`, `product_id`, `course_id`, `commission_rate`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 100, 'course', NULL, 1, 5, '2025-06-16 03:40:35', '2025-06-16 03:40:35'),
(10, 11, 1, 10, 'course', NULL, 2, 5, '2025-06-21 14:36:09', '2025-06-21 14:36:09');

-- --------------------------------------------------------

--
-- Table structure for table `our_features_sections`
--

CREATE TABLE `our_features_sections` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `image_one` varchar(255) DEFAULT NULL,
  `image_two` varchar(255) DEFAULT NULL,
  `image_three` varchar(255) DEFAULT NULL,
  `image_four` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `our_features_section_translations`
--

CREATE TABLE `our_features_section_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `our_features_section_id` bigint(20) UNSIGNED NOT NULL DEFAULT 1,
  `lang_code` varchar(255) NOT NULL,
  `title_one` varchar(255) DEFAULT NULL,
  `sub_title_one` varchar(255) DEFAULT NULL,
  `title_two` varchar(255) DEFAULT NULL,
  `sub_title_two` varchar(255) DEFAULT NULL,
  `title_three` varchar(255) DEFAULT NULL,
  `sub_title_three` varchar(255) DEFAULT NULL,
  `title_four` varchar(255) DEFAULT NULL,
  `sub_title_four` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_gateways`
--

CREATE TABLE `payment_gateways` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payment_gateways`
--

INSERT INTO `payment_gateways` (`id`, `key`, `value`, `created_at`, `updated_at`) VALUES
(1, 'razorpay_key', 'razorpay_key', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(2, 'razorpay_secret', 'razorpay_secret', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(3, 'razorpay_name', 'WebSolutionUs', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(4, 'razorpay_description', 'This is test payment window', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(5, 'razorpay_charge', '0', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(6, 'razorpay_theme_color', '#6d0ce4', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(7, 'razorpay_status', 'inactive', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(8, 'razorpay_currency_id', '3', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(9, 'razorpay_image', 'uploads/website-images/razorpay.jpeg', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(10, 'flutterwave_public_key', 'flutterwave_public_key', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(11, 'flutterwave_secret_key', 'flutterwave_secret_key', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(12, 'flutterwave_app_name', 'WebSolutionUs', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(13, 'flutterwave_charge', '0', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(14, 'flutterwave_currency_id', '2', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(15, 'flutterwave_status', 'inactive', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(16, 'flutterwave_image', 'uploads/website-images/flutterwave.jpg', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(17, 'paystack_public_key', 'paystack_public_key', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(18, 'paystack_secret_key', 'paystack_secret_key', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(19, 'paystack_status', 'inactive', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(20, 'paystack_charge', '0', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(21, 'paystack_image', 'uploads/website-images/paystack.png', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(22, 'paystack_currency_id', '2', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(23, 'mollie_key', 'mollie_key', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(24, 'mollie_charge', '0', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(25, 'mollie_image', 'uploads/website-images/mollie.png', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(26, 'mollie_status', 'inactive', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(27, 'mollie_currency_id', '5', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(28, 'instamojo_account_mode', 'Sandbox', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(29, 'instamojo_api_key', 'instamojo_api_key', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(30, 'instamojo_auth_token', 'instamojo_auth_token', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(31, 'instamojo_charge', '0', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(32, 'instamojo_image', 'uploads/website-images/instamojo.png', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(33, 'instamojo_currency_id', '3', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(34, 'instamojo_status', 'inactive', '2025-05-12 13:37:57', '2025-05-12 13:37:57');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `group_name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `group_name`, `created_at`, `updated_at`) VALUES
(1, 'dashboard.view', 'admin', 'dashboard', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(2, 'admin.profile.view', 'admin', 'admin profile', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(3, 'admin.profile.update', 'admin', 'admin profile', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(4, 'admin.view', 'admin', 'admin', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(5, 'admin.create', 'admin', 'admin', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(6, 'admin.store', 'admin', 'admin', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(7, 'admin.edit', 'admin', 'admin', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(8, 'admin.update', 'admin', 'admin', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(9, 'admin.delete', 'admin', 'admin', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(10, 'blog.category.view', 'admin', 'blog category', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(11, 'blog.category.create', 'admin', 'blog category', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(12, 'blog.category.translate', 'admin', 'blog category', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(13, 'blog.category.store', 'admin', 'blog category', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(14, 'blog.category.edit', 'admin', 'blog category', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(15, 'blog.category.update', 'admin', 'blog category', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(16, 'blog.category.delete', 'admin', 'blog category', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(17, 'blog.view', 'admin', 'blog', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(18, 'blog.create', 'admin', 'blog', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(19, 'blog.translate', 'admin', 'blog', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(20, 'blog.store', 'admin', 'blog', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(21, 'blog.edit', 'admin', 'blog', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(22, 'blog.update', 'admin', 'blog', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(23, 'blog.delete', 'admin', 'blog', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(24, 'blog.comment.view', 'admin', 'blog comment', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(25, 'blog.comment.update', 'admin', 'blog comment', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(26, 'blog.comment.delete', 'admin', 'blog comment', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(27, 'role.view', 'admin', 'role', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(28, 'role.create', 'admin', 'role', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(29, 'role.store', 'admin', 'role', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(30, 'role.assign', 'admin', 'role', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(31, 'role.edit', 'admin', 'role', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(32, 'role.update', 'admin', 'role', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(33, 'role.delete', 'admin', 'role', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(34, 'setting.view', 'admin', 'setting', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(35, 'setting.update', 'admin', 'setting', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(36, 'basic.payment.view', 'admin', 'basic payment', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(37, 'basic.payment.update', 'admin', 'basic payment', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(38, 'contect.message.view', 'admin', 'contect message', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(39, 'contect.message.delete', 'admin', 'contect message', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(40, 'currency.view', 'admin', 'currency', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(41, 'currency.create', 'admin', 'currency', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(42, 'currency.store', 'admin', 'currency', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(43, 'currency.edit', 'admin', 'currency', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(44, 'currency.update', 'admin', 'currency', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(45, 'currency.delete', 'admin', 'currency', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(46, 'customer.view', 'admin', 'customer', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(47, 'customer.bulk.mail', 'admin', 'customer', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(48, 'customer.create', 'admin', 'customer', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(49, 'customer.store', 'admin', 'customer', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(50, 'customer.edit', 'admin', 'customer', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(51, 'customer.update', 'admin', 'customer', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(52, 'customer.delete', 'admin', 'customer', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(53, 'language.view', 'admin', 'language', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(54, 'language.create', 'admin', 'language', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(55, 'language.store', 'admin', 'language', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(56, 'language.edit', 'admin', 'language', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(57, 'language.update', 'admin', 'language', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(58, 'language.delete', 'admin', 'language', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(59, 'language.translate', 'admin', 'language', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(60, 'language.single.translate', 'admin', 'language', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(61, 'menu.view', 'admin', 'menu builder', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(62, 'menu.create', 'admin', 'menu builder', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(63, 'menu.store', 'admin', 'menu builder', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(64, 'menu.edit', 'admin', 'menu builder', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(65, 'menu.update', 'admin', 'menu builder', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(66, 'menu.delete', 'admin', 'menu builder', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(67, 'page.management', 'admin', 'page builder', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(68, 'payment.view', 'admin', 'payment', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(69, 'payment.update', 'admin', 'payment', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(70, 'newsletter.view', 'admin', 'newsletter', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(71, 'newsletter.mail', 'admin', 'newsletter', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(72, 'newsletter.delete', 'admin', 'newsletter', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(73, 'testimonial.view', 'admin', 'testimonial', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(74, 'testimonial.create', 'admin', 'testimonial', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(75, 'testimonial.translate', 'admin', 'testimonial', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(76, 'testimonial.store', 'admin', 'testimonial', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(77, 'testimonial.edit', 'admin', 'testimonial', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(78, 'testimonial.update', 'admin', 'testimonial', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(79, 'testimonial.delete', 'admin', 'testimonial', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(80, 'faq.view', 'admin', 'faq', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(81, 'faq.create', 'admin', 'faq', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(82, 'faq.translate', 'admin', 'faq', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(83, 'faq.store', 'admin', 'faq', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(84, 'faq.edit', 'admin', 'faq', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(85, 'faq.update', 'admin', 'faq', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(86, 'faq.delete', 'admin', 'faq', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(87, 'location.view', 'admin', 'locations', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(88, 'location.create', 'admin', 'locations', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(89, 'location.store', 'admin', 'locations', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(90, 'location.edit', 'admin', 'locations', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(91, 'location.update', 'admin', 'locations', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(92, 'location.delete', 'admin', 'locations', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(93, 'instructor.request.list', 'admin', 'instructor request', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(94, 'instructor.request.setting', 'admin', 'instructor request', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(95, 'course.management', 'admin', 'courses', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(96, 'course.certificate.management', 'admin', 'course certificate management', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(97, 'badge.management', 'admin', 'Badges', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(98, 'order.management', 'admin', 'order management', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(99, 'coupon.management', 'admin', 'coupon management', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(100, 'withdraw.management', 'admin', 'withdraw management', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(101, 'appearance.management', 'admin', 'site appearance management', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(102, 'section.management', 'admin', 'site appearance management', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(103, 'brand.management', 'admin', 'brand management', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(104, 'footer.management', 'admin', 'footer management', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(105, 'social.link.management', 'admin', 'social link management', '2025-05-12 13:37:58', '2025-05-12 13:37:58'),
(106, 'Database Backup', 'admin', 'database.backup.management', NULL, NULL),
(107, 'database.backup.management', 'admin', 'backup management', NULL, NULL),
(108, 'backup.index', 'admin', NULL, NULL, NULL),
(111, 'affiliate.requests.view', 'admin', 'Affiliate Requests', '2025-06-20 16:32:11', '2025-06-20 16:32:11'),
(112, 'affiliate.requests.update', 'admin', 'Affiliate Requests', '2025-06-20 16:32:11', '2025-06-20 16:32:11'),
(113, 'affiliate.dashboard.view', 'admin', 'Affiliate Dashboard', '2025-06-20 16:32:11', '2025-06-20 16:32:11'),
(114, 'affiliate.commission.update', 'admin', 'Affiliate Dashboard', '2025-06-20 16:32:11', '2025-06-20 16:32:11'),
(116, 'affiliate.commissions.view', 'admin', 'Affiliate Commissions', '2025-06-21 17:58:01', '2025-06-21 17:58:01'),
(117, 'affiliate.commissions.update', 'admin', 'Affiliate Commissions', '2025-06-21 17:58:01', '2025-06-21 17:58:01'),
(118, 'affiliate.withdrawal.view', 'admin', 'Affiliate Withdrawal', '2025-06-21 17:58:01', '2025-06-21 17:58:01'),
(119, 'affiliate.withdrawal.update', 'admin', 'Affiliate Withdrawal', '2025-06-21 17:58:01', '2025-06-21 17:58:01'),
(120, 'affiliate.withdraw-method.index', 'admin', 'Affiliate Withdraw Methods', '2025-06-21 17:58:01', '2025-06-21 17:58:01'),
(121, 'affiliate.withdraw-method.create', 'admin', 'Affiliate Withdraw Methods', '2025-06-21 17:58:01', '2025-06-21 17:58:01'),
(122, 'affiliate.withdraw-method.store', 'admin', 'Affiliate Withdraw Methods', '2025-06-21 17:58:01', '2025-06-21 17:58:01'),
(123, 'affiliate.withdraw-method.edit', 'admin', 'Affiliate Withdraw Methods', '2025-06-21 17:58:01', '2025-06-21 17:58:01'),
(124, 'affiliate.withdraw-method.update', 'admin', 'Affiliate Withdraw Methods', '2025-06-21 17:58:01', '2025-06-21 17:58:01'),
(125, 'affiliate.withdraw-method.destroy', 'admin', 'Affiliate Withdraw Methods', '2025-06-21 17:58:01', '2025-06-21 17:58:01'),
(126, 'affiliate-withdraw-method.index', 'admin', 'Affiliate Withdraw Methods', '2025-06-21 18:32:38', '2025-06-21 18:32:38'),
(127, 'affiliate-withdraw-method.create', 'admin', 'Affiliate Withdraw Methods', '2025-06-21 18:32:38', '2025-06-21 18:32:38'),
(128, 'affiliate-withdraw-method.store', 'admin', 'Affiliate Withdraw Methods', '2025-06-21 18:32:38', '2025-06-21 18:32:38'),
(129, 'affiliate-withdraw-method.edit', 'admin', 'Affiliate Withdraw Methods', '2025-06-21 18:32:38', '2025-06-21 18:32:38'),
(130, 'affiliate-withdraw-method.update', 'admin', 'Affiliate Withdraw Methods', '2025-06-21 18:32:38', '2025-06-21 18:32:38'),
(131, 'affiliate-withdraw-method.destroy', 'admin', 'Affiliate Withdraw Methods', '2025-06-21 18:32:38', '2025-06-21 18:32:38'),
(132, 'affiliate-withdraw-methods.index', 'admin', 'Affiliate Withdraw Methods', '2025-06-21 18:42:33', '2025-06-21 18:42:33'),
(133, 'affiliate-withdraw-methods.create', 'admin', 'Affiliate Withdraw Methods', '2025-06-21 18:42:33', '2025-06-21 18:42:33'),
(134, 'affiliate-withdraw-methods.store', 'admin', 'Affiliate Withdraw Methods', '2025-06-21 18:42:33', '2025-06-21 18:42:33'),
(135, 'affiliate-withdraw-methods.edit', 'admin', 'Affiliate Withdraw Methods', '2025-06-21 18:42:33', '2025-06-21 18:42:33'),
(136, 'affiliate-withdraw-methods.update', 'admin', 'Affiliate Withdraw Methods', '2025-06-21 18:42:33', '2025-06-21 18:42:33'),
(137, 'affiliate-withdraw-methods.destroy', 'admin', 'Affiliate Withdraw Methods', '2025-06-21 18:42:33', '2025-06-21 18:42:33');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quizzes`
--

CREATE TABLE `quizzes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `chapter_item_id` bigint(20) UNSIGNED NOT NULL,
  `instructor_id` bigint(20) UNSIGNED NOT NULL,
  `chapter_id` bigint(20) UNSIGNED NOT NULL,
  `course_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `time` varchar(255) DEFAULT NULL,
  `attempt` varchar(255) DEFAULT NULL,
  `pass_mark` varchar(255) DEFAULT NULL,
  `total_mark` varchar(255) DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quizzes`
--

INSERT INTO `quizzes` (`id`, `chapter_item_id`, `instructor_id`, `chapter_id`, `course_id`, `title`, `time`, `attempt`, `pass_mark`, `total_mark`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 1001, 2, 1, 'What is it?', NULL, NULL, '1', '10', 'active', '2025-05-27 17:37:52', '2025-06-16 04:38:42'),
(2, 2, 1001, 1, 1, 'First Quiz', '100', '100', '1', '10', 'active', '2025-06-16 03:16:18', '2025-06-16 04:37:40'),
(3, 4, 1001, 2, 1, 'gergtwer4t', NULL, NULL, '1', '10', 'active', '2025-06-16 04:39:15', '2025-06-16 04:39:15'),
(4, 6, 1001, 3, 2, 'Quiz', '12', '100', '1', '10', 'active', '2025-06-21 12:40:22', '2025-06-21 12:40:22');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_questions`
--

CREATE TABLE `quiz_questions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `quiz_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `explanation` text DEFAULT NULL,
  `type` enum('descriptive','multiple') NOT NULL DEFAULT 'multiple',
  `grade` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quiz_questions`
--

INSERT INTO `quiz_questions` (`id`, `quiz_id`, `title`, `explanation`, `type`, `grade`, `created_at`, `updated_at`) VALUES
(1, 2, 'What is you name?', 'dfgdfgdfg', 'multiple', 1, '2025-06-16 03:17:35', '2025-06-16 12:29:20'),
(2, 1, 'sdsd', NULL, 'multiple', 1, '2025-06-16 04:40:19', '2025-06-16 04:40:19'),
(3, 3, '54654654', NULL, 'multiple', 1, '2025-06-16 04:41:16', '2025-06-16 04:41:16'),
(4, 2, 'fgfg', NULL, 'multiple', 1, '2025-06-16 12:22:32', '2025-06-16 12:22:32'),
(5, 2, 'adasda', 'dasdasd', 'multiple', 1, '2025-06-16 12:28:55', '2025-06-16 12:28:55'),
(6, 4, 'sdfsdf', 'sdfasdf', 'multiple', 2, '2025-06-21 12:40:47', '2025-06-21 12:40:47');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_question_answers`
--

CREATE TABLE `quiz_question_answers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `question_id` bigint(20) UNSIGNED NOT NULL,
  `correct` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quiz_question_answers`
--

INSERT INTO `quiz_question_answers` (`id`, `title`, `question_id`, `correct`, `created_at`, `updated_at`) VALUES
(5, 'sdsd', 2, 1, '2025-06-16 04:40:19', '2025-06-16 04:40:19'),
(6, 'dsdsd', 2, 0, '2025-06-16 04:40:20', '2025-06-16 04:40:20'),
(7, '55454', 3, 0, '2025-06-16 04:41:16', '2025-06-16 04:41:16'),
(8, '6865464', 3, 1, '2025-06-16 04:41:16', '2025-06-16 04:41:16'),
(13, 'dfg', 4, 1, '2025-06-16 12:22:32', '2025-06-16 12:22:32'),
(14, 'x', 5, 1, '2025-06-16 12:28:55', '2025-06-16 12:28:55'),
(15, 'Omar', 1, 0, '2025-06-16 12:29:20', '2025-06-16 12:29:20'),
(16, 'Faruque', 1, 0, '2025-06-16 12:29:20', '2025-06-16 12:29:20'),
(17, 'Omar Faruq', 1, 0, '2025-06-16 12:29:20', '2025-06-16 12:29:20'),
(18, 'Md. Omar Faruque', 1, 1, '2025-06-16 12:29:20', '2025-06-16 12:29:20'),
(19, 'dfsdfsdf', 6, 0, '2025-06-21 12:40:47', '2025-06-21 12:40:47'),
(20, 'sdfsdf', 6, 1, '2025-06-21 12:40:47', '2025-06-21 12:40:47');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_results`
--

CREATE TABLE `quiz_results` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `quiz_id` bigint(20) UNSIGNED NOT NULL,
  `result` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`result`)),
  `user_grade` int(11) DEFAULT NULL,
  `status` enum('pass','failed') DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quiz_results`
--

INSERT INTO `quiz_results` (`id`, `user_id`, `quiz_id`, `result`, `user_grade`, `status`, `created_at`, `updated_at`) VALUES
(1, 1002, 1, '[]', 0, 'failed', '2025-06-16 04:34:28', '2025-06-16 04:34:28'),
(2, 1002, 2, '{\"1\":{\"answer\":\"4\",\"correct\":true}}', 1, 'failed', '2025-06-16 04:37:04', '2025-06-16 04:37:04'),
(3, 1002, 2, '{\"1\":{\"answer\":\"4\",\"correct\":true}}', 1, 'pass', '2025-06-16 04:37:53', '2025-06-16 04:37:53'),
(4, 1002, 2, '{\"1\":{\"answer\":\"15\",\"correct\":false},\"4\":{\"answer\":\"13\",\"correct\":true},\"5\":{\"answer\":\"14\",\"correct\":true}}', 2, 'pass', '2025-06-16 12:31:17', '2025-06-16 12:31:17'),
(5, 1002, 2, '{\"1\":{\"answer\":\"17\",\"correct\":false},\"4\":{\"answer\":\"13\",\"correct\":true},\"5\":{\"answer\":\"14\",\"correct\":true}}', 2, 'pass', '2025-06-16 12:32:29', '2025-06-16 12:32:29');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'Super Admin', 'admin', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(4, 'General Admin', 'admin', '2025-06-21 17:27:53', '2025-06-21 17:27:53');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(1, 4),
(2, 1),
(2, 4),
(3, 1),
(3, 4),
(4, 1),
(4, 4),
(5, 1),
(5, 4),
(6, 1),
(6, 4),
(7, 1),
(7, 4),
(8, 1),
(8, 4),
(9, 1),
(9, 4),
(10, 1),
(10, 4),
(11, 1),
(11, 4),
(12, 1),
(12, 4),
(13, 1),
(13, 4),
(14, 1),
(14, 4),
(15, 1),
(15, 4),
(16, 1),
(16, 4),
(17, 1),
(17, 4),
(18, 1),
(18, 4),
(19, 1),
(19, 4),
(20, 1),
(20, 4),
(21, 1),
(21, 4),
(22, 1),
(22, 4),
(23, 1),
(23, 4),
(24, 1),
(24, 4),
(25, 1),
(25, 4),
(26, 1),
(26, 4),
(27, 1),
(27, 4),
(28, 1),
(28, 4),
(29, 1),
(29, 4),
(30, 1),
(30, 4),
(31, 1),
(31, 4),
(32, 1),
(32, 4),
(33, 1),
(33, 4),
(34, 1),
(34, 4),
(35, 1),
(35, 4),
(36, 1),
(36, 4),
(37, 1),
(37, 4),
(38, 1),
(38, 4),
(39, 1),
(39, 4),
(40, 1),
(40, 4),
(41, 1),
(41, 4),
(42, 1),
(42, 4),
(43, 1),
(43, 4),
(44, 1),
(44, 4),
(45, 1),
(45, 4),
(46, 1),
(46, 4),
(47, 1),
(47, 4),
(48, 1),
(48, 4),
(49, 1),
(49, 4),
(50, 1),
(50, 4),
(51, 1),
(51, 4),
(52, 1),
(52, 4),
(53, 1),
(53, 4),
(54, 1),
(54, 4),
(55, 1),
(55, 4),
(56, 1),
(56, 4),
(57, 1),
(57, 4),
(58, 1),
(58, 4),
(59, 1),
(59, 4),
(60, 1),
(60, 4),
(61, 1),
(61, 4),
(62, 1),
(62, 4),
(63, 1),
(63, 4),
(64, 1),
(64, 4),
(65, 1),
(65, 4),
(66, 1),
(66, 4),
(67, 1),
(67, 4),
(68, 1),
(68, 4),
(69, 1),
(69, 4),
(70, 1),
(70, 4),
(71, 1),
(71, 4),
(72, 1),
(72, 4),
(73, 1),
(73, 4),
(74, 1),
(74, 4),
(75, 1),
(75, 4),
(76, 1),
(76, 4),
(77, 1),
(77, 4),
(78, 1),
(78, 4),
(79, 1),
(79, 4),
(80, 1),
(80, 4),
(81, 1),
(81, 4),
(82, 1),
(82, 4),
(83, 1),
(83, 4),
(84, 1),
(84, 4),
(85, 1),
(85, 4),
(86, 1),
(86, 4),
(87, 1),
(87, 4),
(88, 1),
(88, 4),
(89, 1),
(89, 4),
(90, 1),
(90, 4),
(91, 1),
(91, 4),
(92, 1),
(92, 4),
(93, 1),
(93, 4),
(94, 1),
(94, 4),
(95, 1),
(95, 4),
(96, 1),
(96, 4),
(97, 1),
(97, 4),
(98, 1),
(98, 4),
(99, 1),
(99, 4),
(100, 1),
(100, 4),
(101, 1),
(101, 4),
(102, 1),
(102, 4),
(103, 1),
(103, 4),
(104, 1),
(104, 4),
(105, 1),
(105, 4),
(106, 4),
(107, 4),
(108, 4),
(111, 4),
(112, 4),
(113, 4),
(114, 4),
(116, 4),
(117, 4),
(118, 4),
(119, 4),
(120, 4),
(121, 4),
(122, 4),
(123, 4),
(124, 4),
(125, 4),
(126, 4),
(127, 4),
(128, 4),
(129, 4),
(130, 4),
(131, 4),
(132, 4),
(133, 4),
(134, 4),
(135, 4),
(136, 4),
(137, 4);

-- --------------------------------------------------------

--
-- Table structure for table `section_settings`
--

CREATE TABLE `section_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `hero_section` tinyint(1) NOT NULL DEFAULT 0,
  `top_category_section` tinyint(1) NOT NULL DEFAULT 0,
  `brands_section` tinyint(1) NOT NULL DEFAULT 0,
  `about_section` tinyint(1) NOT NULL DEFAULT 0,
  `featured_course_section` tinyint(1) NOT NULL DEFAULT 0,
  `news_letter_section` tinyint(1) NOT NULL DEFAULT 0,
  `featured_instructor_section` tinyint(1) NOT NULL DEFAULT 0,
  `counter_section` tinyint(1) NOT NULL DEFAULT 0,
  `faq_section` tinyint(1) NOT NULL DEFAULT 0,
  `our_features_section` tinyint(1) NOT NULL DEFAULT 0,
  `testimonial_section` tinyint(1) NOT NULL DEFAULT 0,
  `banner_section` tinyint(1) NOT NULL DEFAULT 0,
  `latest_blog_section` tinyint(1) NOT NULL DEFAULT 0,
  `blog_page` tinyint(1) NOT NULL DEFAULT 0,
  `about_page` tinyint(1) NOT NULL DEFAULT 0,
  `contact_page` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `section_settings`
--

INSERT INTO `section_settings` (`id`, `hero_section`, `top_category_section`, `brands_section`, `about_section`, `featured_course_section`, `news_letter_section`, `featured_instructor_section`, `counter_section`, `faq_section`, `our_features_section`, `testimonial_section`, `banner_section`, `latest_blog_section`, `blog_page`, `about_page`, `contact_page`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, '2025-05-12 14:57:38', '2025-05-12 14:57:38');

-- --------------------------------------------------------

--
-- Table structure for table `seo_settings`
--

CREATE TABLE `seo_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `page_name` varchar(255) NOT NULL,
  `seo_title` text NOT NULL,
  `seo_description` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `seo_settings`
--

INSERT INTO `seo_settings` (`id`, `page_name`, `seo_title`, `seo_description`, `created_at`, `updated_at`) VALUES
(1, 'home_page', 'Home || WebSolutionUS', 'Home || WebSolutionUS', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(2, 'about_page', 'About || WebSolutionUS', 'About || WebSolutionUS', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(3, 'course_page', 'Course || WebSolutionUS', 'Course || WebSolutionUS', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(4, 'blog_page', 'Blog || WebSolutionUS', 'Blog || WebSolutionUS', '2025-05-12 13:37:57', '2025-05-12 13:37:57'),
(5, 'contact_page', 'Contact || WebSolutionUS', 'Contact || WebSolutionUS', '2025-05-12 13:37:57', '2025-05-12 13:37:57');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `key`, `value`, `created_at`, `updated_at`) VALUES
(1, 'app_name', 'ToLearnTeam', '2025-05-12 13:37:56', '2025-05-12 14:49:18'),
(2, 'version', '1.2.0', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(3, 'logo', 'uploads/custom-images/wsus-img-2025-05-12-08-48-54-1349.png', '2025-05-12 13:37:56', '2025-05-12 14:48:54'),
(4, 'timezone', 'Asia/Dhaka', '2025-05-12 13:37:56', '2025-05-12 14:49:18'),
(5, 'favicon', 'uploads/website-images/favicon.png', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(6, 'cookie_status', 'active', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(7, 'border', 'normal', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(8, 'corners', 'thin', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(9, 'background_color', '#184dec', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(10, 'text_color', '#fafafa', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(11, 'border_color', '#0a58d6', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(12, 'btn_bg_color', '#fffceb', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(13, 'btn_text_color', '#222758', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(14, 'link_text', 'More Info', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(15, 'link', '/', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(16, 'btn_text', 'Yes', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(17, 'message', 'This website uses essential cookies to ensure its proper operation and tracking cookies to understand how you interact with it. The latter will be set only upon approval.', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(18, 'copyright_text', 'this is copyright text', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(19, 'recaptcha_site_key', 'recaptcha_site_key', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(20, 'recaptcha_secret_key', 'recaptcha_secret_key', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(21, 'recaptcha_status', 'inactive', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(22, 'tawk_status', 'inactive', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(23, 'tawk_chat_link', 'tawk_chat_link', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(24, 'google_tagmanager_status', 'active', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(25, 'google_tagmanager_id', 'google_tagmanager_id', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(26, 'pixel_status', 'inactive', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(27, 'pixel_app_id', 'pixel_app_id', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(28, 'facebook_login_status', 'inactive', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(29, 'facebook_app_id', 'facebook_app_id', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(30, 'facebook_app_secret', 'facebook_app_secret', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(31, 'facebook_redirect_url', 'facebook_redirect_url', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(32, 'google_login_status', 'inactive', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(33, 'gmail_client_id', 'gmail_client_id', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(34, 'gmail_secret_id', 'gmail_secret_id', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(35, 'gmail_redirect_url', 'gmail_redirect_url', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(36, 'default_avatar', 'uploads/website-images/default-avatar.png', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(37, 'breadcrumb_image', 'uploads/website-images/breadcrumb-image.jpg', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(38, 'mail_host', 'mail_host', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(39, 'mail_sender_email', 'sender@gmail.com', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(40, 'mail_username', 'mail_username', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(41, 'mail_password', 'mail_password', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(42, 'mail_port', 'mail_port', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(43, 'mail_encryption', 'ssl', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(44, 'mail_sender_name', 'WebSolutionUs', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(45, 'contact_message_receiver_mail', 'receiver@gmail.com', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(46, 'pusher_app_id', 'pusher_app_id', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(47, 'pusher_app_key', 'pusher_app_key', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(48, 'pusher_app_secret', 'pusher_app_secret', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(49, 'pusher_app_cluster', 'pusher_app_cluster', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(50, 'pusher_status', 'inactive', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(51, 'club_point_rate', '1', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(52, 'club_point_status', 'active', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(53, 'maintenance_mode', '0', '2025-05-12 13:37:56', '2025-05-12 14:49:39'),
(54, 'maintenance_title', 'Website Under maintenance', '2025-05-12 13:37:56', '2025-05-12 14:50:55'),
(55, 'maintenance_description', '<p>We are currently performing maintenance on our website to<br>improve your experience. Please check back later.</p>\r\n<p><a title=\"ToLearnTeam\" href=\"ToLearnTeam.com\">ToLearnTeam</a></p>', '2025-05-12 13:37:56', '2025-05-12 14:50:55'),
(56, 'last_update_date', '2025-05-12 19:37:56', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(57, 'is_queable', 'inactive', '2025-05-12 13:37:56', '2025-05-12 14:49:18'),
(58, 'commission_rate', '5', '2025-05-12 13:37:56', '2025-05-27 16:29:26'),
(59, 'site_address', 'test address', '2025-05-12 13:37:56', '2025-05-12 14:49:18'),
(60, 'site_email', 'test@gmail.com', '2025-05-12 13:37:56', '2025-05-12 14:49:18'),
(61, 'site_theme', 'theme-two', '2025-05-12 13:37:56', '2025-06-22 19:00:10'),
(62, 'preloader', '/frontend/img/logo/preloader.svg', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(63, 'primary_color', '#5751e1', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(64, 'secondary_color', '#ffc224', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(65, 'common_color_one', '#050071', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(66, 'common_color_two', '#282568', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(67, 'common_color_three', '#1C1A4A', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(68, 'common_color_four', '#06042E', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(69, 'common_color_five', '#4a44d1', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(70, 'show_all_homepage', '0', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(71, 'google_analytic_status', 'inactive', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(72, 'google_analytic_id', 'google_analytic_id', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(73, 'preloader_status', '1', '2025-05-12 13:37:56', '2025-05-12 14:49:18'),
(74, 'maintenance_image', 'uploads/custom-images/wsus-img-2025-05-12-08-50-55-7365.png', '2025-05-12 13:37:56', '2025-05-12 14:50:55'),
(75, 'live_mail_send', '5', '2025-05-12 13:37:56', '2025-05-12 14:49:18'),
(76, 'wasabi_access_id', 'wasabi_access_id', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(77, 'wasabi_secret_key', 'wasabi_secret_key', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(78, 'wasabi_region', 'us-east-1', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(79, 'wasabi_bucket', 'wasabi_bucket', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(80, 'wasabi_status', 'inactive', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(81, 'aws_access_id', 'aws_access_id', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(82, 'aws_secret_key', 'aws_secret_key', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(83, 'aws_region', 'us-east-1', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(84, 'aws_bucket', 'aws_bucket', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(85, 'aws_status', 'inactive', '2025-05-12 13:37:56', '2025-05-12 13:37:56'),
(86, 'header_topbar_status', 'active', '2025-05-12 13:37:56', '2025-05-12 14:49:18'),
(87, 'cursor_dot_status', 'active', '2025-05-12 13:37:56', '2025-05-12 14:49:18'),
(88, 'header_social_status', 'active', '2025-05-12 13:37:56', '2025-05-12 14:49:18');

-- --------------------------------------------------------

--
-- Table structure for table `socialite_credentials`
--

CREATE TABLE `socialite_credentials` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `provider_name` varchar(255) NOT NULL,
  `provider_id` varchar(255) DEFAULT NULL,
  `access_token` varchar(255) DEFAULT NULL,
  `refresh_token` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `social_links`
--

CREATE TABLE `social_links` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `link` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `states`
--

CREATE TABLE `states` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `country_id` bigint(20) UNSIGNED NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `testimonials`
--

CREATE TABLE `testimonials` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `rating` varchar(255) DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `testimonial_translations`
--

CREATE TABLE `testimonial_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `testimonial_id` bigint(20) UNSIGNED NOT NULL,
  `lang_code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `designation` varchar(255) NOT NULL,
  `comment` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `role` enum('instructor','student') NOT NULL DEFAULT 'student',
  `is_affiliate` tinyint(1) NOT NULL DEFAULT 0,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'active',
  `is_banned` varchar(255) NOT NULL DEFAULT 'no',
  `verification_token` varchar(255) DEFAULT NULL,
  `forget_password_token` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `image` varchar(255) NOT NULL DEFAULT '/uploads/website-images/frontend-avatar.png',
  `cover` varchar(255) NOT NULL DEFAULT '/uploads/website-images/frontend-cover.png',
  `wallet_balance` decimal(8,2) NOT NULL DEFAULT 0.00,
  `bio` text DEFAULT NULL,
  `short_bio` text DEFAULT NULL,
  `job_title` varchar(255) DEFAULT NULL,
  `gender` enum('male','female') DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `country_id` bigint(20) UNSIGNED DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `facebook` varchar(255) DEFAULT NULL,
  `twitter` varchar(255) DEFAULT NULL,
  `linkedin` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `github` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `role`, `is_affiliate`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `status`, `is_banned`, `verification_token`, `forget_password_token`, `phone`, `address`, `image`, `cover`, `wallet_balance`, `bio`, `short_bio`, `job_title`, `gender`, `age`, `country_id`, `state`, `city`, `facebook`, `twitter`, `linkedin`, `website`, `github`) VALUES
(1001, 'Omar Faruque', 'abir43tee1@gmail.com', 'instructor', 1, '2025-05-01 16:07:06', '$2y$12$FqTIYuw2conjsWqWFQeVhu/WoSwQMQ/bHtRS.ggHsORlIN8ewN09q', NULL, '2025-05-27 16:06:04', '2025-06-24 18:37:28', 'active', 'no', 'QF9ERoRgJQilm9O9aIitdpT69sKd4ngWBa2IRmopmrMBin2knEOX5qJM7pamxyO8TrJsF5wnXIHcl1cE3ympPu4x9nzyb0LJmD9Q', NULL, '01711427737', NULL, 'uploads/custom-images/wsus-img-2025-06-16-07-07-51-2772.png', '/uploads/website-images/frontend-cover.png', 1649.20, NULL, NULL, NULL, 'male', 35, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1002, 'Dr. Md. Tofazzal Islam', 'student@gmail.com', 'student', 1, '2025-06-04 03:33:09', '$2y$12$ZfmsOOtwLMmNC0KmqCvQLuNIWimmMWe5/aY8oCtd1YgqCzill.MxG', NULL, '2025-06-16 03:26:58', '2025-06-24 17:35:02', 'active', 'no', 'EoEP7zKxfO49FAUKcnvKfdoNZiI1Z74M0YLBPqrUIkmL2mBJqKs5rn1OqYWbelylPRr5SctmpjO2xDh6pjfMvAYXtRz8CVbmLKqt', NULL, NULL, NULL, '/uploads/website-images/frontend-avatar.png', '/uploads/website-images/frontend-cover.png', 20.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_education`
--

CREATE TABLE `user_education` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `organization` varchar(255) DEFAULT NULL,
  `degree` varchar(255) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `current` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_experiences`
--

CREATE TABLE `user_experiences` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `company` varchar(255) DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `current` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_skill_topics`
--

CREATE TABLE `user_skill_topics` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `withdraw_methods`
--

CREATE TABLE `withdraw_methods` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `min_amount` decimal(8,2) NOT NULL DEFAULT 0.00,
  `max_amount` decimal(8,2) NOT NULL DEFAULT 0.00,
  `description` text DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `withdraw_methods`
--

INSERT INTO `withdraw_methods` (`id`, `name`, `min_amount`, `max_amount`, `description`, `status`, `created_at`, `updated_at`) VALUES
(1, 'bKash', 100.00, 2000.00, 'Direct pay', 'active', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `withdraw_requests`
--

CREATE TABLE `withdraw_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `method` varchar(255) NOT NULL,
  `current_amount` decimal(8,2) NOT NULL DEFAULT 0.00,
  `withdraw_amount` decimal(8,2) NOT NULL DEFAULT 0.00,
  `account_info` text NOT NULL,
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `approved_date` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `withdraw_requests`
--

INSERT INTO `withdraw_requests` (`id`, `user_id`, `method`, `current_amount`, `withdraw_amount`, `account_info`, `status`, `approved_date`, `created_at`, `updated_at`) VALUES
(1, 1001, 'bKash', 2079.20, 100.00, 'sdfsdfsdf', 'approved', '2025-06-22', '2025-06-22 17:39:19', '2025-06-22 17:47:54'),
(2, 1001, 'bKash', 1769.20, 120.00, 'sdfsdfsdf', 'approved', '2025-06-25', '2025-06-24 18:36:35', '2025-06-24 18:37:28');

-- --------------------------------------------------------

--
-- Table structure for table `zoom_credentials`
--

CREATE TABLE `zoom_credentials` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `instructor_id` bigint(20) UNSIGNED NOT NULL,
  `client_id` varchar(255) NOT NULL,
  `client_secret` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `about_sections`
--
ALTER TABLE `about_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `about_section_translations`
--
ALTER TABLE `about_section_translations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admins_email_unique` (`email`);

--
-- Indexes for table `affiliate_commissions`
--
ALTER TABLE `affiliate_commissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `affiliate_commissions_user_id_foreign` (`user_id`),
  ADD KEY `affiliate_commissions_order_id_foreign` (`order_id`),
  ADD KEY `affiliate_commissions_course_id_foreign` (`course_id`);

--
-- Indexes for table `affiliate_links`
--
ALTER TABLE `affiliate_links`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `affiliate_links_referral_code_unique` (`referral_code`),
  ADD KEY `affiliate_links_user_id_foreign` (`user_id`),
  ADD KEY `affiliate_links_course_id_foreign` (`course_id`);

--
-- Indexes for table `affiliate_requests`
--
ALTER TABLE `affiliate_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `affiliate_requests_user_id_foreign` (`user_id`);

--
-- Indexes for table `aff_withdraw_methods`
--
ALTER TABLE `aff_withdraw_methods`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `aff_withdraw_requests`
--
ALTER TABLE `aff_withdraw_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `aff_withdraw_requests_user_id_foreign` (`user_id`);

--
-- Indexes for table `announcements`
--
ALTER TABLE `announcements`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `badges`
--
ALTER TABLE `badges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `banned_histories`
--
ALTER TABLE `banned_histories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `banner_sections`
--
ALTER TABLE `banner_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `basic_payments`
--
ALTER TABLE `basic_payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blogs`
--
ALTER TABLE `blogs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blog_categories`
--
ALTER TABLE `blog_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blog_category_translations`
--
ALTER TABLE `blog_category_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blog_category_translations_blog_category_id_foreign` (`blog_category_id`);

--
-- Indexes for table `blog_comments`
--
ALTER TABLE `blog_comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blog_translations`
--
ALTER TABLE `blog_translations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `certificate_builders`
--
ALTER TABLE `certificate_builders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `certificate_builder_items`
--
ALTER TABLE `certificate_builder_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cities_state_id_foreign` (`state_id`);

--
-- Indexes for table `configurations`
--
ALTER TABLE `configurations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contact_messages`
--
ALTER TABLE `contact_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contact_sections`
--
ALTER TABLE `contact_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `counter_sections`
--
ALTER TABLE `counter_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `counter_section_translations`
--
ALTER TABLE `counter_section_translations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `coupon_histories`
--
ALTER TABLE `coupon_histories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `course_categories`
--
ALTER TABLE `course_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `course_category_translations`
--
ALTER TABLE `course_category_translations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `course_chapters`
--
ALTER TABLE `course_chapters`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_chapters_course_id_foreign` (`course_id`);

--
-- Indexes for table `course_chapter_items`
--
ALTER TABLE `course_chapter_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_chapter_items_instructor_id_foreign` (`instructor_id`),
  ADD KEY `course_chapter_items_chapter_id_foreign` (`chapter_id`);

--
-- Indexes for table `course_chapter_lessons`
--
ALTER TABLE `course_chapter_lessons`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_chapter_lessons_instructor_id_foreign` (`instructor_id`),
  ADD KEY `course_chapter_lessons_chapter_id_foreign` (`chapter_id`),
  ADD KEY `course_chapter_lessons_chapter_item_id_foreign` (`chapter_item_id`);

--
-- Indexes for table `course_delete_requests`
--
ALTER TABLE `course_delete_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `course_languages`
--
ALTER TABLE `course_languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `course_levels`
--
ALTER TABLE `course_levels`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `course_level_translations`
--
ALTER TABLE `course_level_translations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `course_live_classes`
--
ALTER TABLE `course_live_classes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_live_classes_lesson_id_foreign` (`lesson_id`);

--
-- Indexes for table `course_partner_instructors`
--
ALTER TABLE `course_partner_instructors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `course_progress`
--
ALTER TABLE `course_progress`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `course_reviews`
--
ALTER TABLE `course_reviews`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `course_selected_filter_options`
--
ALTER TABLE `course_selected_filter_options`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `course_selected_languages`
--
ALTER TABLE `course_selected_languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `course_selected_levels`
--
ALTER TABLE `course_selected_levels`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `custom_codes`
--
ALTER TABLE `custom_codes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `custom_pages`
--
ALTER TABLE `custom_pages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `custom_page_translations`
--
ALTER TABLE `custom_page_translations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `custom_paginations`
--
ALTER TABLE `custom_paginations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `email_templates`
--
ALTER TABLE `email_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `enrollments`
--
ALTER TABLE `enrollments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `enrollments_order_id_foreign` (`order_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `faqs`
--
ALTER TABLE `faqs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `faq_sections`
--
ALTER TABLE `faq_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `faq_section_translations`
--
ALTER TABLE `faq_section_translations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `faq_translations`
--
ALTER TABLE `faq_translations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `featured_course_sections`
--
ALTER TABLE `featured_course_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `featured_instructors`
--
ALTER TABLE `featured_instructors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `featured_instructor_translations`
--
ALTER TABLE `featured_instructor_translations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `footer_settings`
--
ALTER TABLE `footer_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hero_sections`
--
ALTER TABLE `hero_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hero_section_translations`
--
ALTER TABLE `hero_section_translations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `instructor_requests`
--
ALTER TABLE `instructor_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `instructor_request_settings`
--
ALTER TABLE `instructor_request_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `instructor_request_setting_translations`
--
ALTER TABLE `instructor_request_setting_translations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jitsi_settings`
--
ALTER TABLE `jitsi_settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jitsi_settings_instructor_id_foreign` (`instructor_id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `languages_name_unique` (`name`),
  ADD UNIQUE KEY `languages_code_unique` (`code`);

--
-- Indexes for table `lesson_questions`
--
ALTER TABLE `lesson_questions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lesson_replies`
--
ALTER TABLE `lesson_replies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lesson_replies_question_id_foreign` (`question_id`);

--
-- Indexes for table `marketing_settings`
--
ALTER TABLE `marketing_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu_items`
--
ALTER TABLE `menu_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `menu_items_menu_id_foreign` (`menu_id`);

--
-- Indexes for table `menu_item_translations`
--
ALTER TABLE `menu_item_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `menu_item_translations_menu_item_id_foreign` (`menu_item_id`);

--
-- Indexes for table `menu_translations`
--
ALTER TABLE `menu_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `menu_translations_menu_id_foreign` (`menu_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `multi_currencies`
--
ALTER TABLE `multi_currencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `newsletter_sections`
--
ALTER TABLE `newsletter_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `news_letters`
--
ALTER TABLE `news_letters`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_items_order_id_foreign` (`order_id`);

--
-- Indexes for table `our_features_sections`
--
ALTER TABLE `our_features_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `our_features_section_translations`
--
ALTER TABLE `our_features_section_translations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `payment_gateways`
--
ALTER TABLE `payment_gateways`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `quizzes`
--
ALTER TABLE `quizzes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `quiz_questions`
--
ALTER TABLE `quiz_questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quiz_questions_quiz_id_foreign` (`quiz_id`);

--
-- Indexes for table `quiz_question_answers`
--
ALTER TABLE `quiz_question_answers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `quiz_results`
--
ALTER TABLE `quiz_results`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `section_settings`
--
ALTER TABLE `section_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `seo_settings`
--
ALTER TABLE `seo_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `socialite_credentials`
--
ALTER TABLE `socialite_credentials`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `social_links`
--
ALTER TABLE `social_links`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `states`
--
ALTER TABLE `states`
  ADD PRIMARY KEY (`id`),
  ADD KEY `states_country_id_foreign` (`country_id`);

--
-- Indexes for table `testimonials`
--
ALTER TABLE `testimonials`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `testimonial_translations`
--
ALTER TABLE `testimonial_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `testimonial_translations_lang_code_index` (`lang_code`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `user_education`
--
ALTER TABLE `user_education`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_experiences`
--
ALTER TABLE `user_experiences`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_skill_topics`
--
ALTER TABLE `user_skill_topics`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `withdraw_methods`
--
ALTER TABLE `withdraw_methods`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `withdraw_requests`
--
ALTER TABLE `withdraw_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `zoom_credentials`
--
ALTER TABLE `zoom_credentials`
  ADD PRIMARY KEY (`id`),
  ADD KEY `zoom_credentials_instructor_id_foreign` (`instructor_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `about_sections`
--
ALTER TABLE `about_sections`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `about_section_translations`
--
ALTER TABLE `about_section_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `affiliate_commissions`
--
ALTER TABLE `affiliate_commissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `affiliate_links`
--
ALTER TABLE `affiliate_links`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `affiliate_requests`
--
ALTER TABLE `affiliate_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `aff_withdraw_methods`
--
ALTER TABLE `aff_withdraw_methods`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `aff_withdraw_requests`
--
ALTER TABLE `aff_withdraw_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `announcements`
--
ALTER TABLE `announcements`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `badges`
--
ALTER TABLE `badges`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `banned_histories`
--
ALTER TABLE `banned_histories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `banner_sections`
--
ALTER TABLE `banner_sections`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `basic_payments`
--
ALTER TABLE `basic_payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `blogs`
--
ALTER TABLE `blogs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `blog_categories`
--
ALTER TABLE `blog_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `blog_category_translations`
--
ALTER TABLE `blog_category_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `blog_comments`
--
ALTER TABLE `blog_comments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `blog_translations`
--
ALTER TABLE `blog_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `certificate_builders`
--
ALTER TABLE `certificate_builders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `certificate_builder_items`
--
ALTER TABLE `certificate_builder_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `cities`
--
ALTER TABLE `cities`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `configurations`
--
ALTER TABLE `configurations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `contact_messages`
--
ALTER TABLE `contact_messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contact_sections`
--
ALTER TABLE `contact_sections`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `counter_sections`
--
ALTER TABLE `counter_sections`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `counter_section_translations`
--
ALTER TABLE `counter_section_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `countries`
--
ALTER TABLE `countries`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `coupon_histories`
--
ALTER TABLE `coupon_histories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `course_categories`
--
ALTER TABLE `course_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `course_category_translations`
--
ALTER TABLE `course_category_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `course_chapters`
--
ALTER TABLE `course_chapters`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `course_chapter_items`
--
ALTER TABLE `course_chapter_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `course_chapter_lessons`
--
ALTER TABLE `course_chapter_lessons`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `course_delete_requests`
--
ALTER TABLE `course_delete_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `course_languages`
--
ALTER TABLE `course_languages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `course_levels`
--
ALTER TABLE `course_levels`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `course_level_translations`
--
ALTER TABLE `course_level_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `course_live_classes`
--
ALTER TABLE `course_live_classes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `course_partner_instructors`
--
ALTER TABLE `course_partner_instructors`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `course_progress`
--
ALTER TABLE `course_progress`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `course_reviews`
--
ALTER TABLE `course_reviews`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `course_selected_filter_options`
--
ALTER TABLE `course_selected_filter_options`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `course_selected_languages`
--
ALTER TABLE `course_selected_languages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `course_selected_levels`
--
ALTER TABLE `course_selected_levels`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `custom_codes`
--
ALTER TABLE `custom_codes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `custom_pages`
--
ALTER TABLE `custom_pages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `custom_page_translations`
--
ALTER TABLE `custom_page_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `custom_paginations`
--
ALTER TABLE `custom_paginations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `email_templates`
--
ALTER TABLE `email_templates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `enrollments`
--
ALTER TABLE `enrollments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `faqs`
--
ALTER TABLE `faqs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `faq_sections`
--
ALTER TABLE `faq_sections`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `faq_section_translations`
--
ALTER TABLE `faq_section_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `faq_translations`
--
ALTER TABLE `faq_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `featured_course_sections`
--
ALTER TABLE `featured_course_sections`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `featured_instructors`
--
ALTER TABLE `featured_instructors`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `featured_instructor_translations`
--
ALTER TABLE `featured_instructor_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `footer_settings`
--
ALTER TABLE `footer_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hero_sections`
--
ALTER TABLE `hero_sections`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `hero_section_translations`
--
ALTER TABLE `hero_section_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `instructor_requests`
--
ALTER TABLE `instructor_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `instructor_request_settings`
--
ALTER TABLE `instructor_request_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `instructor_request_setting_translations`
--
ALTER TABLE `instructor_request_setting_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jitsi_settings`
--
ALTER TABLE `jitsi_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `lesson_questions`
--
ALTER TABLE `lesson_questions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lesson_replies`
--
ALTER TABLE `lesson_replies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `marketing_settings`
--
ALTER TABLE `marketing_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `menu_items`
--
ALTER TABLE `menu_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `menu_item_translations`
--
ALTER TABLE `menu_item_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `menu_translations`
--
ALTER TABLE `menu_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=117;

--
-- AUTO_INCREMENT for table `multi_currencies`
--
ALTER TABLE `multi_currencies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `newsletter_sections`
--
ALTER TABLE `newsletter_sections`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `news_letters`
--
ALTER TABLE `news_letters`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `our_features_sections`
--
ALTER TABLE `our_features_sections`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `our_features_section_translations`
--
ALTER TABLE `our_features_section_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_gateways`
--
ALTER TABLE `payment_gateways`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=138;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quizzes`
--
ALTER TABLE `quizzes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `quiz_questions`
--
ALTER TABLE `quiz_questions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `quiz_question_answers`
--
ALTER TABLE `quiz_question_answers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `quiz_results`
--
ALTER TABLE `quiz_results`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `section_settings`
--
ALTER TABLE `section_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `seo_settings`
--
ALTER TABLE `seo_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT for table `socialite_credentials`
--
ALTER TABLE `socialite_credentials`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `social_links`
--
ALTER TABLE `social_links`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `states`
--
ALTER TABLE `states`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `testimonials`
--
ALTER TABLE `testimonials`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `testimonial_translations`
--
ALTER TABLE `testimonial_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1003;

--
-- AUTO_INCREMENT for table `user_education`
--
ALTER TABLE `user_education`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_experiences`
--
ALTER TABLE `user_experiences`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_skill_topics`
--
ALTER TABLE `user_skill_topics`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `withdraw_methods`
--
ALTER TABLE `withdraw_methods`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `withdraw_requests`
--
ALTER TABLE `withdraw_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `zoom_credentials`
--
ALTER TABLE `zoom_credentials`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `affiliate_commissions`
--
ALTER TABLE `affiliate_commissions`
  ADD CONSTRAINT `affiliate_commissions_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `affiliate_commissions_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `affiliate_commissions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `affiliate_links`
--
ALTER TABLE `affiliate_links`
  ADD CONSTRAINT `affiliate_links_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `affiliate_links_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `affiliate_requests`
--
ALTER TABLE `affiliate_requests`
  ADD CONSTRAINT `affiliate_requests_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `aff_withdraw_requests`
--
ALTER TABLE `aff_withdraw_requests`
  ADD CONSTRAINT `aff_withdraw_requests_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `blog_category_translations`
--
ALTER TABLE `blog_category_translations`
  ADD CONSTRAINT `blog_category_translations_blog_category_id_foreign` FOREIGN KEY (`blog_category_id`) REFERENCES `blog_categories` (`id`);

--
-- Constraints for table `cities`
--
ALTER TABLE `cities`
  ADD CONSTRAINT `cities_state_id_foreign` FOREIGN KEY (`state_id`) REFERENCES `states` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `course_chapters`
--
ALTER TABLE `course_chapters`
  ADD CONSTRAINT `course_chapters_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `course_chapter_items`
--
ALTER TABLE `course_chapter_items`
  ADD CONSTRAINT `course_chapter_items_chapter_id_foreign` FOREIGN KEY (`chapter_id`) REFERENCES `course_chapters` (`id`),
  ADD CONSTRAINT `course_chapter_items_instructor_id_foreign` FOREIGN KEY (`instructor_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `course_chapter_lessons`
--
ALTER TABLE `course_chapter_lessons`
  ADD CONSTRAINT `course_chapter_lessons_chapter_id_foreign` FOREIGN KEY (`chapter_id`) REFERENCES `course_chapters` (`id`),
  ADD CONSTRAINT `course_chapter_lessons_chapter_item_id_foreign` FOREIGN KEY (`chapter_item_id`) REFERENCES `course_chapter_items` (`id`),
  ADD CONSTRAINT `course_chapter_lessons_instructor_id_foreign` FOREIGN KEY (`instructor_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `course_live_classes`
--
ALTER TABLE `course_live_classes`
  ADD CONSTRAINT `course_live_classes_lesson_id_foreign` FOREIGN KEY (`lesson_id`) REFERENCES `course_chapter_lessons` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `enrollments`
--
ALTER TABLE `enrollments`
  ADD CONSTRAINT `enrollments_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `jitsi_settings`
--
ALTER TABLE `jitsi_settings`
  ADD CONSTRAINT `jitsi_settings_instructor_id_foreign` FOREIGN KEY (`instructor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `lesson_replies`
--
ALTER TABLE `lesson_replies`
  ADD CONSTRAINT `lesson_replies_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `lesson_questions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `menu_items`
--
ALTER TABLE `menu_items`
  ADD CONSTRAINT `menu_items_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `menu_item_translations`
--
ALTER TABLE `menu_item_translations`
  ADD CONSTRAINT `menu_item_translations_menu_item_id_foreign` FOREIGN KEY (`menu_item_id`) REFERENCES `menu_items` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `menu_translations`
--
ALTER TABLE `menu_translations`
  ADD CONSTRAINT `menu_translations_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `quiz_questions`
--
ALTER TABLE `quiz_questions`
  ADD CONSTRAINT `quiz_questions_quiz_id_foreign` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `states`
--
ALTER TABLE `states`
  ADD CONSTRAINT `states_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `zoom_credentials`
--
ALTER TABLE `zoom_credentials`
  ADD CONSTRAINT `zoom_credentials_instructor_id_foreign` FOREIGN KEY (`instructor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
