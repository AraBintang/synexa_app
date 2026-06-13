# TODO - Login Google Sign-In + Registrasi/Profile

## Step 1

- [ ] Tambahkan dependency Firebase Auth + Google Sign-In ke `pubspec.yaml`.

## Step 2

- [ ] Buat setup Firebase (instruksi dan checklist) untuk Android (google-services.json).

## Step 3

- [ ] Implementasi Auth layer:
  - [ ] Buat `AuthController` (login/logout, cek sesi, simpan info profil ke storage lokal/Firestore jika ada).

## Step 4

- [x] Buat UI:
  - [x] `LoginPage` (tambahkan menu registrasi jika belum punya akun + form email/password untuk akun terdaftar)
  - [x] `RegisterPage` (email & password)

## Step 5

- [x] Integrasi ke `main.dart`:
  - [x] Tambahkan route `/register`
  - [x] Jika belum login → tampilkan `LoginPage` (sudah ada)
  - [x] Jika sudah login → tampilkan `MainPage` (sudah ada)

## Step 6

- [ ] Integrasi profil:
  - [ ] `ProfilePage` menampilkan nama/email dari user Firebase.

## Step 7

- [ ] Buat tombol Logout.

## Step 8

- [ ] Jalankan `flutter clean && flutter pub get` dan compile.
