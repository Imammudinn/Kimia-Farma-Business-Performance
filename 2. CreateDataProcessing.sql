CREATE OR REPLACE TABLE `rakamin-kf-analytics-467123.kimia_farma.kf_analisa_penjualan` AS
WITH transaksi AS (
  SELECT 
    t.transaction_id,
    t.date,
    t.branch_id,
    kc.branch_name,
    kc.kota,
    kc.provinsi,
    kc.rating AS rating_cabang,
    t.customer_name,
    t.product_id,
    p.product_name,
    
    -- Harga asli dari produk
    t.price AS actual_price,
    
    -- Diskon persentase
    t.discount_percentage,

    -- Hitung persentase gross laba
    CASE 
      WHEN t.price <= 50000 THEN 0.10
      WHEN t.price <= 100000 THEN 0.15
      WHEN t.price <= 300000 THEN 0.20
      WHEN t.price <= 500000 THEN 0.25
      ELSE 0.30
    END AS persentase_gross_laba,

    -- Hitung nett_sales = harga - diskon (CAST ke NUMERIC)
    CAST(t.price * (1 - t.discount_percentage / 100) AS NUMERIC) AS nett_sales,

    -- Hitung nett_profit = nett_sales * persentase gross laba (CAST ke NUMERIC)
    CAST(
      (t.price * (1 - t.discount_percentage / 100)) *
      CASE 
        WHEN t.price <= 50000 THEN 0.10
        WHEN t.price <= 100000 THEN 0.15
        WHEN t.price <= 300000 THEN 0.20
        WHEN t.price <= 500000 THEN 0.25
        ELSE 0.30
      END
    AS NUMERIC) AS nett_profit,

    -- Rating transaksi
    t.rating AS rating_transaksi

  FROM `rakamin-kf-analytics-467123.kimia_farma.kf_final_cleaned_transactions` t
  LEFT JOIN `rakamin-kf-analytics-467123.kimia_farma.kf_cleaned_kantor_cabang` kc
    ON t.branch_id = kc.branch_id
  LEFT JOIN `rakamin-kf-analytics-467123.kimia_farma.kf_cleaned_product` p
    ON t.product_id = p.product_id
)

SELECT * FROM transaksi;
