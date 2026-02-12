-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 12, 2026 at 03:48 AM
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
(2, 'Upacara Hari Bela Negara', '20260108112003_DSC09364.JPG'),
(3, 'Peduli Korban Bencana Alam. Rutan Pangkalan Brandan Memberikan Donasi', '20260108112101_DSC00789.JPG'),
(4, 'Kasih yang membebaskan, Rutan Pangkalan Brandan Gelar perayaan Natal', '20260108112411_DSC09168.JPG'),
(5, 'Dirtjenpas kunjungi Rutan Pangkalan Brandan, Pastikan Layanan Kembali Pulih Pasca Banjiir', '20260108112620_DSC07491.jpg'),
(6, 'Refleksi Peran Perempuan, Rutan Pangkalan Brandan Peringati Hari Ibu Nasional', '20260108112730_DSC09800.JPG'),
(7, 'SukaCita Natal, Rutan Pangkalan Brandan Berikan Remisi Khusus Untuk Warga Binaan', '20260108112912_DSC00368.JPG'),
(9, 'Karutan Pangkalan Brandan Meresmikan Perbaikan Sarana & Prasarana Umum SDN 053996 Pelawi', '20260108113409_DSC07046.jpg'),
(10, 'Rutan Pangkalan Brandan Mmebuat Pelatihan Belajar Komputer Untuk WBP', '20260108113557_DSC08164.JPG'),
(11, 'Rutan Pangkalan Brandan Distribusikan Bantuan Pasca Bencana Kepada Seluruh Keluarga WBP', '20260108113737_DSC07697.JPG');

-- --------------------------------------------------------

--
-- Table structure for table `kunjungan_online`
--

