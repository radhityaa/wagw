-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 10 Agu 2023 pada 18.18
-- Versi server: 10.6.14-MariaDB-cll-lve
-- Versi PHP: 8.1.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sendermo_wa`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `autoreplies`
--

CREATE TABLE `autoreplies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `device_id` varchar(255) NOT NULL,
  `keyword` varchar(255) NOT NULL,
  `type_keyword` enum('Equal','Contain') NOT NULL DEFAULT 'Equal',
  `type` enum('text','image','button','template','list') NOT NULL,
  `reply` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`reply`)),
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `reply_when` enum('Group','Personal','All') NOT NULL DEFAULT 'All',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_quoted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `blasts`
--

CREATE TABLE `blasts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `sender` varchar(255) NOT NULL,
  `campaign_id` bigint(20) UNSIGNED NOT NULL,
  `receiver` varchar(255) NOT NULL,
  `message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`message`)),
  `type` enum('text','button','image','template','list') NOT NULL,
  `status` enum('failed','success','pending') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `campaigns`
--

CREATE TABLE `campaigns` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `device_id` bigint(20) UNSIGNED NOT NULL,
  `phonebook_id` bigint(20) UNSIGNED NOT NULL,
  `delay` int(11) NOT NULL DEFAULT 10,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `status` enum('waiting','processing','failed','completed','paused') NOT NULL DEFAULT 'waiting',
  `message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`message`)),
  `schedule` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `contacts`
--

CREATE TABLE `contacts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `tag_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `number` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `devices`
--

CREATE TABLE `devices` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `body` varchar(255) NOT NULL,
  `webhook` varchar(255) DEFAULT NULL,
  `status` enum('Connected','Disconnect') NOT NULL DEFAULT 'Disconnect',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `message_sent` bigint(20) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data untuk tabel `devices`
--

INSERT INTO `devices` (`id`, `user_id`, `body`, `webhook`, `status`, `created_at`, `updated_at`, `message_sent`) VALUES
(1, 1, '6285708662655', NULL, 'Disconnect', '2023-08-10 11:09:12', '2023-08-10 11:09:12', 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `message_histories`
--

CREATE TABLE `message_histories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `device_id` bigint(20) UNSIGNED NOT NULL,
  `number` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `message` varchar(255) NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`payload`)),
  `status` enum('success','failed') NOT NULL,
  `send_by` enum('api','web') NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data untuk tabel `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2022_02_15_090711_create_numbers_table', 1),
(3, '2022_02_18_125542_create_autoreplies_table', 1),
(4, '2022_02_18_142742_create_tags_table', 1),
(5, '2022_02_19_142504_create_contacts_table', 1),
(6, '2022_07_23_163942_create_campaigns_table', 1),
(7, '2022_07_23_172710_create_blasts_table', 1),
(8, '2022_10_16_194044_add_column_to_autoreplies_table', 1),
(9, '2023_02_22_135833_add_status_column_to_autoreplies_table', 1),
(10, '2023_02_26_090658_add_is_quoted_column_to_autoreplies_table', 1),
(11, '2023_02_27_102221_create_message_histories_table', 1),
(12, '2023_02_27_112543_add_message_sent_column_to_device_table', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tags`
--

CREATE TABLE `tags` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `api_key` varchar(255) NOT NULL,
  `chunk_blast` int(11) NOT NULL,
  `level` enum('admin','user') NOT NULL DEFAULT 'user',
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `limit_device` int(11) NOT NULL DEFAULT 0,
  `active_subscription` enum('inactive','active','lifetime','trial') NOT NULL DEFAULT 'inactive',
  `subscription_expired` datetime DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `email_verified_at`, `password`, `api_key`, `chunk_blast`, `level`, `status`, `limit_device`, `active_subscription`, `subscription_expired`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'adminku', 'admin@gmail.com', '2023-08-10 00:00:00', '$2y$10$dXUyQYvlwy1/fkkaX3XtkuXvCC9sO5t2xmamk74se0IYo9fT2SjHS', '', 0, 'admin', 'active', 10, 'lifetime', NULL, '1zEEnxz2An2K0v94h97cth8IzwUIwBLc9s5lmlvdzvOL3hkNVijPvlwg9C7l', '2023-08-10 18:06:16', '2023-08-10 18:06:16');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `autoreplies`
--
ALTER TABLE `autoreplies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `autoreplies_user_id_foreign` (`user_id`);

--
-- Indeks untuk tabel `blasts`
--
ALTER TABLE `blasts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blasts_user_id_foreign` (`user_id`),
  ADD KEY `blasts_campaign_id_foreign` (`campaign_id`);

--
-- Indeks untuk tabel `campaigns`
--
ALTER TABLE `campaigns`
  ADD PRIMARY KEY (`id`),
  ADD KEY `campaigns_user_id_foreign` (`user_id`),
  ADD KEY `campaigns_device_id_foreign` (`device_id`),
  ADD KEY `campaigns_phonebook_id_foreign` (`phonebook_id`);

--
-- Indeks untuk tabel `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contacts_tag_id_foreign` (`tag_id`);

--
-- Indeks untuk tabel `devices`
--
ALTER TABLE `devices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `devices_user_id_foreign` (`user_id`);

--
-- Indeks untuk tabel `message_histories`
--
ALTER TABLE `message_histories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `message_histories_user_id_foreign` (`user_id`),
  ADD KEY `message_histories_device_id_foreign` (`device_id`);

--
-- Indeks untuk tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tags_user_id_foreign` (`user_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `autoreplies`
--
ALTER TABLE `autoreplies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `blasts`
--
ALTER TABLE `blasts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `campaigns`
--
ALTER TABLE `campaigns`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `devices`
--
ALTER TABLE `devices`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `message_histories`
--
ALTER TABLE `message_histories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT untuk tabel `tags`
--
ALTER TABLE `tags`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
