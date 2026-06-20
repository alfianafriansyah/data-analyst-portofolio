-- =========================================================
-- SuryaHub Customer Behavior Analysis — SQL Queries
-- Semua angka hasil query ini sudah diverifikasi cocok
-- dengan laporan analyst (Final_Project_Alfian_Afriansyah.pdf)
-- =========================================================

-- ---------------------------------------------------------
-- A. DEMOGRAFI
-- ---------------------------------------------------------

-- Total transaksi pelanggan perempuan (cek distribusi gender: 53% female / 47% male)
SELECT COUNT(*)
FROM Salinan_dari_Data_SuryaHub sddsh
WHERE Gender = "Female";


-- ---------------------------------------------------------
-- B. GEOGRAFI
-- ---------------------------------------------------------

-- 5 kota dengan jumlah pelanggan terbanyak
-- Hasil: Makassar (95) > Jakarta (89) > Bandung (82) > Surabaya/Medan (78)
SELECT
    Location,
    COUNT(DISTINCT Customer_ID) AS total_customers
FROM Salinan_dari_Data_SuryaHub sddsh
GROUP BY Location
ORDER BY total_customers DESC
LIMIT 5;


-- ---------------------------------------------------------
-- C. LOYALTY PROGRAM
-- ---------------------------------------------------------

-- Apakah anggota program loyalitas (Customer_Loyalty_Program_Member = TRUE)
-- memiliki rata-rata pembelian lebih tinggi / lebih sering dibanding non-anggota?
-- Hasil: Member Rp4.104.058 (6,68x) vs Non-Member Rp4.375.335 (6,99x)
-- -> Non-member lebih unggul di kedua metrik
SELECT
    Customer_Loyalty_Program_Member,
    AVG(Purchase_Amount) AS avg_amount,
    AVG(Frequency_of_Purchase) AS avg_frequency
FROM Salinan_dari_Data_SuryaHub sddsh
GROUP BY Customer_Loyalty_Program_Member;

-- Berapa banyak pelanggan dengan Brand_Loyalty = 5, dan apakah mereka pakai diskon?
-- Hasil: 60 orang tidak pakai diskon, 46 orang pakai diskon
-- -> Pelanggan paling loyal tidak butuh insentif harga
SELECT
    Discount_Used,
    COUNT(*) AS total
FROM Salinan_dari_Data_SuryaHub sddsh
WHERE Brand_Loyalty = 5
GROUP BY Discount_Used;


-- ---------------------------------------------------------
-- D. HIGH-VALUE CUSTOMERS
-- ---------------------------------------------------------

-- 10 pelanggan dengan total pembelian tertinggi, beserta lokasi/channel/brand loyalty-nya
-- Hasil: 6 dari 10 top spender punya Brand_Loyalty <= 3 (high spending != high loyalty)
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


-- ---------------------------------------------------------
-- E. PURCHASE INTENT
-- ---------------------------------------------------------

-- Rata-rata nilai & frekuensi pembelian per kategori Purchase_Intent
-- Hasil: Planned = avg spending tertinggi; Need-based = frekuensi tertinggi (~26% transaksi);
--        Impulsive = avg spending terendah (berlawanan dengan asumsi umum)
SELECT
    Purchase_Intent,
    AVG(Purchase_Amount) AS rata_rata_pembelian,
    AVG(Frequency_of_Purchase) AS rata_rata_frekuensi
FROM Salinan_dari_Data_SuryaHub sddsh
GROUP BY Purchase_Intent;


-- ---------------------------------------------------------
-- F. PURCHASE CHANNEL
-- ---------------------------------------------------------

-- Perbandingan pola pembelian antar channel (Online, In-Store, Mixed)
-- Hasil: Mixed Channel = avg spending tertinggi & kontribusi transaksi tertinggi (36,4%)
--        In-Store = frekuensi tertinggi (rata-rata 7,14x)
SELECT
    Purchase_Channel,
    AVG(Purchase_Amount) AS avg_amount,
    AVG(Frequency_of_Purchase) AS avg_frequency
FROM Salinan_dari_Data_SuryaHub sddsh
GROUP BY Purchase_Channel
ORDER BY avg_amount DESC;
