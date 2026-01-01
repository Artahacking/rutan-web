-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 31, 2025 at 05:13 PM
-- Server version: 8.0.30
-- PHP Version: 8.2.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rutan_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `gallery`
--

CREATE TABLE `gallery` (
  `id` int NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `gallery`
--

INSERT INTO `gallery` (`id`, `title`, `image`) VALUES
(1, 'Kegiatan Banjir Rutan Kelas IIB Pangkalan Brandan', '20251227120442_rutan.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `litmas_data`
--

CREATE TABLE `litmas_data` (
  `id` int NOT NULL,
  `nama_wbp` varchar(255) NOT NULL,
  `pidana_tahun` int DEFAULT '0',
  `pidana_bulan` int DEFAULT '0',
  `besaran_denda` varchar(100) DEFAULT '0',
  `subs_bulan` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `litmas_data`
--

INSERT INTO `litmas_data` (`id`, `nama_wbp`, `pidana_tahun`, `pidana_bulan`, `besaran_denda`, `subs_bulan`, `created_at`) VALUES
(1, 'ABDUL WAHAB ROKAN SIREGAR BIN M. YUSUF', 5, 0, '1.000.000', 3, '2025-12-31 15:50:06'),
(2, 'ADITYA BIN SURYANTO', 2, 0, '0', 0, '2025-12-31 16:56:34'),
(3, 'ADITYA RAMADANI BIN NASIB', 5, 0, '800.000', 3, '2025-12-31 16:57:44'),
(4, 'AHMAD DANI BIN M. NASIR', 2, 0, '0', 0, '2025-12-31 16:58:56');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  `message` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `name`, `phone`, `message`, `created_at`) VALUES
(3, 'Faiz Syukri Arta ', '083840538292', 'Tetap Semangat Rupandan', '2025-12-27 16:39:58'),
(4, 'Alief', '089687120457', 'Testing Pesan', '2025-12-30 03:09:57');

-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE `news` (
  `id` int NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `content` text,
  `image` varchar(255) DEFAULT NULL,
  `author` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `news`
--

INSERT INTO `news` (`id`, `title`, `content`, `image`, `author`, `created_at`) VALUES
(2, 'Rutan Kelas IIB Pangkalan Brandan melaksanakan apel pagi dalam rangka Peringatan Bela Negara', '<p>Pangkalan Brandan -&nbsp;</p>\r\n\r\n<p>Rutan Kelas IIB Pangkalan Brandan melaksanakan apel pagi dalam rangka Peringatan Bela Negara, yang dilanjutkan dengan pemberian piagam penghargaan kepada Pegawai Teladan Bulan November.</p>\r\n\r\n<p>Kegiatan berlangsung dengan penuh khidmat dan diikuti oleh seluruh jajaran pegawai sebagai bentuk penguatan nilai pengabdian serta kedisiplinan dalam menjalankan tugas.</p>\r\n\r\n<p>Apel Peringatan Bela Negara ini menjadi momen refleksi bagi seluruh pegawai untuk memperteguh kembali komitmen pengabdian kepada bangsa dan negara. Melalui pelaksanaan apel ini, diharapkan semangat bela negara dapat terus terinternalisasi dalam setiap pelaksanaan tugas, terutama dalam hal kedisiplinan, loyalitas, serta tanggung jawab dalam memberikan pelayanan dan menjalankan fungsi pemasyarakatan.</p>\r\n\r\n<p>Dalam amanatnya, Kepala Rutan, Akmalun Ihsan, menegaskan bahwa bela negara merupakan sikap dan komitmen yang harus tercermin dalam keseharian kerja aparatur. &quot;Bela negara tidak hanya sebatas seremoni. Ia hidup dalam kedisiplinan, tanggung jawab, dan integritas saat kita melaksanakan tugas. Setiap pegawai memiliki peran penting dalam menjaga kepercayaan publik,&quot; ujar Kepala Rutan.</p>\r\n\r\n<p>Pada kesempatan ini, piagam penghargaan Pegawai Teladan Bulan November diberikan kepada Kusnadi Jaya, Staf Bimbingan Kerja, atas dedikasi, konsistensi, serta keteladanan dalam menjalankan tugas. Kepala Rutan menyampaikan apresiasi dan berharap penghargaan ini dapat menjadi pemicu semangat bagi seluruh pegawai. &quot;Penghargaan ini bukanlah akhir, tetapi sebuah pemantik untuk terus meningkatkan profesionalisme dan menjadi teladan bagi rekan-rekan kerja lainnya,&quot; tambahnya.</p>\r\n\r\n<p>Melalui momentum Peringatan Bela Negara yang dirangkai dengan pemberian penghargaan ini, Rutan Kelas IIB Pangkalan Brandan berkomitmen untuk memperkuat budaya kerja yang disiplin, bertanggung jawab, dan berorientasi pada kinerja terbaik dalam pelaksanaan tugas pemasyarakatan di bawah naungan Kementerian Hukum dan Hak Asasi Manusia.</p>\r\n', '20251227121028_Bela_Negara.jpeg', 'Humas Rutan', '2025-12-27 05:10:28');

-- --------------------------------------------------------

--
-- Table structure for table `profiles`
--

CREATE TABLE `profiles` (
  `id` int NOT NULL,
  `section_type` enum('main','point') DEFAULT 'point',
  `title` varchar(200) DEFAULT NULL,
  `content` text,
  `image` varchar(255) DEFAULT NULL,
  `position` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `profiles`
--

INSERT INTO `profiles` (`id`, `section_type`, `title`, `content`, `image`, `position`) VALUES
(1, 'point', 'Akmalun Ikhsan A.Md.IP., S.H., M.H', '<p>Karutan Pangkalan Brandan</p>\r\n', '20251231234025_wkwkwkwk-removebg-preview.png', NULL),
(2, 'point', 'Andre Situmorang, S. Tr. Pass', '<p>Ka. Kesatuan Keamanan Rutan</p>\r\n', '20251231232948_pak_andree2-removebg-preview.png', NULL),
(3, 'point', 'Rolan Siringo Ringo, S. Pd', '<p>Ka. Subseksi Pelayan Tahanan</p>\r\n', '20251231233811_rolan.png', NULL),
(4, 'point', 'Lamhot Sihombing, S. H', '<p>Ka. Subseksi Pengolahan</p>\r\n', '20251231233835_lamhot.png', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` int NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `description` text,
  `image` varchar(255) DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`id`, `title`, `description`, `image`, `file`) VALUES
(3, 'Layanan Integrasi CB/PB dan Remisi', '<ul>\r\n	<li>Cuti bersyarat atau CB adalah proses&nbsp;pembinaan di&nbsp; luar&nbsp; Rutan atau Lembaga Pemasyarakatan bagi Narapidana yang dipidana paling lama&nbsp;<strong>1 (satu) tahun 6 (enam) bulan</strong>, sekurang-kurangnya telah menjalani&nbsp;<strong>2/3 ( dua pertiga )</strong>&nbsp;masa pidana dengan syarat sebagai berikut&nbsp;</li>\r\n</ul>\r\n\r\n<ol>\r\n	<li>Dipidana dengan pidana penjara paling lama 1 (satu) tahun 6 (enam) bulan</li>\r\n	<li>Telah menjalani paling sedikit 2/3 (dua per tiga) masa pidana</li>\r\n	<li>Berkelakuan baik dalam kurun waktu 6 (enam) bulan terakhir</li>\r\n	<li>CB bagi Narapidana dan Anak Pidana dapat diberikan untuk jangka waktu paling lama 6 (enam) bulan</li>\r\n	<li>Fotokopi kutipan putusan hakim dan berita acara pelaksanaan putusan pengadilan dan laporan perkembangan pembinaan yang dibuat oleh wali pemasyarakatan/ hasil assessment resiko dan assessment kebutuhan yang dilakukan oleh asesor dan laporan penelitian kemasyarakatan yang dibuat oleh Pembimbing Kemasyarakatan yang diketahui oleh Kepala Bapas</li>\r\n	<li>Surat pemberitahuan ke Kejaksaan Negeri tentang rencana pemberian CB terhadap Narapidana dan Anak Didik Pemasyarakatan yang bersangkutan</li>\r\n	<li>Salinan register F, salinan daftar perubahan dari Kepala Lapas dan surat pernyataan&nbsp; dari Narapidana atau Anak Didik Pemasyarakatan tidak akan melakukan perbuatan melanggar hukum</li>\r\n	<li>Surat jaminan kesanggupan dari pihak keluarga yang diketahui oleh lurah, kepala desa yang menyatakan Narapidana atau Anak Didik Pemasyarakatan tidak akan melarikan diri dan&nbsp; melakukan perbuatan melanggar hukum, serta membantu dalam membimbing dan mengawasi Narapidana/anak didik pemasyarakatan selama mengikuti program CB.&nbsp;Untuk mendapatkan surat jaminan silahkan download surat di bawah ini!!</li>\r\n</ol>\r\n', NULL, '20251227113405_Cv_Faiz_Syukri_Arta.pdf');

-- --------------------------------------------------------

--
-- Table structure for table `sliders`
--

CREATE TABLE `sliders` (
  `id` int NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `link` varchar(255) DEFAULT '#'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `sliders`
--

INSERT INTO `sliders` (`id`, `title`, `image`, `link`) VALUES
(3, 'SELAMAT DATANG DI RUTAN KELAS IIB PANGKALAN BRANDAN', '20251230144940_rumah_tahanan_negara_kelas_iib_pngkalan_berandan.png', '');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `image`) VALUES
(1, 'Faiz', 'admin', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `wbp_stats`
--

CREATE TABLE `wbp_stats` (
  `id` int NOT NULL,
  `count` int NOT NULL DEFAULT '0',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `wbp_stats`
--

INSERT INTO `wbp_stats` (`id`, `count`, `updated_at`) VALUES
(1, 455, '2025-12-31 15:29:40');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `gallery`
--
ALTER TABLE `gallery`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `litmas_data`
--
ALTER TABLE `litmas_data`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `profiles`
--
ALTER TABLE `profiles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sliders`
--
ALTER TABLE `sliders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wbp_stats`
--
ALTER TABLE `wbp_stats`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `gallery`
--
ALTER TABLE `gallery`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `litmas_data`
--
ALTER TABLE `litmas_data`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `news`
--
ALTER TABLE `news`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `profiles`
--
ALTER TABLE `profiles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sliders`
--
ALTER TABLE `sliders`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `wbp_stats`
--
ALTER TABLE `wbp_stats`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
