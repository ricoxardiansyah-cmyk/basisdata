p01_lingkungan_25430090.sql
-- ========================================================
-- Laporan Pertemuan 1: Pengaturan Lingkungan Basis Data
-- Pengembang: Rico Ardiansyah
-- NIM: 25430090
-- ========================================================

-- 1. Verifikasi Versi & SQL Mode
SELECT VERSION(), CURRENT_USER();
SELECT @@sql_mode;

-- 2. Pengamanan Akun Root
ALTER USER 'root'@'localhost' IDENTIFIED BY 'Ricox09';
ALTER USER 'root'@'127.0.0.1' IDENTIFIED BY 'Ricox09';
ALTER USER 'root'@'::1' IDENTIFIED BY 'Ricox09';

-- 3. Membuat Basis Data Latihan & Akun Kerja
CREATE DATABASE kopma_090 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'mhs_090'@'localhost' IDENTIFIED BY 'Ricox09';
GRANT ALL PRIVILEGES ON kopma_090.* TO 'mhs_090'@'localhost';
FLUSH PRIVILEGES;

-- 4. Membuat Basis Data Proyek Perpustakaan & Akun Developer
CREATE DATABASE perpus_090 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'dev_090'@'localhost' IDENTIFIED BY 'DevPassword#090';
GRANT ALL PRIVILEGES ON perpus_090.* TO 'dev_090'@'localhost';
FLUSH PRIVILEGES;