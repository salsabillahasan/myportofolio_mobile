# MyPortfolio Mobile

[![CI](https://github.com/salsabillahasan/myportofolio_mobile/actions/workflows/main.yaml/badge.svg)](https://github.com/salsabillahasan/myportofolio_mobile/actions/workflows/main.yaml)

## About the Project

MyPortfolio Mobile adalah aplikasi portofolio pribadi yang saya buat menggunakan Flutter dan Dart untuk mata kuliah Pemrograman Berbasis Platform (PBP). Proyek ini merupakan pengembangan dari website portofolio yang sebelumnya saya buat menggunakan Django, tetapi aplikasi Flutter disimpan dalam repository yang terpisah.

Saat ini aplikasi menampilkan halaman utama dan data portofolio dari Django REST Framework. Pengguna dapat melihat daftar Project dan Education, membuka detailnya, serta menambahkan data setelah login.

## Features

Fitur yang sudah saya implementasikan:

- Menampilkan informasi diri dan menu portofolio.
- Menampilkan daftar Project dan Education dari API Django, lalu membuka detailnya.
- Mengizinkan semua orang melihat data, tetapi mewajibkan login untuk menambah Project atau Education.
- Mengirim permintaan tulis ke Django menggunakan token autentikasi.
- Memperbarui daftar data dengan menarik layar ke bawah.
- Menjalankan pemeriksaan kode, tes, dan build APK melalui GitHub Actions.
- Menambahkan automated test untuk tampilan dan integrasi API Education.

## Technologies Used

- Flutter
- Dart
- Material Design
- Visual Studio Code
- Git dan GitHub

## Setup and How to Run

Untuk menjalankan proyek ini, pastikan Flutter SDK dan Google Chrome sudah terpasang. Aplikasi juga memerlukan backend Django yang sedang berjalan. Repository backend tersedia di [salsabillahasan/myportofolio](https://github.com/salsabillahasan/myportofolio).

1. Clone dan jalankan backend Django mengikuti petunjuk di README repository backend. Secara default, backend berjalan di `http://localhost:8000`.
2. Clone repository Flutter ini dan buka foldernya di VS Code atau terminal:

   ```bash
   git clone https://github.com/salsabillahasan/myportofolio_mobile.git
   cd myportofolio_mobile
   ```

3. Jalankan `flutter pub get` untuk memasang dependency proyek.
4. Jalankan `dart run build_runner build --delete-conflicting-outputs` untuk membuat file serialisasi JSON.
5. Jalankan aplikasi di Chrome dengan perintah berikut:

   ```bash
   flutter run -d chrome --dart-define=API_BASE_URL=http://localhost:8000
   ```

Untuk Android Emulator lokal, gunakan `http://10.0.2.2:8000` sebagai nilai `API_BASE_URL`. Endpoint Education yang dipakai aplikasi adalah `GET` dan `POST /api/v1/education/`. GET bisa digunakan tanpa login, sedangkan POST memerlukan token login.

Untuk memeriksa kode dan menjalankan pengujian, gunakan:

- `flutter analyze` untuk memeriksa masalah pada kode.
- `flutter test` untuk menjalankan automated widget tests.

Selama pengerjaan, saya menggunakan Chrome untuk menjalankan dan memeriksa tampilan aplikasi. Saya belum melakukan pengujian langsung menggunakan emulator atau perangkat Android.

## Refleksi

### Tugas 7

**1. Jelaskan apa yang dimaksud dengan widget tree pada Flutter dan bagaimana hubungan induk-anak (parent-child) bekerja antar-widget!**

Widget tree itu bisa dibilang susunan widget yang saling terhubung di Flutter. Jadi, ada widget yang berada di dalam widget lain. Widget yang membungkus disebut parent, sedangkan yang ada di dalamnya disebut child. Contohnya di project saya, `Scaffold` punya bagian `body` yang di dalamnya masih ada `Padding`, `Column`, `Row`, dan widget lainnya. Jadi, tampilan aplikasi sebenarnya terbentuk dari banyak widget yang disusun menjadi satu. Hubungan parent-child ini juga berpengaruh ke tampilan, misalnya `Row` membuat widget tersusun ke samping, sedangkan `Column` membuatnya tersusun ke bawah.

**2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya masing-masing!**

Di project ini, saya menggunakan `MyApp` sebagai widget utama dan `MyHomePage` sebagai halaman utamanya. Lalu ada `MaterialApp` untuk mengatur aplikasi, seperti tema warna dan halaman awal, `Scaffold` sebagai kerangka halaman, serta `AppBar` untuk menampilkan judul di atas. Untuk mengatur posisi tampilannya, saya menggunakan `Row` supaya widget tersusun ke samping, `Column` supaya tersusun ke bawah, dan `GridView.count` supaya tombol menu tersusun dalam bentuk grid.

Selain itu, saya menggunakan `Padding` dan `SizedBox` untuk mengatur jarak, `Center` untuk membuat widget berada di tengah, serta `Container` untuk mengatur ruang dalam widget. Ada juga `Text` untuk menampilkan tulisan, `Icon` untuk menampilkan ikon, dan `Card` untuk membuat kartu informasi. Untuk tombol menu, saya menggunakan `Material` sebagai dasar tampilannya, `InkWell` supaya tombol bisa ditekan, dan `SnackBar` untuk menampilkan pesan ketika tombol diklik. Saya juga membuat `InfoCard` untuk menampilkan NPM, nama, dan kelas, serta `ItemCard` untuk menampilkan tombol menu. Sementara itu, `ItemHomepage` bukan widget, tetapi class untuk menyimpan data menu seperti nama, ikon, dan warna.

**3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini umumnya digunakan sebagai root widget pada aplikasi Flutter!**

`MaterialApp` digunakan untuk mengatur bagian utama aplikasi Flutter, seperti judul, tema warna, dan halaman yang pertama kali muncul. Di project saya, `MaterialApp` ada di `main.dart` dan digunakan untuk mengatur warna aplikasi sekaligus menampilkan `MyHomePage`. Widget ini biasanya dijadikan root karena pengaturan yang ada di dalamnya bisa digunakan oleh widget lain. Jadi, kita nggak perlu mengatur tema atau hal-hal dasar aplikasi berulang kali di setiap halaman.

**4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget! Kapan kita sebaiknya memilih StatelessWidget dan kapan harus menggunakan StatefulWidget?**

Perbedaan `StatelessWidget` dan `StatefulWidget` ada pada cara keduanya mengelola state. `StatelessWidget` cocok digunakan kalau widget tidak perlu menyimpan perubahan state sendiri, sedangkan `StatefulWidget` digunakan kalau ada state yang perlu berubah dan memengaruhi tampilan. Contohnya, di project saya `MyHomePage` menggunakan `StatelessWidget` karena hanya menampilkan informasi diri dan tombol menu yang sudah ditentukan. Walaupun tombolnya bisa ditekan dan memunculkan `SnackBar`, halaman tersebut tidak perlu menyimpan perubahan state sendiri. Kalau nanti saya membuat fitur seperti counter yang angkanya berubah setiap kali tombol ditekan, barulah `StatefulWidget` lebih cocok digunakan.

**5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di dalam metode build?**

`BuildContext` itu bisa dipahami sebagai informasi tentang posisi sebuah widget dalam susunan widget Flutter. Jadi, lewat `context`, widget bisa mengambil informasi yang dibutuhkan dari bagian aplikasi di atasnya. Contohnya di project saya, `Theme.of(context)` digunakan untuk mengambil warna tema, sedangkan `MediaQuery.of(context)` digunakan untuk mengetahui ukuran layar. Saya juga menggunakan `ScaffoldMessenger.of(context)` untuk menampilkan `SnackBar` ketika tombol ditekan. Jadi, `context` membantu widget mendapatkan informasi dan menggunakan fitur yang tersedia di aplikasi.

**6. Jelaskan konsep hot reload di Flutter dan apa perbedaannya dengan hot restart! Kapan kita tidak bisa hanya mengandalkan hot reload dan harus melakukan hot restart atau full restart?**

`Hot reload` digunakan supaya perubahan kode bisa langsung terlihat tanpa harus menjalankan aplikasi dari awal. Biasanya state aplikasi yang sedang berjalan juga tetap tersimpan. Sedangkan `hot restart` akan menjalankan ulang aplikasi Flutter dan mengembalikan state ke kondisi awal.

Misalnya, saat saya mengubah warna tombol atau tulisan, biasanya cukup menggunakan hot reload untuk melihat hasilnya. Tapi kalau ada perubahan pada bagian kode yang hanya dijalankan ketika aplikasi dimulai, hot reload belum tentu bisa menerapkannya, jadi perlu hot restart. Kalau perubahannya berkaitan dengan konfigurasi native atau dependency tertentu, terkadang aplikasi harus dihentikan dan dijalankan lagi menggunakan full restart.

### Tugas 8

**1. Jelaskan perbedaan Navigator.push(), Navigator.pushReplacement(), dan Navigator.pop(). Metode apa yang digunakan untuk membuka formulir dari kartu aksi? Jelaskan juga bagaimana opsi Home di Drawer membawa pengguna kembali ke halaman utama.**

Menurut saya, perbedaan ketiganya ada di cara Flutter mengatur halaman. `Navigator.push()` digunakan untuk membuka halaman baru, tetapi halaman sebelumnya masih disimpan. Kalau `Navigator.pushReplacement()`, halaman yang sedang dibuka akan diganti dengan halaman baru. Sedangkan `Navigator.pop()` digunakan untuk menutup halaman yang sedang dibuka dan kembali ke halaman sebelumnya.

Di aplikasi saya, `Navigator.push()` digunakan saat menekan kartu Tambah Education di Home, jadi pengguna masih bisa kembali ke Home. Sementara itu, menu di Drawer menggunakan `Navigator.pushReplacement()` untuk berpindah halaman, termasuk saat memilih Home untuk kembali ke halaman utama.

**2. Bagaimana susunan Scaffold, AppBar, dan Drawer membantu menjaga struktur halaman tetap konsisten? Berikan satu contoh penggunaan warna tema portofolio di lebih dari satu halaman.**

Menurut saya, ketiga widget ini membuat tampilan setiap halaman jadi lebih konsisten. `Scaffold` digunakan sebagai kerangka halaman, `AppBar` untuk menampilkan judul di bagian atas, dan `Drawer` untuk menyediakan menu navigasi. Jadi, walaupun isi halamannya berbeda, pengguna tetap bisa menemukan bagian yang sama di setiap halaman.

Contohnya, halaman Home dan Add Education Form sama-sama menggunakan warna utama dari `Theme.of(context).colorScheme.primary` pada `AppBar`. Dengan begitu, warna tampilannya tetap sama dan tidak perlu diatur satu per satu secara manual.

**3. Mengapa tata letak tersebut dipilih untuk formulir? Jelaskan peran widget pengatur jarak dan widget penggulir ketika ruang layar terbatas.**

Saya memilih `Column` karena ingin input formulir tersusun dari atas ke bawah supaya lebih mudah diisi. Saya juga menggunakan `Padding` agar input tidak terlalu menempel ke pinggir layar dan `SizedBox` untuk memberi jarak antarinput supaya tampilannya tidak terlalu rapat.

Karena Education Form memiliki cukup banyak input, saya menggunakan `SingleChildScrollView` supaya halaman tetap bisa digeser ke bawah, terutama saat dibuka di layar kecil. Saya juga sempat mengalami masalah *overflow* di halaman Home setelah menambah kartu Education. Setelah diperbaiki dengan `SingleChildScrollView`, halaman Home bisa menampilkan kartu yang sebelumnya tidak muat dalam satu layar.

**4. Apa peran GlobalKey<FormState>, validator, dan validate() saat tombol Simpan ditekan? Berikan satu contoh nilai yang ditolak oleh validasi dan jelaskan mengapa memilih jenis input atau papan ketik saja belum cukup.**

Dari yang saya pahami, `GlobalKey<FormState>` digunakan supaya kita bisa mengakses form dan menjalankan validasinya. `validator` berisi aturan untuk mengecek input, sedangkan `validate()` digunakan untuk menjalankan pengecekan tersebut ketika tombol Simpan ditekan.

Contohnya, pada field Institution, saya membuat validasi supaya pengguna tidak bisa mengosongkan kolom atau hanya mengisinya dengan spasi. Kalau input tidak sesuai, pesan error akan muncul dan ringkasan tidak ditampilkan. Saya juga menggunakan `TextInputType.url` untuk input Thumbnail URL, tetapi ternyata itu hanya mengatur jenis keyboard yang digunakan. Jadi, tetap perlu `validator` supaya aplikasi bisa memeriksa apakah URL yang dimasukkan sudah sesuai format.

### Tugas 9

**1. Mengapa kita menggunakan `@JsonSerializable(fieldRename: FieldRename.snake)` dan `@JsonKey(includeToJson: false)` daripada langsung menggunakan `Map<String, dynamic>`? Berikan contoh bug yang bisa dicegah.**

Menurut saya, `@JsonSerializable` digunakan supaya Flutter lebih mudah mengubah data menjadi JSON dan membaca data dari Django. Jadi, kita tidak perlu mengatur setiap field secara manual. `FieldRename.snake` juga membantu menyesuaikan nama field yang berbeda antara Flutter dan Django. Contohnya, di Flutter menggunakan `fieldOfStudy`, sedangkan di Django menggunakan `field_of_study`. Kalau namanya tidak sesuai, data bisa gagal terbaca atau tersimpan.

Sementara itu, `includeToJson: false` digunakan supaya ID tidak ikut dikirim ketika menambahkan Education baru, karena ID sudah dibuat oleh Django. Jadi, penggunaan model ini membantu mengurangi kesalahan dibandingkan membuat data JSON sendiri setiap kali mengirim request.

**2. Mengapa Future perlu dibuat di `initState()` dan bukan langsung di `build()`? Mengapa menggunakan `ApiException` daripada `null`?**

Dari yang saya pahami, `build()` bisa dijalankan berkali-kali ketika tampilan Flutter berubah. Kalau kita mengambil data Education langsung di dalam `build()`, Flutter bisa meminta data ke Django berulang kali. Karena itu, Future dibuat di `initState()` supaya pengambilan data awal cukup dilakukan sekali saat halaman dibuat.

Untuk `ApiException`, fungsinya agar kita bisa mengetahui kalau ada masalah saat mengambil data. Kalau hanya menggunakan `null`, kita jadi tidak tahu apakah datanya memang kosong atau request ke Django gagal. Dengan `ApiException`, kita bisa menampilkan pesan error yang sesuai.

**3. Apa perbedaan `SessionAuthentication` dan `TokenAuthentication`? Mengapa Flutter menggunakan token, tetapi Django tetap menggunakan session?**

Menurut saya, `SessionAuthentication` menggunakan session dan cookie untuk mengenali pengguna yang sudah login, seperti pada website Django yang saya buat sebelumnya. Sedangkan `TokenAuthentication` menggunakan token yang didapat setelah login, kemudian token tersebut dikirim setiap kali melakukan request yang membutuhkan login.

Flutter menggunakan token karena lebih mudah digunakan untuk berkomunikasi dengan API Django. Sementara itu, session tetap digunakan agar login pada website Django masih bisa berjalan seperti sebelumnya. Walaupun pengguna sudah login di Flutter, Django tetap perlu memeriksa apakah pengguna tersebut punya izin untuk menambahkan Education.

**4. Apa fungsi job `build` dan `build_apk` pada GitHub Actions? Mengapa file `*.g.dart` dimasukkan ke `.gitignore`?**

Dari yang saya pahami, job `build` digunakan untuk mengecek kode secara otomatis melalui `very_good_workflows`, seperti memeriksa format kode, menjalankan `flutter analyze`, melakukan testing, dan mengecek test coverage. Sedangkan `build_apk` digunakan untuk membuat file APK Android setelah job `build` berhasil.

File `*.g.dart` dimasukkan ke `.gitignore` karena file tersebut dibuat secara otomatis oleh `build_runner`, jadi tidak perlu disimpan di GitHub. Saat GitHub Actions berjalan, file itu bisa dibuat ulang menggunakan `build_runner` sebelum aplikasi diperiksa dan di-build.

Menurut saya, GitHub Actions yang berhasil juga belum tentu berarti aplikasi bebas dari semua bug. Kita tetap perlu mencoba aplikasinya secara langsung untuk memastikan fitur seperti login dan menambahkan Education berjalan dengan benar.


## AI Usage Disclosure

### Tugas 7

#### Tools and Purpose

Saya menggunakan ChatGPT sebagai alat bantu belajar selama mengerjakan Tutorial 08 dan Individual Assignment 7. AI digunakan untuk membantu menjelaskan konsep Flutter, memberikan panduan implementasi secara bertahap, membantu memahami pesan error, serta mendiskusikan pengujian dan struktur kode.

#### Prompting Strategy

Saya menggunakan pertanyaan yang berhubungan langsung dengan kode yang sedang saya kerjakan. Saya meminta penjelasan menggunakan bahasa sederhana, contoh dari proyek sendiri, dan perbandingan antara beberapa pendekatan.

Beberapa topik yang saya diskusikan antara lain:

1. Mengapa warna setiap tombol lebih baik disimpan sebagai atribut `Color` pada `ItemHomepage`, dibandingkan menggunakan banyak kondisi `if-else` berdasarkan nama tombol.
2. Mengapa automated widget testing masih berguna meskipun tampilan warna tombol sudah terlihat benar saat diperiksa secara manual di Chrome.
3. Bagaimana menyesuaikan widget test bawaan Flutter yang masih menguji aplikasi counter, padahal aplikasi sudah diubah menjadi halaman portofolio.

#### Parts Assisted by AI

AI membantu saya memahami pemisahan `main.dart` dan `menu.dart`, pembuatan widget `InfoCard` dan `ItemCard`, penerapan warna yang berbeda pada menu, serta penyusunan widget testing.

AI juga membantu memberikan contoh perintah Git dan menjelaskan proses commit serta push ke repository GitHub. Untuk dokumentasi, AI digunakan sebagai bantuan dalam menyusun struktur README dan merapikan penjelasan refleksi.

### Tugas 8

#### Tools and Purpose

Selama mengerjakan Tugas 8, saya menggunakan ChatGPT untuk membantu memahami materi Flutter yang masih membingungkan, terutama tentang navigasi halaman, form, dan validasi input. Saya juga menggunakan ChatGPT untuk membantu membuat Education Form berdasarkan model Education yang sebelumnya sudah saya buat di Django.

Selain itu, saya menggunakan ChatGPT ketika menemukan warning pada kode atau masalah pada tampilan aplikasi. Saya meminta penjelasan tentang penyebab masalahnya supaya bisa lebih memahami bagian yang perlu diperbaiki.

#### Prompting Strategy

Saya biasanya bertanya berdasarkan kode yang sedang saya kerjakan atau masalah yang muncul saat menjalankan aplikasi. Kalau ada bagian yang belum saya pahami, saya meminta penjelasan menggunakan bahasa sederhana dan contoh langsung dari Education Form.

Beberapa pertanyaan yang saya diskusikan antara lain:

1. Mengapa pesan error pada Institution, Degree, dan Field of Study belum muncul meskipun sudah menggunakan `validator`, serta apa perbedaan `onChanged` dan `validator`.
2. Apa perbedaan `Navigator.push()` dan `Navigator.pushReplacement()` ketika digunakan untuk membuka Education Form melalui kartu Home dan Drawer, terutama pengaruhnya terhadap tombol Back.
3. Mengapa `flutter analyze` masih menampilkan warning `unused_field` meskipun variabel untuk menyimpan input sudah dibuat.
4. Mengapa halaman Home mengalami overflow dan tidak bisa di-scroll setelah saya menambahkan kartu Tambah Education.

#### Parts Assisted by AI

ChatGPT membantu saya membuat Education Form menggunakan `StatefulWidget`, menambahkan input sesuai model Education, serta membuat pemilihan tanggal menggunakan `showDatePicker()`. AI juga membantu memberikan contoh validasi untuk input wajib, batas maksimal karakter, format URL, dan urutan tanggal.

Selain itu, ChatGPT membantu saya membuat tombol Simpan dan `AlertDialog` untuk menampilkan ringkasan data yang sudah diisi. Untuk navigasi, AI membantu menghubungkan Education Form dengan kartu di halaman Home dan menu Drawer.

Saat menemukan warning `unused_field` dan masalah overflow pada halaman Home, saya menggunakan ChatGPT untuk memahami penyebabnya dan mencoba memperbaiki kode di VS Code. Setelah itu, saya menjalankan `flutter analyze` dan melakukan pengujian langsung, seperti mencoba input kosong, tanggal yang tidak sesuai, serta URL yang tidak valid.

### Tugas 9

#### Tools and Purpose

Pada Tugas 9, saya menggunakan ChatGPT untuk membantu memahami materi integrasi Flutter dengan Django REST Framework, terutama tentang penggunaan model JSON, pengambilan data dari API, autentikasi, dan GitHub Actions.

Saya juga menggunakan ChatGPT untuk membahas beberapa bagian kode yang masih membingungkan dan membantu menyusun jawaban refleksi dengan bahasa yang lebih mudah saya pahami.

#### Prompting Strategy

Saya menggunakan ChatGPT dengan cara bertanya tentang hal-hal yang belum saya pahami selama mempelajari materi Tugas 9. Saya biasanya memberikan contoh dari fitur Education yang saya kerjakan, lalu meminta penjelasan sederhana agar lebih mudah memahami cara kerjanya.

Beberapa pertanyaan yang saya diskusikan antara lain:

1. Mengapa ID pada model Education menggunakan `includeToJson: false`, padahal ID tetap diperlukan ketika mengambil data dari Django.
2. Mengapa Future untuk mengambil data Education sebaiknya dibuat di `initState()`, bukan langsung di `build()`.
3. Apakah Flutter atau Django yang mengatur izin untuk melihat dan menambahkan Education.
4. Mengapa file `education.g.dart` dimasukkan ke `.gitignore`, padahal file tersebut diperlukan untuk menjalankan aplikasi.
5. Apakah GitHub Actions yang berhasil berarti aplikasi sudah bebas dari bug dan masih perlu diuji secara manual.
6. Apakah automated testing dan manual testing yang berhasil sudah cukup untuk memastikan fitur Education benar-benar aman.

#### Parts Assisted by AI

ChatGPT membantu saya memahami perbedaan antara data yang dikirim Flutter dan data yang diterima dari Django, terutama terkait penggunaan ID pada model Education. Saya juga mendapat penjelasan tentang `FutureBuilder`, `initState()`, dan alasan pengambilan data tidak sebaiknya dilakukan berulang kali di dalam `build()`.

Selain itu, ChatGPT membantu saya memahami perbedaan peran Flutter dan Django dalam proses login dan pemeriksaan izin pengguna. Saya juga menggunakan ChatGPT untuk mempelajari cara kerja `build_runner`, file `.g.dart`, serta hubungan antara GitHub Actions dan proses build aplikasi.

Untuk bagian pengujian, saya berdiskusi mengenai keterbatasan automated testing dan manual testing. Dari diskusi tersebut, saya memahami bahwa hasil pengujian yang berhasil belum tentu menjamin aplikasi sepenuhnya bebas dari bug.

Terakhir, ChatGPT membantu saya memahami pertanyaan refleksi Tugas 9 dan merapikan jawabannya agar lebih sederhana serta sesuai dengan pemahaman saya sebagai mahasiswa yang masih belajar Flutter.


### AI Conversation Reference

Dokumentasi percakapan dengan AI selama pengerjaan tugas dapat dilihat melalui tautan berikut:

[Dokumentasi Percakapan AI](https://ristek.link/AiChatAlsa)