CREATE TABLE `kunjungan_online` (
  `id` int NOT NULL,
  `nama_pengunjung` varchar(100) NOT NULL,
  `alamat` text NOT NULL,
  `no_wa` varchar(20) DEFAULT NULL,
  `umur` int NOT NULL,
  `jenis_kelamin` enum('Laki-laki','Perempuan') NOT NULL,
  `nama_wbp` varchar(100) NOT NULL,
  `perkara` varchar(255) DEFAULT NULL,
  `status` enum('Pending','Disetujui','Ditolak') DEFAULT 'Pending',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `kunjungan_online`
--

INSERT INTO `kunjungan_online` (`id`, `nama_pengunjung`, `alamat`, `no_wa`, `umur`, `jenis_kelamin`, `nama_wbp`, `perkara`, `status`, `created_at`) VALUES
(4, 'Budi Santoso', 'Pangkalan Brandan', '6285359416178', 24, 'Laki-laki', 'Aris', 'Narkoba', 'Pending', '2026-01-07 06:56:47');

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
(6, 'ABDUL WAHAB ROKAN SIREGAR BIN M. YUSUF', 5, 0, 'Rp. 1,000,000,000', 3, '2026-01-05 11:59:23'),
(7, 'ADITYA BIN SURYANTO', 2, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(8, 'ADITYA RAMADANI BIN NASIB', 5, 0, 'Rp. 800,000,000', 3, '2026-01-05 11:59:23'),
(9, 'AHMAD DANI BIN M. NASIR', 2, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(10, 'AHMAD DANIL BIN AMIR HAN ZAIN (ALM)', 2, 6, 'Rp. 100,000,000', 3, '2026-01-05 11:59:23'),
(11, 'AHMAD SUNARIO BIN AHMAD JUNAEDI', 2, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(12, 'AIDIL SYAHPUTRA BIN GITOK', 2, 6, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(13, 'AL FHARIQ SYAH BIN SYAHPUDDIN', 5, 6, 'Rp. 1,000,000,000', 3, '2026-01-05 11:59:23'),
(14, 'AMRI MUZAHIDIN PANE BIN BAHTIAR PANE (ALM)', 2, 6, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(15, 'ANDRE IRFANDI BIN ALM. ARI', 6, 0, 'Rp. 1,500,000,000', 4, '2026-01-05 11:59:23'),
(16, 'ANDRI SYAHPUTRA BIN SUKIRMAN', 6, 0, 'Rp. 1,000,000,000', 1, '2026-01-05 11:59:23'),
(17, 'ANUAR ANDIKA WARDANA BIN SULAIMAN', 5, 0, 'Rp. 1,000,000,000', 1, '2026-01-05 11:59:23'),
(18, 'ARDIANSYAH BIN HUSNI (ALM)', 3, 0, 'Rp. 1,000,000,000', 3, '2026-01-05 11:59:23'),
(19, 'ARDIANSYAH PUTRA BIN SAFRUDIN', 1, 6, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(20, 'ARI WIBOWO BIN ZULMI AMADI', 2, 6, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(21, 'ARISDIANTO BIN UUN', 2, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(22, 'ARISNO PADANG BIN ZAIDAN PADANG', 1, 6, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(23, 'AWALUDDIN BIN NGADIMUN (ALM)', 2, 6, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(24, 'BERLIAN WIDODO BIN MARULI JABALIAN SINAGA', 1, 6, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(25, 'CANDRA SUTRISMAN BIN -', 0, 9, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(26, 'DEDI SYAHPUTRA BIN M.NURDIN SINAGA', 5, 0, 'Rp. 1,000,000,000', 3, '2026-01-05 11:59:23'),
(27, 'DENI KURNIAWAN NASUTION BIN ABDUL RAHMAN NASUTION (ALM', 5, 6, 'Rp. 1,000,000,000', 6, '2026-01-05 11:59:23'),
(28, 'DERA GUNAWAN BIN HERMANSYAH', 1, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(29, 'DIMAS ANDREAN BIN MADI (ALM)', 3, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(30, 'DIMAS SYAHPUTRA BIN FADLI DALIMUNTHE', 1, 10, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(31, 'DONI WAHYUDI ALS DONI', 2, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(32, 'DWI CAHYA PRASETYA BIN HARMAWAN', 2, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(33, 'EDY PURNAMA BIN SEPTIAN', 2, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(34, 'EKO PRANOTO BIN TUKIMAN', 2, 6, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(35, 'ELKANA BANGUN BIN SAMPURNO BANGUN', 0, 8, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(36, 'FADLI HIDAYAT BIN MUHAMMAD ADLI (ALM)', 2, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(37, 'FAHLEVI SIREGAR BIN SALAHUDIN SIREGAR (ALM)', 2, 10, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(38, 'FEBRIAN SAMOSIR BIN JUNIARTA SAMOSIR (ALM)', 4, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(39, 'FERDIANSYAH BIN -', 1, 2, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(40, 'FERDY ANANDA', 0, 10, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(41, 'FERNANDO SIHOMBING BIN -', 2, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(42, 'GUSVAN PRAMAJAYA BIN SYAHRUL (ALM)', 2, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(43, 'HANAFI BIN MUHAMMAD SYUKUR', 4, 6, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(44, 'HANAFI BIN SAFII', 7, 0, 'Rp. 1,000,000,000', 3, '2026-01-05 11:59:23'),
(45, 'HASIAN J. MANALU ALS BURHAN', 1, 6, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(46, 'HENDRA PARLINDUNGAN SIAGIAN BIN', 1, 6, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(47, 'HENDRA SAPUTRA BIN ABDUL WAHIT', 5, 0, 'Rp. 1,000,000,000', 2, '2026-01-05 11:59:23'),
(48, 'HENDRIK GUNAWAN SEMBIRING BIN -', 0, 8, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(49, 'IMAM HAKIKI BIN ZULKIFLI', 2, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(50, 'INDRA AGUSTIAN BIN WAGINO (ALM)', 1, 6, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(51, 'IRMANSYAH BIN RIDWAN (ALM)', 3, 0, 'Rp. 1,000,000,000', 3, '2026-01-05 11:59:23'),
(52, 'IRWANSYAH BIN M YUSUF', 4, 0, 'Rp. 800,000,000', 2, '2026-01-05 11:59:23'),
(53, 'IRWANSYAH PUTRA BIN ZAINAL ABIDIN', 2, 6, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(54, 'JOKO SAPUTRA BIN NASIP SUTRISNO', 3, 6, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(55, 'JULIANTO BIN JUMINGAN (ALM)', 2, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(56, 'KHAIRUL ICHSAN LUBIS BIN ANIR SYAHRIFUDDIN LUBIS', 5, 0, 'Rp. 1,000,000,000', 3, '2026-01-05 11:59:23'),
(57, 'KHALID ZIVA SIAGIAN BIN HASANUDDIN SIAGIAN', 3, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(58, 'LEO WIRDANA SITOMPUL BIN ABDUL RAHMAN SITOMPUL (ALM)', 2, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(59, 'LUKMAN HAKIM SITUMEANG BIN LAKSOGEN SITUMEANG', 1, 6, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(60, 'M. AGUSTIYAN KL BIN M. SUHARDI KL (ALM)', 3, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(61, 'M. DAPIT NST BIN -', 1, 2, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(62, 'M. FADLI BIN KHAMIL (ALM)', 1, 6, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(63, 'M. SYAHPUTRA PANJAITAN BIN JIMY', 2, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(64, 'MARLIADI BIN NGATIJO (ALM)', 3, 0, 'Rp. 1,000,000,000', 3, '2026-01-05 11:59:23'),
(65, 'MIYANTO BIN SELAMAT', 2, 6, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(66, 'MUHAMMAD AFANDI ALIAS ANDI BIN ALM.MUJIONO', 8, 0, 'Rp. 1,000,000,000', 3, '2026-01-05 11:59:23'),
(67, 'MUHAMMAD ALI IMRAN BIN SIMEN AJAR (ALM)', 2, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(68, 'MUHAMMAD DAYAT BIN SUANTO', 1, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(69, 'MUHAMMAD DICKY ARDIANSYAH BIN SUMANTO (ALM)', 5, 0, 'Rp. 1,000,000,000', 3, '2026-01-05 11:59:23'),
(70, 'MUHAMMAD IQBAL ZAMZAMI BIN BAKTIAR', 4, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(71, 'MUHAMMAD MULYADI BIN RAMA TANJUNG', 4, 0, 'Rp. 800,000,000', 3, '2026-01-05 11:59:23'),
(72, 'MUHAMMAD NASER BIN RINALDI', 2, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(73, 'MUHAMMAD NUR BIN SUMANTO (ALM)', 3, 0, 'Rp. 1,000,000,000', 3, '2026-01-05 11:59:23'),
(74, 'MUHAMMAD RAMADHAN HARAHAP BIN DIAN HARAHAP', 3, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(75, 'MUHAMMAD RIDHO BIN MUSRFLI PILIANG', 2, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(76, 'MUHAMMAD SAHPUTRA BIN MUHAMMAD', 2, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(77, 'MUHAMMAD SIDDIQ', 1, 8, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(78, 'MUHAMMAD SIDIK BIN KATIMAN LBS', 5, 0, 'Rp. 1,000,000,000', 4, '2026-01-05 11:59:23'),
(79, 'MULYADI BIN MISNO', 2, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(80, 'NANDA SYAHPUTRA BIN AGUS SYAHPUTRA', 2, 6, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(81, 'NASIP SIHOMBING BIN HATNER SIHOMBING', 2, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(82, 'NOFIRMAN HAREFA BIN SENIFAO HAREFA', 1, 6, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(83, 'NURDIANSYAH TANJUNG BIN MUHAMMAD NUR TANJUNG (ALM)', 7, 0, 'Rp. 1,000,000,000', 3, '2026-01-05 11:59:23'),
(84, 'RAFLI DARMAWAN BIN SURYANTO', 1, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(85, 'RAMADHAN SYAHPUTRA NST BIN -', 1, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(86, 'RAYCAPRI AGINTA SINULINGGA BIN TANI SINULINGGA', 6, 0, 'Rp. 1,000,000,000', 3, '2026-01-05 11:59:23'),
(87, 'RIO FEBRIANJA BIN LARA JUNAIDI', 8, 0, 'Rp. 1,000,000,000', 2, '2026-01-05 11:59:23'),
(88, 'RISKI ARIANTO SITUMORANG BIN BORHAT SITUMORANG', 5, 6, 'Rp. 1,000,000,000', 3, '2026-01-05 11:59:23'),
(89, 'RIYANDI SHAHPUTRA ALS IPUL BIN SURYA IRAWADI', 10, 0, 'Rp. 1,000,000,000', 6, '2026-01-05 11:59:23'),
(90, 'RIZKY SANJAYA BIN ALM. JUNAIDI', 1, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(91, 'ROMANSYAH BIN TUKIMIN (ALM)', 1, 8, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(92, 'RUDI SUSILO GINTING BIN -', 2, 6, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(93, 'SALMAN BIN -', 0, 11, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(94, 'SAMUEL HAREFA BIN PRANS HAREFA', 2, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(95, 'SANGKOT MARTUA SITORUS BIN HARAPAN SITORUS', 4, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(96, 'SAPARUDIN BIN BURHAN (ALM)', 5, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(97, 'SAPRIJAL BIN -', 1, 2, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(98, 'SAPRIJAL BIN SAFARUDIN', 1, 6, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(99, 'SARIFUDIN BIN -', 0, 8, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(100, 'SAWALUDIN BIN SUTONO', 6, 0, 'Rp. 1,000,000,000', 6, '2026-01-05 11:59:23'),
(101, 'SIGIT PANGESTU BIN SULARNO (ALM)', 3, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(102, 'SUDARWIN BIN KASIMAN (ALM)', 4, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(103, 'SUPRIANTO BIN -', 1, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(104, 'SUTAR BIN TUMIN (ALM)', 3, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(105, 'SUTOWO BIN -', 1, 0, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(106, 'SUWANDI BIN Suimin', 5, 0, 'Rp. 800,000,000', 2, '2026-01-05 11:59:23'),
(107, 'SUWINDRA BIN ABU BAKAR (ALM)', 3, 0, 'Rp. 1,000,000,000', 3, '2026-01-05 11:59:23'),
(108, 'TENGKU ANDRIAN BIN TENGKU ASWANI AZIS', 1, 10, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(109, 'TUGIRIN BIN PONIJAN(ALM)', 2, 6, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(110, 'UMAR BIN MINSAH', 4, 6, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(111, 'WAHYUDI BIN SURIANTO', 5, 6, 'Rp. 1,000,000,000', 6, '2026-01-05 11:59:23'),
(112, 'WINDRA PATRIA DIARI BIN DARUSSAMAN', 5, 6, 'Rp. 1,000,000,000', 3, '2026-01-05 11:59:23'),
(113, 'YONO BIN SARGIMAN', 5, 0, 'Rp. 1,000,000,000', 4, '2026-01-05 11:59:23'),
(114, 'YUSWARDI BIN LEGIMIN (ALM)', 1, 3, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(115, 'ZULFAN EFENDI BIN ALM.EWIN ADI SYAHPUTRA', 6, 0, 'Rp. 1,000,000,000', 3, '2026-01-05 11:59:23'),
(116, 'ZULIA DAIN BIN SABUDIN', 5, 0, 'Rp. 1,000,000,000', 4, '2026-01-05 11:59:23'),
(117, 'ZULKIFLI BIN JUNI (ALM)', 1, 6, 'Rp. 0', 0, '2026-01-05 11:59:23'),
(118, 'ZULKIFLI HARAHAP BIN AKMAL', 2, 6, 'Rp. 0', 0, '2026-01-05 11:59:23');

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
  `category` varchar(50) DEFAULT 'Kegiatan Rutan',
  `content` text,
  `image` varchar(255) DEFAULT NULL,
  `author` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `news`
--

INSERT INTO `news` (`id`, `title`, `category`, `content`, `image`, `author`, `created_at`) VALUES
(3, 'Sukacita Natal, Rutan Pangkalan Brandan Salurkan Remisi Khusus bagi Warga Binaan', 'Kegiatan Rutan', '<p>Pangkalan Brandan &ndash; Rumah Tahanan Negara Kelas IIB Pangkalan Brandan menyerahkan remisi khusus Hari Raya Natal kepada 26 warga binaan pemasyarakatan beragama Nasrani dalam rangka memperingati Natal dan Tahun Baru 2026. Pemberian remisi tersebut merupakan bentuk pemenuhan hak warga binaan sekaligus bagian dari proses pembinaan yang mengedepankan nilai-nilai kemanusiaan.</p>\r\n\r\n<p>Kegiatan penyerahan remisi dibuka secara langsung oleh Kepala Rutan Pangkalan Brandan, Akmalun Ikhsan, bersama jajaran. Pada kesempatan tersebut, Akmalun menyampaikan bahwa remisi khusus Natal merupakan apresiasi dari negara atas sikap dan perilaku baik warga binaan selama menjalani masa pidana. &ldquo;Remisi ini diberikan sebagai penghargaan bagi warga binaan yang telah menunjukkan kepatuhan dan perubahan positif selama mengikuti pembinaan,&rdquo; ujarnya.</p>\r\n\r\n<p>Dari keseluruhan penerima remisi, satu orang warga binaan dinyatakan langsung bebas. Warga binaan yang bersangkutan juga menerima paket bantuan sosial sebagai bentuk dukungan awal dalam proses kembali dan beradaptasi di tengah masyarakat.</p>\r\n\r\n<p>Rangkaian perayaan Natal berlangsung dengan suasana khidmat dan penuh kebahagiaan. Bagi warga binaan, momen ini menjadi penyemangat untuk terus menjalani pembinaan secara lebih baik serta menumbuhkan optimisme dalam menatap masa depan.</p>\r\n', '20260111200544_Blur.jpeg', 'Humas Rutan', '2026-01-11 13:05:44'),
(4, 'Refleksi Peran Perempuan, Rutan Pangkalan Brandan Peringati Hari Ibu', 'Kegiatan Rutan', '<p>Pangkalan Brandan &ndash; Rumah Tahanan Negara Kelas IIB Pangkalan Brandan melaksanakan upacara peringatan Hari Ibu Nasional Tahun 2025 pada Senin, 22 Desember 2025. Kegiatan ini menjadi sarana refleksi atas peran penting perempuan dalam pembangunan nasional, sekaligus bentuk penghargaan terhadap kontribusi kaum ibu di berbagai bidang kehidupan.</p>\r\n\r\n<p>Upacara digelar di halaman Rutan Pangkalan Brandan dan dipimpin oleh Kepala Subseksi Pelayanan Tahanan, Rolan Siringo-Ringo, yang bertindak sebagai inspektur upacara. Kegiatan tersebut diikuti oleh jajaran petugas rutan serta peserta magang dengan penuh khidmat.</p>\r\n\r\n<p>Peringatan Hari Ibu Nasional tahun ini mengangkat tema &ldquo;Perempuan Berdaya dan Berkarya, Menuju Indonesia Emas 2045&rdquo; sebagaimana ditetapkan oleh Kementerian Pemberdayaan Perempuan dan Perlindungan Anak. Tema tersebut menegaskan peran strategis perempuan dalam mendukung terwujudnya Indonesia yang maju, mandiri, dan berdaya saing di masa mendatang.</p>\r\n\r\n<p>Melalui peringatan ini, Rutan Pangkalan Brandan berharap semangat pemberdayaan perempuan dapat terus ditanamkan, baik di lingkungan pemasyarakatan maupun dalam kehidupan bermasyarakat secara luas. Rangkaian upacara peringatan Hari Ibu Nasional tersebut ditutup dengan kegiatan foto bersama seluruh peserta.</p>\r\n', '20260111200636_DSC09800.JPG', 'Humas Rutan', '2026-01-11 13:06:36'),
(5, 'Rutan Pangkalan Brandan Berikan Bantuan Kemanusiaan kepada Warga Terdampak Bencana di Kuala Simpang', 'Kegiatan Rutan', '<p>Kuala Simpang &ndash; Petugas Rumah Tahanan Negara Kelas IIB Pangkalan Brandan menyalurkan bantuan sosial kepada masyarakat yang terdampak bencana di wilayah Kuala Simpang, Aceh, pada Senin, 29 Desember 2025. Kegiatan penyaluran bantuan tersebut dilaksanakan di Kampung Tanjung Karang dan Kampung Landu mulai pukul 11.00 WIB.</p>\r\n\r\n<p>Bantuan yang disalurkan meliputi berbagai kebutuhan pokok seperti beras, mi instan, telur, air minum dalam kemasan, sarden, serta perlengkapan penunjang lainnya berupa tikar dan selimut. Selain itu, jajaran Rutan Pangkalan Brandan turut membagikan lebih dari 1.100 paket makanan siap santap kepada warga setempat.</p>\r\n\r\n<p>Kepala Rutan Pangkalan Brandan, Akmalun Ikhsan, menyampaikan bahwa kegiatan tersebut merupakan wujud kepedulian sosial jajaran pemasyarakatan terhadap masyarakat yang sedang mengalami musibah. &ldquo;Kami berharap bantuan ini dapat sedikit meringankan beban warga serta membantu mencukupi kebutuhan dasar mereka selama masa pemulihan,&rdquo; ujarnya.</p>\r\n\r\n<p>Lebih lanjut, Akmalun menjelaskan bahwa penyaluran bantuan ini juga bertujuan untuk mempererat hubungan antara lembaga pemasyarakatan dengan masyarakat. Hal serupa disampaikan oleh Kepala Kesatuan Pengamanan Rutan, Andre Situmorang. Ia menegaskan, &ldquo;Bantuan diserahkan langsung kepada warga agar tepat sasaran dan manfaatnya dapat segera dirasakan.&rdquo;</p>\r\n', '20260111201420_DSC00789.JPG', 'Humas Rutan', '2026-01-11 13:14:20'),
(6, 'Teguhkan Bela Negara untuk Indonesia Maju, Rutan Pangkalan Brandan Gelar Upacara Hari Bela Negara', 'Kegiatan Rutan', '<p>Pangkalan Brandan, 19 Desember 2025 &mdash; Dalam rangka&nbsp;merayakan&nbsp;Hari Bela Negara, Rumah Tahanan Negara (Rutan) Kelas IIB Pangkalan Brandan&nbsp;mengadakan&nbsp;upacara bendera&nbsp;yang&nbsp;khidmat pada pagi&nbsp;hari Jumat&nbsp;(19/12).&nbsp;Kegiatan ini&nbsp;membawa&nbsp;tema &ldquo;Teguhkan Bela Negara untuk Indonesia Maju&rdquo;&nbsp;yang mencerminkan&nbsp;komitmen seluruh jajaran dalam menanamkan nilai-nilai&nbsp;kebangsaan&nbsp;dan&nbsp;rasa&nbsp;cinta&nbsp;terhadap&nbsp;tanah air.</p>\r\n\r\n<p><br />\r\nUpacara yang&nbsp;berlangsung&nbsp;di halaman Rutan Pangkalan Brandan&nbsp;dihadiri&nbsp;oleh&nbsp;semua&nbsp;pegawai dan petugas pemasyarakatan, serta peserta magang.&nbsp;Menjadi&nbsp;inspektur upacara yang mewakili bapak karutan, Bapak Lamhot Sihombing menekankan pentingnya semangat bela negara dalam&nbsp;melaksanakan&nbsp;tugas dan tanggung jawab,&nbsp;terutama&nbsp;bagi aparatur sipil negara di lingkungan pemasyarakatan.<br />\r\nDalam&nbsp;pesannya, Bapak Lamhot&nbsp;menyatakan&nbsp;bahwa bela negara tidak hanya&nbsp;diartikan&nbsp;dalam konteks pertahanan fisik,&nbsp;melainkan&nbsp;juga diwujudkan melalui pengabdian, integritas,&nbsp;disiplin, serta pelayanan terbaik kepada masyarakat.&nbsp;Ia berpendapat bahwa&nbsp;peran setiap individu sangat&nbsp;krusial&nbsp;dalam mendukung terwujudnya Indonesia yang maju, berdaulat, dan&nbsp;mampu bersaing.</p>\r\n\r\n<p><br />\r\n&ldquo;Semangat bela negara harus&nbsp;selalu&nbsp;kita teguhkan dalam setiap pelaksanaan tugas.&nbsp;Dengan&nbsp;bertindak&nbsp;secara profesional,&nbsp;memiliki integritas, dan menjunjung tinggi nilai persatuan, kita turut&nbsp;berpartisipasi&nbsp;dalam pembangunan bangsa,&rdquo;&nbsp;ujar Lamhot Sihombing.<br />\r\nMelalui peringatan Hari Bela Negara ini, Rutan Pangkalan Brandan berharap seluruh jajaran semakin memperkuat rasa&nbsp;mencintai&nbsp;tanah air&nbsp;dan&nbsp;menjadikan nilai-nilai bela negara sebagai&nbsp;dasar&nbsp;dalam menjalankan tugas-tugas&nbsp;sehari-hari.&nbsp;Kegiatan upacara&nbsp;berjalan&nbsp;tertib dan lancar hingga selesai.</p>\r\n', '20260111201551_DSC09364.JPG', 'Humas Rutan', '2026-01-11 13:15:51'),
(7, 'Program Pembinaan Peserta Magang, Rutan Pangkalan Brandan Gelar Kelas  Pembelajaran Iqra', 'Kegiatan Rutan', '<p>Pangkalan Brandan, 18 Desember 2025 &mdash; Dalam rangka meningkatkan kualitas pembinaan kepribadian Warga Binaan Pemasyarakatan (WBP), Rumah Tahanan Negara (Rutan) Kelas IIB Pangkalan Brandan kembali melaksanakan kegiatan pembinaan keagamaan melalui kelas pembelajaran Iqra. Kegiatan ini merupakan bagian dari program pembinaan yang melibatkan peserta magang, dan dilaksanakan pada Kamis (18/12) di dalam lingkungan Rutan Pangkalan Brandan.</p>\r\n\r\n<p>Kelas pembelajaran Iqra ini difokuskan bagi Warga Binaan Pemasyarakatan yang masih berada pada tahap dasar dalam membaca Al-Qur&rsquo;an. Dengan pendampingan langsung dari peserta magang serta pengawasan petugas pemasyarakatan, kegiatan ini bertujuan untuk membantu warga Binaan Pemasyarakatan (WBP ) mengenal huruf hijaiyah, memperbaiki pelafalan, serta menumbuhkan semangat belajar agama Islam secara bertahap dan berkelanjutan.</p>\r\n\r\n<p>Kepala Rutan Kelas IIB Pangkalan Brandan, <strong>Bapak Akhmalun Ikhsan</strong>, menyampaikan bahwa pembinaan keagamaan merupakan salah satu pilar penting dalam sistem pemasyarakatan. Menurutnya, pembelajaran Iqra tidak hanya berorientasi pada kemampuan membaca, tetapi juga menjadi sarana pembentukan karakter, pengendalian diri, dan peningkatan kesadaran spiritual Warga Binaan.</p>\r\n\r\n<p>&ldquo;Melalui kegiatan pembelajaran Iqra ini, kami berharap Warga Binaan dapat memanfaatkan waktu pembinaan dengan kegiatan yang positif dan bermanfaat. Pembinaan keagamaan menjadi pondasi penting dalam proses perubahan sikap dan perilaku, sehingga setelah selesai menjalani masa pidana, mereka dapat kembali ke masyarakat dengan pribadi yang lebih baik,&rdquo; ungkap Akhmalun Ikhsan.</p>\r\n\r\n<p>Ia juga menambahkan bahwa keterlibatan peserta magang dalam kegiatan pembinaan ini memberikan manfaat ganda. Selain membantu kelancaran proses pembelajaran bagi Warga Binaan Pemasyarakatan, peserta magang juga mendapatkan pengalaman langsung terkait pelaksanaan pembinaan di lingkungan pemasyarakatan, khususnya dalam bidang keagamaan dan sosial.</p>\r\n\r\n<p>Selama kegiatan berlangsung, para Warga Binaan tampak antusias dan aktif mengikuti setiap materi yang diberikan. Suasana kelas berlangsung tertib, kondusif, dan penuh semangat belajar. Peserta magang dengan sabar membimbing WBP satu per satu sesuai dengan kemampuan masing-masing, sehingga proses pembelajaran berjalan efektif.</p>\r\n\r\n<p>Melalui pelaksanaan kelas pembelajaran Iqra ini, Rutan Pangkalan Brandan berkomitmen untuk terus menghadirkan program pembinaan yang humanis, edukatif, dan berkelanjutan. Diharapkan, kegiatan ini mampu memberikan dampak positif dalam meningkatkan keimanan, akhlak, serta kesiapan Warga Binaan Pemasyarakatan untuk menjalani kehidupan yang lebih baik setelah kembali ke tengah masyarakat.</p>\r\n', '20260111201732_WhatsApp_Image_2026-01-11_at_20.02.20.jpeg', 'Humas Rutan', '2026-01-11 13:17:32'),
(8, 'Kasih yang Membebaskan, Rutan Pangkalan Brandan Gelar Perayaan Natal', 'Kegiatan Rutan', '<p>Pangkalan Brandan, 17 Desember 2025 &mdash; Dalam suasana penuh sukacita dan kebersamaan, Rumah Tahanan Negara (Rutan) Kelas IIB Pangkalan Brandan menggelar Perayaan Natal Tahun 2025 dengan mengusung tema <em>&ldquo;Kasih yang Membebaskan&rdquo;</em>, Rabu (17/12). Perayaan Natal ini diikuti oleh jajaran pegawai serta peserta magang Rutan Pangkalan Brandan yang beragama Kristen, sebagai bentuk penguatan iman dan kebersamaan dalam menjalankan tugas dan pengabdian.</p>\r\n\r\n<p>Kegiatan perayaan Natal dilaksanakan di gereja dengan suasana khidmat dan penuh kehangatan. Rangkaian acara diawali dengan ibadah Natal yang dipimpin oleh<strong> </strong>Pendeta Marihot Situmorang. Dalam khotbahnya, Pendeta Marihot Situmorang menyampaikan pesan tentang makna Natal sebagai perwujudan kasih Tuhan yang membebaskan manusia dari rasa takut, keputusasaan, dan beban kehidupan, serta mengajak seluruh jemaat untuk meneladani kasih tersebut dalam kehidupan sehari-hari dan dalam pelaksanaan tugas.</p>\r\n\r\n<p>&ldquo;Kasih yang sejati adalah kasih yang memberi pengharapan dan membebaskan, sehingga setiap orang mampu menjalani hidup dengan hati yang damai serta penuh tanggung jawab,&rdquo; ujar Pendeta Marihot Situmorang dalam penyampaiannya.</p>\r\n\r\n<p>Mewakili Kepala Rutan Kelas IIB Pangkalan Brandan, <strong>Lamhot Sihombing</strong> dalam sambutannya menyampaikan bahwa perayaan Natal merupakan momentum refleksi dan pembaruan iman bagi seluruh pegawai dan peserta magang. Menurutnya, nilai-nilai Natal sangat relevan dalam membangun integritas, semangat kebersamaan, serta etos kerja yang berlandaskan kasih dan kejujuran.</p>\r\n\r\n<p>&ldquo;Tema <em>Kasih yang Membebaskan</em> mengingatkan kita untuk menjalankan tugas dengan hati yang tulus, saling mendukung, serta menjunjung tinggi nilai kemanusiaan. Semangat Natal diharapkan menjadi kekuatan moral dalam meningkatkan kualitas pelayanan dan pengabdian,&rdquo; ungkap Lamhot Sihombing.</p>\r\n\r\n<p>Ia juga menambahkan bahwa kegiatan keagamaan seperti perayaan Natal ini menjadi bagian penting dalam menciptakan lingkungan kerja yang harmonis dan saling menghormati. Melalui kebersamaan dalam ibadah dan perayaan, diharapkan terjalin hubungan yang semakin solid antara jajaran pegawai dan peserta magang.</p>\r\n\r\n<p>Selama kegiatan berlangsung, seluruh peserta mengikuti ibadah dengan penuh kekhusyukan. Lantunan pujian, doa bersama, serta suasana perayaan yang sederhana namun bermakna menambah kekhidmatan acara Natal tahun ini.</p>\r\n\r\n<p>Dengan terselenggaranya Perayaan Natal bertema <em>&ldquo;Kasih yang Membebaskan&rdquo;</em>, Rutan Pangkalan Brandan berharap nilai-nilai kasih, kedamaian, dan pengharapan dapat terus diimplementasikan dalam kehidupan sehari-hari, khususnya dalam pelaksanaan tugas dan tanggung jawab sebagai insan pemasyarakatan yang profesional dan berintegritas.</p>\r\n', '20260111201931_DSC09168.JPG', 'Humas Rutan', '2026-01-11 13:19:31'),
(9, 'Ditjenpas Kunjungi Rutan Pangkalan Brandan, Pastikan Layanan Kembali Pulih Pasca Banjir', 'Informasi Publik', '<p>Pangkalan Brandan, 4 Desember 2025 &mdash; Direktorat Jenderal Pemasyarakatan (Ditjenpas) melakukan kunjungan kerja ke Rumah Tahanan Negara (Rutan) Kelas IIB Pangkalan Brandan guna memastikan seluruh layanan pemasyarakatan telah kembali berjalan normal pasca terjadinya bencana banjir. Kunjungan tersebut dilaksanakan pada Kamis (04/12) sebagai bentuk perhatian dan komitmen Ditjenpas dalam menjaga kualitas pelayanan serta kondisi sarana dan prasarana pemasyarakatan.</p>\r\n\r\n<p>Kunjungan dipimpin langsung oleh Direktur Jenderal Pemasyarakatan, Bapak Mashud<strong>i</strong>, yang hadir bersama Direktur Kepatuhan Internal<strong> </strong>Lilik Sujandi, Direktur Sistem Penilaian Pembinaan Kadek Anton Budiharta, serta Inspektur Wilayah II Ian Fidhianto beserta tim. Rombongan Ditjenpas turut didampingi oleh Kepala Kantor Wilayah Ditjenpas Sumatera Utara, Yudi Suseno.</p>\r\n\r\n<p>Setibanya di Rutan Pangkalan Brandan, rombongan disambut langsung oleh Kepala Rutan Kelas IIB Pangkalan Brandan, Bapak<strong> </strong>Akhmalun Ikhsan, beserta jajaran pejabat struktural. Penyambutan berlangsung hangat dan dilanjutkan dengan paparan singkat mengenai kondisi rutan pasca banjir, termasuk langkah-langkah penanganan darurat yang telah dilakukan.</p>\r\n\r\n<p>Dalam kunjungan tersebut, Dirjen Pemasyarakatan Mashudi bersama rombongan meninjau langsung sejumlah area layanan dan fasilitas rutan untuk memastikan kondisi keamanan, kebersihan, serta kelayakan sarana pendukung operasional. Peninjauan dilakukan guna melihat secara langsung dampak banjir sekaligus memastikan bahwa proses pemulihan telah berjalan optimal dan tidak mengganggu pelaksanaan tugas serta pelayanan pemasyarakatan.</p>\r\n\r\n<p>Bapak Mashudi menegaskan bahwa Ditjenpas berkomitmen untuk memastikan seluruh satuan kerja pemasyarakatan tetap mampu memberikan pelayanan yang optimal, meskipun menghadapi situasi darurat akibat bencana alam. Ia mengapresiasi langkah cepat dan kesiapsiagaan jajaran Rutan Pangkalan Brandan dalam menangani dampak banjir sehingga aktivitas layanan dapat segera dipulihkan.</p>\r\n\r\n<p>&ldquo;Kunjungan ini bertujuan untuk memastikan bahwa layanan pemasyarakatan di Rutan Pangkalan Brandan telah kembali berjalan dengan baik pasca banjir. Kami juga ingin memastikan bahwa standar keamanan, kebersihan, dan pelayanan tetap terjaga,&rdquo; ujar Mashudi.</p>\r\n\r\n<p>Senada dengan hal tersebut, Direktur Kepatuhan Internal Lilik Sujandi dan Inspektur Wilayah II Ian Fidhianto turut menekankan pentingnya kepatuhan terhadap standar operasional prosedur serta pengawasan internal, terutama dalam situasi pasca bencana. Sementara itu, Direktur Sistem Penilaian Pembinaan Kadek Anton Budiharta menyoroti pentingnya kesinambungan program pembinaan agar tetap berjalan secara terukur dan sesuai ketentuan.</p>\r\n\r\n<p>Kepala Kantor Wilayah Ditjenpas Sumatera Utara, Yudi Suseno, menyampaikan bahwa pihaknya akan terus melakukan pendampingan dan koordinasi dengan Rutan Pangkalan Brandan guna memastikan proses pemulihan berjalan menyeluruh. Ia juga mengapresiasi sinergi antara Kanwil, Ditjenpas, dan jajaran rutan dalam menghadapi situasi pasca banjir.</p>\r\n\r\n<p>Sementara itu, Kepala Rutan Pangkalan Brandan, Akhmalun Ikhsan, menyampaikan terima kasih atas perhatian dan kunjungan pimpinan Ditjenpas beserta jajaran. Ia menegaskan bahwa seluruh pegawai Rutan Pangkalan Brandan berkomitmen untuk terus meningkatkan kesiapsiagaan serta memastikan pelayanan pemasyarakatan tetap berjalan dengan aman dan optimal.</p>\r\n\r\n<p>&ldquo;Kunjungan ini menjadi motivasi bagi kami untuk terus berbenah dan meningkatkan kualitas layanan, khususnya pasca banjir. Kami berkomitmen menjaga stabilitas operasional rutan sesuai arahan pimpinan,&rdquo; ungkap Akhmalun Ikhsan.</p>\r\n\r\n<p>Melalui kunjungan kerja ini, Ditjenpas berharap Rutan Pangkalan Brandan dapat terus menjaga kualitas layanan pemasyarakatan, meningkatkan mitigasi risiko bencana, serta memperkuat koordinasi lintas sektor guna menghadapi berbagai tantangan ke depan.</p>\r\n', '20260111202156_DSC07491.jpg', 'Humas Rutan', '2026-01-11 13:21:56');

-- --------------------------------------------------------

--
-- Table structure for table `pengaduan_online`
--

CREATE TABLE `pengaduan_online` (
  `id` int NOT NULL,
  `jenis_layanan` enum('Pengaduan','Informasi') NOT NULL,
  `nama_pelapor` varchar(100) NOT NULL,
  `nik` varchar(20) DEFAULT NULL,
  `jenis_kelamin` varchar(20) DEFAULT NULL,
  `alamat` text,
  `no_wa` varchar(20) NOT NULL,
  `deskripsi` text NOT NULL,
  `status` enum('Masuk','Diproses','Selesai') DEFAULT 'Masuk',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `pengaduan_online`
--

INSERT INTO `pengaduan_online` (`id`, `jenis_layanan`, `nama_pelapor`, `nik`, `jenis_kelamin`, `alamat`, `no_wa`, `deskripsi`, `status`, `created_at`) VALUES
(3, 'Pengaduan', 'Faiz Syukri Arta', '1205200605030001', 'Laki-laki', 'pondok 13 kampung', '6285359416178', 'gvhvu', 'Masuk', '2026-01-07 07:16:51');

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
(7, 'Layanan Integrasi CB, PB, CMB &Asimilasi', '<ul>\r\n	<li>Cuti bersyarat atau CB adalah proses pembinaan di &nbsp;luar &nbsp;Rutan atau Lembaga Pemasyarakatan bagi Narapidana yang dipidana paling lama 1 (satu) tahun 6 (enam) bulan, sekurang-kurangnya telah menjalani 2/3 ( dua pertiga ) masa pidana dengan syarat sebagai berikut</li>\r\n</ul>\r\n\r\n<ol>\r\n	<li>Dipidana dengan pidana penjara paling lama 1 (satu) tahun 6 (enam) bulan</li>\r\n	<li>Telah menjalani paling sedikit 2/3 (dua per tiga) masa pidana</li>\r\n	<li>Berkelakuan baik dalam kurun waktu 6 (enam) bulan terakhir</li>\r\n	<li>CB bagi Narapidana dan Anak Pidana dapat diberikan untuk jangka waktu paling lama 6 (enam) bulan</li>\r\n	<li>Fotokopi kutipan putusan hakim dan berita acara pelaksanaan putusan pengadilan dan laporan perkembangan pembinaan yang dibuat oleh wali pemasyarakatan/ hasil assessment resiko dan assessment kebutuhan yang dilakukan oleh asesor dan laporan penelitian kemasyarakatan yang dibuat oleh Pembimbing Kemasyarakatan yang diketahui oleh Kepala Bapas.</li>\r\n	<li>Surat pemberitahuan ke Kejaksaan Negeri tentang rencana pemberian CB terhadap Narapidana dan Anak Didik Pemasyarakatan yang bersangkutan</li>\r\n	<li>Salinan register F, salinan daftar perubahan dari Kepala Lapas dan surat pernyataan &nbsp;dari Narapidana atau Anak Didik Pemasyarakatan tidak akan melakukan perbuatan melanggar hukum</li>\r\n	<li>Surat jaminan kesanggupan dari pihak keluarga yang diketahui oleh lurah, kepala desa yang menyatakan Narapidana atau Anak Didik Pemasyarakatan tidak akan melarikan diri dan &nbsp;melakukan perbuatan melanggar hukum, serta membantu dalam membimbing dan mengawasi Narapidana/anak didik pemasyarakatan selama mengikuti program CB. Untuk mendapatkan surat jaminan silahkan download surat di bawah ini!!</li>\r\n</ol>\r\n', NULL, '20260106104019_SJKK_GRATIS_BARU_1.pdf');

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
(3, 'SELAMAT DATANG DI RUTAN KELAS IIB PANGKALAN BRANDAN', '20251230144940_rumah_tahanan_negara_kelas_iib_pngkalan_berandan.png', ''),
(4, 'Jadwal Kunjungan', '20260107113956_KEMENTERIAN_IMIGRASI_DAN_PERMASYARAKATAN.png', ''),
(5, 'Slider 2026-01-07 14:39', '20260107143919_testttttttt.jpeg', '#');

-- --------------------------------------------------------

--
-- Table structure for table `surat_jaminan`
--

CREATE TABLE `surat_jaminan` (
  `id` int NOT NULL,
  `nama_pengirim` varchar(100) NOT NULL,
  `nik` varchar(20) NOT NULL,
  `no_wa` varchar(20) NOT NULL,
  `file_surat` varchar(255) NOT NULL,
  `status` enum('Pending','Dibalas') DEFAULT 'Pending',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `surat_jaminan`
--

INSERT INTO `surat_jaminan` (`id`, `nama_pengirim`, `nik`, `no_wa`, `file_surat`, `status`, `created_at`) VALUES
(1, 'Faiz Syukri Arta', '1205200605030001', '6285359416178', '20260108092624_SURAT_20260106104019_SJKK_GRATIS_BARU_1.pdf', 'Dibalas', '2026-01-08 02:26:24'),
(2, 'Alief', '1205200605030001', '6289687120457', '20260108094845_SURAT_20260106104019_SJKK_GRATIS_BARU_1.pdf', 'Dibalas', '2026-01-08 02:48:45');

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
-- Table structure for table `wbp_bebas`
--

CREATE TABLE `wbp_bebas` (
  `id` int NOT NULL,
  `nama_wbp` varchar(255) NOT NULL,
  `tgl_ekspirasi` date NOT NULL,
  `keterangan` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `wbp_bebas`
--

INSERT INTO `wbp_bebas` (`id`, `nama_wbp`, `tgl_ekspirasi`, `keterangan`, `created_at`) VALUES
(1, 'IBNU TAIMYAH ALS IBNU', '2026-02-01', 'BEBAS BIASA', '2025-12-31 17:21:36'),
(31, 'SUHERI', '2026-04-01', 'BEBAS BIASA', '2026-01-05 11:58:54'),
(32, 'MUHAMMAD RISKY', '2026-04-01', 'BEBAS BIASA', '2026-01-05 11:58:54'),
(33, 'CHRISTOFEL PANGIHUTAN PURBA ALS WES', '2026-04-01', 'BEBAS BIASA', '2026-01-05 11:58:54'),
(34, 'ROMA RIO', '2026-04-01', 'PEMBEBASAN BERSYARAT', '2026-01-05 11:58:54'),
(35, 'SYARIF HIDAYATULLAH', '2026-04-01', 'PEMBEBASAN BERSYARAT', '2026-01-05 11:58:54'),
(36, 'KELANA PUTRA ALS PUTRA', '2026-12-01', 'TEKEN SUBSIDER', '2026-01-05 11:58:54'),
(37, 'RANO WIDIARI ALS ARI', '2026-12-01', 'TEKEN SUBSIDER', '2026-01-05 11:58:54'),
(38, 'RIDHO SAPUTRA', '2026-01-13', 'TEKEN SUBSIDER', '2026-01-05 11:58:54'),
(39, 'MUHAMMAD IKHWANUL ANSHARI', '2026-01-14', 'TEKEN SUBSIDER', '2026-01-05 11:58:54'),
(40, 'AHMAD', '2026-01-15', 'BEBAS BIASA', '2026-01-05 11:58:54'),
(41, 'MUHAMMAD SIDDIK GINTING', '2026-01-15', 'BEBAS BIASA', '2026-01-05 11:58:54'),
(42, 'UJANG S HANDOKO', '2026-01-17', 'PEMBEBASAN BERSYARAT', '2026-01-05 11:58:54'),
(43, 'ADITYA PRADANA ALS ADIT ', '2026-01-18', 'BEBAS BIASA', '2026-01-05 11:58:54'),
(44, 'SIGIT PRAWOTO', '2026-01-19', 'BEBAS BIASA', '2026-01-05 11:58:54'),
(45, 'RIADI ALS ADI', '2026-01-22', 'TEKEN SUBSIDER', '2026-01-05 11:58:54'),
(46, 'ABDUL RAHIM', '2026-01-22', 'PEMBEBASAN BERSYARAT', '2026-01-05 11:58:54'),
(47, 'YUSUF', '2026-01-23', 'BEBAS BIASA', '2026-01-05 11:58:54'),
(48, 'SATRIA BAGUS PRATAMA', '2026-01-25', 'PEMBEBASAN BERSYARAT', '2026-01-05 11:58:54'),
(49, 'ANDRE JOSTEN SIRAIT', '2026-01-25', 'PEMBEBASAN BERSYARAT', '2026-01-05 11:58:54'),
(50, 'KIKI YULANDA', '2026-01-25', 'PEMBEBASAN BERSYARAT', '2026-01-05 11:58:54'),
(51, 'WAWAN M NUR', '2026-01-27', 'BEBAS BIASA', '2026-01-05 11:58:54'),
(52, 'JULIANTO ', '2026-01-28', 'BEBAS BIASA', '2026-01-05 11:58:54'),
(53, 'MAULANA DEWANDA', '2026-01-29', 'TEKEN SUBSIDER', '2026-01-05 11:58:54'),
(54, 'JOJON', '2026-01-29', 'CUTI BERSYARAT', '2026-01-05 11:58:54'),
(55, 'JANUARI ANARKI PASARIBU ALS NARKI', '2026-01-31', 'BEBAS BIASA', '2026-01-05 11:58:54');

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
(1, 480, '2026-01-27 03:38:28');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `gallery`
--
ALTER TABLE `gallery`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kunjungan_online`
--
ALTER TABLE `kunjungan_online`
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
-- Indexes for table `pengaduan_online`
--
ALTER TABLE `pengaduan_online`
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
-- Indexes for table `surat_jaminan`
--
ALTER TABLE `surat_jaminan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wbp_bebas`
--
ALTER TABLE `wbp_bebas`
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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `kunjungan_online`
--
ALTER TABLE `kunjungan_online`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `litmas_data`
--
ALTER TABLE `litmas_data`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=119;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `news`
--
ALTER TABLE `news`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `pengaduan_online`
--
ALTER TABLE `pengaduan_online`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `profiles`
--
ALTER TABLE `profiles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `sliders`
--
ALTER TABLE `sliders`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `surat_jaminan`
--
ALTER TABLE `surat_jaminan`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `wbp_bebas`
--
ALTER TABLE `wbp_bebas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `wbp_stats`
--
ALTER TABLE `wbp_stats`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
