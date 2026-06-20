# SuryaHub Customer Behavior Analysis
**Data-Driven Strategy untuk Meningkatkan Revenue per Customer (Juli 2025)**

## 1. Business Problem
Tim Marketing SuryaHub membutuhkan dasar keputusan yang konkret sebelum memasuki Juli 2025. Pertanyaan utama: apakah program loyalitas yang sudah berjalan benar-benar mengubah pelanggan biasa menjadi pelanggan yang lebih sering dan lebih banyak belanja? Jika tidak, segmen mana yang seharusnya menjadi prioritas?

## 2. Data & Tools
- **Dataset:** 500 transaksi SuryaHub, periode Juni 2025 — mencakup profil pelanggan, riwayat pembelian, status loyalitas, channel transaksi, purchase intent, dan pengaruh media sosial
- **Tools:** SQL (BigQuery), Looker Studio

## 3. Scorecard

| Metrik | Nilai |
|---|---|
| Total Revenue | Rp 2,1 M |
| Total Transaksi | 500 |
| Total Customer | 499 |
| Rata-rata Transaksi | Rp 4,2 jt |

## 4. Key Findings

### A. Program Loyalitas Tidak Efektif Meningkatkan Nilai Pelanggan
| Status | Avg Spending | Frekuensi |
|---|---|---|
| Member (TRUE) | Rp 4.104.058 | 6,68x |
| Non-Member (FALSE) | Rp 4.375.335 | 6,99x |
| **Selisih** | **Rp 271.277 lebih rendah (member)** | **0,31x lebih jarang (member)** |

Non-member belanja lebih besar **dan** lebih sering dibanding member. Diperkuat oleh data Brand Loyalty score = 5: dari pelanggan paling loyal tersebut, 60 orang tidak pernah pakai diskon, hanya 46 orang yang pakai. Diskon bukan faktor pembentuk loyalitas di SuryaHub.

### B. High Spender ≠ High Loyalty
6 dari 10 pelanggan dengan pengeluaran tertinggi memiliki brand loyalty score ≤3. Dua pelanggan dengan total pengeluaran terbesar (>Rp7,7 juta) justru memiliki skor loyalitas terendah (1). Loyalty score saat ini gagal merepresentasikan nilai ekonomi pelanggan.

### C. Geografi
Makassar memiliki jumlah pelanggan terbanyak (95), mengalahkan Jakarta (89), Bandung (82), Surabaya & Medan (masing-masing 78) — berlawanan dengan asumsi umum bahwa Jakarta jadi pusat pasar e-commerce. Top 10 spender tersebar di berbagai kota (Bandung, Surabaya, Makassar, Jakarta, Papua), tidak terkonsentrasi di satu wilayah.

### D. Purchase Intent
- **Impulsive** → rata-rata spending **terendah** (berlawanan dengan asumsi umum bahwa pembeli impulsif paling responsif promosi)
- **Planned** → rata-rata spending **tertinggi**
- **Need-based** → rata-rata spending kedua tertinggi, dan frekuensi transaksi **tertinggi** (menyumbang ~26% dari total transaksi)

### E. Channel
- **Mixed Channel** (online + offline) → rata-rata spending tertinggi, kontribusi transaksi tertinggi (36,4%)
- **In-Store** → frekuensi transaksi tertinggi (rata-rata 7,14x), kontribusi 31,2%
- **Online** → kontribusi 32,4%

### F. Social Media Influence
Pengaruh High (~Rp582 jt total sales) vs None (~Rp495 jt) — selisihnya tidak cukup besar untuk disimpulkan sebagai faktor utama pendorong nilai transaksi. Perlu pengujian lebih lanjut.

## 5. SQL Queries

Query lengkap (6 query, mencakup demografi, geografi, loyalty program, high-value customers, purchase intent, dan channel) ada di [`sql/queries.sql`](./sql/queries.sql) — semuanya sudah diverifikasi hasilnya cocok dengan angka di laporan.

Contoh query kunci — perbandingan member vs non-member:

```sql
SELECT
    Customer_Loyalty_Program_Member,
    AVG(Purchase_Amount) AS avg_amount,
    AVG(Frequency_of_Purchase) AS avg_frequency
FROM Salinan_dari_Data_SuryaHub sddsh
GROUP BY Customer_Loyalty_Program_Member;
```

10 pelanggan dengan total pembelian tertinggi:

```sql
SELECT
    Customer_ID,
    SUM(Purchase_Amount) AS total_spent,
    MAX(Location) AS Location,
    MAX(Purchase_Channel) AS Channel,
    MAX(Brand_Loyalty) AS Brand_Loyalty
FROM Salinan_dari_Data_SuryaHub sddsh
GROUP BY Customer_ID
ORDER BY total_spent DESC
LIMIT 10;
```

## 6. Recommendations
1. **Redesign program loyalitas** — dari basis membership ke basis spending tier (Bronze/Silver/Gold), dengan benefit non-diskon (akses early sale, gratis ongkir, layanan prioritas)
2. **Pilot kampanye regional di Makassar** — sebagai kota dengan pelanggan terbanyak, layak mendapat pendekatan spesifik, bukan kampanye nasional seragam
3. **Penguatan cross-channel activation** — click & collect, insentif ringan untuk pelanggan single-channel agar beralih ke mixed-channel
4. **Fokus pada segmen Planned & Need-based buyer** — investasi ke product review, stok real-time, bundling; kurangi dependensi pada flash sale

## 7. Dashboard
[Lihat Dashboard di Looker Studio](https://datastudio.google.com/reporting/03f00b27-4c4c-423a-8007-570908670c09)

![Scorecard SuryaHub](./dashboard-screenshots/scorecard.png)

## 8. Files
```
├── README.md
├── sql/
│   └── queries.sql
├── dashboard-screenshots/
└── Final_Project_Alfian_Afriansyah.pdf   ← laporan analyst lengkap
```

---
**Author:** Alfian Afriansyah · alfianafriansyah@gmail.com
