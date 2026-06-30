# Creator Sales Dashboard — Portofolio untuk Posisi Design Engineer

> **Aplikasi kreator lengkap** — dibangun dari awal hingga akhir menggunakan stack yang sama dengan Gumroad: Rails 8 + Inertia + React + TypeScript + Tailwind CSS.

## Apa Ini?

Ini adalah aplikasi yang menunjukkan kemapuan **end-to-end** dari seorang Design Engineer: dari masalah kreator → desain solusi → implementasi → test → deploy → iterasi. Semua fitur dirancang dan dibangun sendiri tanpa tim atau handoff.

**Tujuan portofolio:** Menunjukkan bahwa saya bisa:
1. Mengerjakan seluruh stack (backend + frontend + infra)
2. Membuat keputusan desain yang baik untuk produk nyata
3. Menggunakan AI sebagai akselerator, bukan pengganti judgment
4. Meluncurkan dari ide ke production tanpa bantuan orang lain

## Masalah yang Diselesaikan

Kreator (penjual di platform e-commerce) perlu melihat:
- Berapa pendapatan mereka bulan ini vs bulan lalu
- Produk mana yang paling laku
- Tren penjualan harian
- Daftar transaksi terbaru
- Semua ini dalam satu dashboard yang **langsung bisa dipakai**, tanpa setup manual

## Stack

| Lapisan | Teknologi | Alasan |
|---------|-----------|--------|
| Backend | **Ruby on Rails 8** | Framework utama Gumroad — bukti bahwa saya bisa production-ready dengan Rails |
| Frontend | **React 18 + TypeScript** | Sama dengan Gumroad frontend |
| Bridge | **Inertia.js** | Satu aplikasi, bukan API terpisah — data dari Rails langsung ke React tanpa JSON API |
| CSS | **Tailwind CSS** | Utility-first, fast iteration — sama dengan Gumroad |
| Charts | **Recharts** | React-native chart library untuk visualisasi revenue |
| UI | **Radix UI** | Accessible, unstyled primitives untuk komponen |
| Deploy | **Kamal (Docker + Rails)** | Deploy production-ready dengan Docker |

## Struktur Aplikasi

```
app/
├── controllers/
│   ├── application_controller.rb       # Base controller
│   ├── concerns/                        # Shared behavior
│   └── dashboard_controller.rb          # Halaman utama — revenue + growth + daily
├── frontend/
│   ├── Pages/                           # Halaman React (Inertia)
│   │   ├── Dashboard.tsx                # Halaman utama — revenue overview
│   │   ├── Sales.tsx                    # Halaman riwayat penjualan
│   │   └── Products.tsx                 # Manajemen produk
│   ├── Layouts/                         # Layout aplikasi
│   └── entrypoints/                     # Vite entry points
├── models/
│   ├── creator.rb                       # Auth + relasi produk
│   ├── product.rb                       # Produk dengan validasi harga
│   └── sale.rb                          # Transaksi per produk
└── views/
    ├── layouts/                         # Layout Rails
    └── pwa/                             # PWA setup
```

## Fitur yang Ada

| Fitur | Status | Deskripsi |
|-------|--------|-----------|
| **Dashboard Revenue** | ✅ Selesai | Ringkasan revenue bulanan (MTD), growth %, total revenue, sales count per bulan |
| **Daily Revenue Chart** | ✅ Selesai | Data revenue 7 hari terakhir dalam format chart-ready |
| **Top 6 Products** | ✅ Selesai | Produk dengan revenue tertinggi diurutkan |
| **Recent Sales (10)** | ✅ Selesai | Transaksi terbaru dengan detail (product, buyer, amount) |

## Fitur yang Akan Datang

| Fitur | Prioritas | Estimasi | Alasan |
|-------|-----------|----------|--------|
| **Auth (login/register)** | High | 2-3 jam | Basis semua fitur — tanpa auth, semua data hanya untuk 1 creator |
| **Product CRUD** | High | 3-4 jam | Kreator harus bisa manage produk sendiri |
| **Sales History** | Medium | 2 jam | Filter + tabel penjualan lengkap |
| **Revenue Chart** | High | 3 jam | Recharts integration — visualisasi utama untuk portofolio |
| **Search + Filter** | Medium | 2 jam | Cari produk/sale di dashboard |
| **Export CSV** | Low | 1 jam | Data untuk accounting |
| **Test Suite** | High | 2 jam | Harus ada sebelum deploy |

## Cara Setup & Jalankan

### Prerequisites
- Ruby 3.x
- Node.js
- PostgreSQL (atau SQLite — lihat config)

### Setup
```bash
bundle install
npm install
bin/rails db:create db:migrate db:seed
bin/dev
```

Buka `http://localhost:3000` → lihat dashboard.

### Test
```bash
bin/rails test          # Backend
# atau
npm test                # Frontend (belum ada)
```

## Keputusan Desain

**Setiap fitur di sini punya catatan keputusan desain:** mengapa pendekatan ini dipilih, apa alternatifnya, dan apa implikasi ke user kreator. Lihat `docs/decisions/` untuk detail.

## Catatan untuk Reviewer

Aplikasi ini adalah **portofolio yang dibangun sendiri** — bukan kontribusi ke repo orang lain. Setiap baris kode ditulis dengan pemahaman bahwa ini akan digunakan sebagai bukti kemampuan dalam proses lamaran ke Gumroad.

### Yang ditunjukkan
- Kemampuan **end-to-end**: dari konsep → deploy
- Keputusan **desain** yang baik: setiap fitur punya alasan
- **AI sebagai alat**: Kimchi/GLM digunakan untuk bagian yang membosankan, bukan untuk judgment

### Yang tidak ditunjukkan
- Bawaan framework yang tidak dimodifikasi
- "Copy dari tutorial" tanpa pemahaman
- Kode yang tidak bisa dijelaskan oleh saya sendiri