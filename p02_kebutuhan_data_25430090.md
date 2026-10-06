p02_kebutuhan_data_25430090.md
# Dokumen Kebutuhan Data Sistem Informasi Perpustakaan

**NPM:** 25430090 
**Nilai Parameter P:** 1 (Hasil dari 90 mod 9 + 1)

---

## 1. Parameter Personal Berbasis NPM
- Batas maksimal item per transaksi: 3 item
- Denda harian keterlambatan: Rp1.000 / hari
- Perkiraan volume transaksi harian: 45 transaksi / hari

---

## 2. Proses Bisnis Utama
1. **Pendaftaran Anggota Baru:** Calon anggota mendaftarkan diri, diinput oleh petugas, dan mendapatkan kartu anggota.
2. **Peminjaman Buku:** Anggota memilih buku (maksimal 3 item), petugas mencatat transaksi peminjaman.
3. **Pengembalian Buku & Pengenaan Denda:** Petugas mengecek tanggal tenggat; jika terlambat, sistem menghitung denda Rp1.000/hari per buku.
4. **Pengadaan Katalog Buku:** Petugas menginput data buku baru dan menambah jumlah stok fisik buku.

---

## 3. Entitas Kandidat
1. `Anggota`
2. `Petugas`
3. `Buku`
4. `Kategori_Buku`
5. `Peminjaman`
6. `Detail_Peminjaman`

---

## 4. Ataturan Bisnis
1. Setiap anggota wajib memiliki ID unik (`id_anggota`).
2. Anggota hanya diperbolehkan meminjam maksimal **3 item/buku** dalam satu transaksi peminjaman.
3. Denda keterlambatan pengembalian buku ditetapkan sebesar **Rp1.000 per hari** untuk setiap buku.
4. Satu transaksi peminjaman hanya dilayani oleh tepat 1 orang petugas.
5. Satu judul buku dapat memiliki beberapa jumlah stok eksemplar.
6. Masa pinjaman standar adalah 7 hari sejak tanggal transaksi peminjaman.
7. Anggota yang masih memiliki tunggakan denda tidak diizinkan melakukan peminjaman baru.
8. Data transaksi peminjaman yang telah selesai tidak boleh dihapus dari sistem untuk riwayat audit.

---

## 5. Kebutuhan Informasi
1. Laporan rekapitulasi transaksi peminjaman harian (target estimasi 45 transaksi/hari).
2. Laporan daftar anggota yang terlambat mengembalikan buku beserta akumulasi dendanya.
3. Laporan daftar buku paling sering dipinjam (*top borrowed books*).
4. Riwayat peminjaman per anggota.
5. Laporan sisa stok buku berdasarkan kategori.

---

## 6. Matriks CRUD

| Proses Bisnis | Anggota | Petugas | Buku | Kategori_Buku | Peminjaman | Detail_Peminjaman |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| Pendaftaran Anggota | **C, R, U** | R | - | - | - | - |
| Peminjaman Buku | R | R | R, U | R | **C, R** | **C, R** |
| Pengembalian & Denda | R | R | R, U | - | **R, U** | **R, U** |
| Pengadaan Katalog | - | R | **C, R, U, D** | **C, R, U** | - | - |

---

## 7. Kamus Data Awal

| Entitas | Elemen Data | Tipe Data | Keterangan | Penanggung Jawab |
| :--- | :--- | :--- | :--- | :--- |
| `Anggota` | `id_anggota` | INT | Primary Key | Admin Sistem |
| `Anggota` | `no_anggota` | VARCHAR | Nomor Unik Anggota | Petugas Pendaftaran |
| `Anggota` | `nama_anggota` | VARCHAR | Nama Lengkap (Data Pribadi) | Petugas Pendaftaran |
| `Anggota` | `no_hp` | VARCHAR | Nomor HP (Data Pribadi) | Petugas Pendaftaran |
| `Anggota` | `alamat` | TEXT | Alamat Rumah (Data Pribadi) | Petugas Pendaftaran |
| `Petugas` | `id_petugas` | INT | Primary Key | Admin Sistem |
| `Petugas` | `nama_petugas` | VARCHAR | Nama Staf | Admin HRD |
| `Petugas` | `peran` | VARCHAR | Jabatan/Akses | Admin HRD |
| `Kategori_Buku` | `id_kategori` | INT | Primary Key | Petugas Pengadaan |
| `Kategori_Buku` | `nama_kategori` | VARCHAR | Genre/Jenis Buku | Petugas Pengadaan |
| `Buku` | `id_buku` | INT | Primary Key | Petugas Pengadaan |
| `Buku` | `isbn` | VARCHAR | Kode Unik ISBN | Petugas Pengadaan |
| `Buku` | `judul` | VARCHAR | Judul Buku | Petugas Pengadaan |
| `Buku` | `pengarang` | VARCHAR | Nama Penulis | Petugas Pengadaan |
| `Buku` | `stok` | INT | Jumlah Eksemplar | Petugas Pengadaan |
| `Peminjaman` | `id_peminjaman` | INT | Primary Key | Petugas Sirkulasi |
| `Peminjaman` | `no_peminjaman` | VARCHAR | Nomor Nota Transaction | Petugas Sirkulasi |
| `Peminjaman` | `tgl_pinjam` | DATE | Tanggal Pinjam | Petugas Sirkulasi |
| `Peminjaman` | `tgl_tenggat` | DATE | Tenggat Pengembalian | Petugas Sirkulasi |
| `Detail_Peminjaman` | `id_peminjaman` | INT | Foreign Key | Petugas Sirkulasi |
| `Detail_Peminjaman` | `id_buku` | INT | Foreign Key | Petugas Sirkulasi |
| `Detail_Peminjaman` | `qty` | INT | Jumlah Dipinjam (Maks 3) | Petugas Sirkulasi |
| `Detail_Peminjaman` | `denda_terhitung` | DECIMAL | Rp1.000 x Hari Terlambat | Petugas Sirkulasi |

---

## 8. Kebutuhan Non-Fungsional & Data Pribadi
- **Identifikasi Data Pribadi:** `nama_anggota`, `no_hp`, dan `alamat`.
- **Hak Akses:** Data pribadi anggota bersifat rahasia dan hanya boleh diakses/diubah oleh **Petugas Pendaftaran** dan **Admin Sistem**. Petugas sirkulasi umum hanya dapat melihat `no_anggota` dan `nama_anggota` untuk verifikasi saat transaksi.

---

## 9. Dokumen Sumber Fiktif & Pembedahan

### Rancangan Teks Slip Peminjaman
```text
==================================================
           PERPUSTAKAAN UTAMA
        SLIP PEMINJAMAN BUKU
==================================================
No Nota     : PMJ-20261006-001
Tanggal     : 06/10/2026
Petugas     : Budi Santoso
Anggota     : A-090 (Rian Ardianto)
--------------------------------------------------
No  Judul Buku                      Qty   Tenggat
--------------------------------------------------
1.  Basis Data Lanjut               1     13/10/2026
2.  Pemrograman Web                 1     13/10/2026
--------------------------------------------------
* Catatan: Keterlambatan dikenakan denda Rp1.000/hari.
  Maksimal peminjaman adalah 3 item.

Tanda Tangan Peminjam,              Petugas,


(...................)             (...............)
==================================================