<h1> Kelompok 6 - Qumatic </i></h1>

<h2>Deskripsi</h2>
<p>Di samping sebagai pemenuhan proyek UTS mata kuliah Pemrograman Mobile, aplikasi Qumatic atau Quiz Mafortic ini juga ditujukan untuk para mahasiswa baru mengetes kemampuan mereka sebelum lanjut ke jenjang yang lebih tinggi.</p>

<h2>Struktur Proyek</h2>
Proyek ini terdiri dari beberapa file dan fitur utama:

### `main.dart` - Core Flutter App
- Memuat struktur utama aplikasi Flutter.
- Menggunakan font dari Google Fonts.
- Menampilkan `SplashScreen` sebagai halaman pembuka.

---

### `QuizPage` (StatefulWidget)

Berisi logika utama kuis, seperti pertanyaan, jawaban, skor, feedback visual, hingga dialog akhir kuis.

#### Fitur Utama:

1. **Navigasi Soal**
   - Menampilkan pertanyaan satu per satu.
   - Otomatis pindah ke soal selanjutnya setelah dijawab.

2. **Feedback Jawaban**
   - Menampilkan ikon ✅ atau ❌ setelah menjawab.
   - Mengubah warna tombol berdasarkan jawaban yang dipilih.

3. **Streak Badge**
   - Mendapatkan lencana (badge) setelah 3 jawaban benar berturut-turut.
   - Terdapat popup lencana lucu sebagai reward.

4. **Skor & Dialog Akhir**
   - Menampilkan skor akhir setelah semua soal selesai.
   - Terdapat konfirmasi saat ingin keluar sebelum menyelesaikan kuis.

5. **Konfirmasi Aksi**
   - Pop-up saat ingin menyelesaikan atau keluar dari kuis.

<h1>Anggota Tim</h1>
    <table>
        <thead>
            <tr>
                <th>NIM</th>
                <th>Nama</th>
                <th>Kelas</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>23091397078</td>
                <td>Ivan Budi Saputra</td>
                <td>2023 C</td>
            </tr>
            <tr>
                <td>23091397088</td>
                <td>Savinka Krizanantha J. A.</td>
                <td>2023 C</td>
            </tr>
            <tr>
                <td>23091397102</td>
                <td>Raditya Bani Ainur Ridho</td>
                <td>2023 C</td>
            </tr>
        </tbody>
    </table>
