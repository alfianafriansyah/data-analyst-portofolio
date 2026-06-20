-- Total Transaksi Pelanggan Perempuan
SELECT COUNT(*)
FROM Salinan_dari_Data_SuryaHub sddsh
WHERE Gender="Female";

-- 5 Kota Dengan Pembelian Terbanyak
SELECT Location, COUNT(DISTINCT sddsh.Customer_ID) AS total_customers
FROM Salinan_dari_Data_SuryaHub sddsh
GROUP BY Location
ORDER BY total_customers DESC
LIMIT 5;

-- V2
SELECT
  Location,
  COUNT(DISTINCT Customer_ID) AS total_customers
FROM Salinan_dari_Data_SuryaHub sddsh 
GROUP BY Location
ORDER BY total_customers DESC
LIMIT 5;

-- Berapa banyak pelanggan yang memiliki Brand_Loyalty = 5? Apakah mereka cenderung menggunakan diskon atau tidak?

SELECT sddsh.Discount_Used , COUNT(*) AS total
FROM Salinan_dari_Data_SuryaHub sddsh
WHERE Brand_Loyalty=5
GROUP BY Discount_Used ;

-- v2
SELECT sddsh.Discount_Used , sddsh.Brand_Loyalty, COUNT(sddsh.Discount_Used ) AS total_pembelian
FROM Salinan_dari_Data_SuryaHub sddsh 
WHERE Brand_Loyalty = 5
GROUP BY Discount_Used ;

-- Kelompokkan pelanggan berdasarkan Purchase_Intent. Di antara kategori yang ada 
-- (Impulsive, Need-based, Planned, Wants-based), siapa yang cenderung belanja lebih mahal dan
-- lebih sering? Jelaskan temuanmu.
SELECT Gender, Income_Level, Location, sddsh.Purchase_Intent, COUNT(*) AS total_pembelian
FROM Salinan_dari_Data_SuryaHub sddsh 
GROUP BY Gender 
ORDER BY total_pembelian DESC;

-- V2
SELECT sddsh.Purchase_Intent, 
	AVG(Purchase_Amount) AS rata_rata_pembelian,
	AVG(Frequency_of_Purchase) AS rata_rata_beli
FROM Salinan_dari_Data_SuryaHub sddsh
group by sddsh.Purchase_Intent ;

-- Apakah ada perbedaan pola pembelian antara channel pembelian (Online, Offline, 
-- Mixed)? Bandingkan berdasarkan Purchase_Amount dan Frequency_of_Purchase.

SELECT 
  Purchase_Channel,
  AVG(Purchase_Amount) AS avg_amount,
  AVG(Frequency_of_Purchase) AS avg_frequency
FROM Salinan_dari_Data_SuryaHub sddsh 
GROUP BY Purchase_Channel
ORDER BY avg_amount DESC;

-- Apakah anggota program loyalitas (Customer_Loyalty_Program_Member = TRUE) memiliki rata-rata pembelian yang lebih tinggi 
-- atau lebih sering dibanding non-anggota?

select *
from Salinan_dari_Data_SuryaHub sddsh ;

SELECT 
  Customer_Loyalty_Program_Member,
  AVG(Purchase_Amount) AS avg_amount,
  AVG(Frequency_of_Purchase) AS avg_frequency
FROM Salinan_dari_Data_SuryaHub sddsh 
GROUP BY Customer_Loyalty_Program_Member;

-- Siapa 10 pelanggan dengan total pembelian (Purchase_Amount) tertinggi? Apa ciri-ciri mereka (lokasi, channel, brand loyalty)?

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


