-- Buat tabel baru untuk kf_final_transactions
CREATE OR REPLACE TABLE `rakamin-kf-analytics-467123.kimia_farma.kf_final_cleaned_transactions` AS
SELECT
  transaction_id,
  DATE(date) AS date,
  branch_id,
  customer_name,
  product_id,
  SAFE_CAST(price AS NUMERIC) AS price,
  SAFE_CAST(discount_percentage AS NUMERIC) AS discount_percentage,
  SAFE_CAST(rating AS FLOAT64) AS rating
FROM
  `rakamin-kf-analytics-467123.kimia_farma.kf_final_transaction`
WHERE
  price IS NOT NULL
  AND discount_percentage IS NOT NULL
  AND rating IS NOT NULL;

-- Buat tabel baru untuk kf_product
CREATE OR REPLACE TABLE `rakamin-kf-analytics-467123.kimia_farma.kf_cleaned_product` AS
SELECT
  product_id,
  product_name,
  product_category,
  CAST(price AS NUMERIC) AS price
FROM
  `rakamin-kf-analytics-467123.kimia_farma.kf_product`
WHERE
  price IS NOT NULL;

-- Buat tabel baru untuk kf_inventory
CREATE OR REPLACE TABLE `rakamin-kf-analytics-467123.kimia_farma.kf_cleaned_inventory` AS
SELECT
  inventory_id,
  branch_id,
  product_id,
  product_name,
  SAFE_CAST(opname_stock AS INTEGER) AS opname_stock
FROM
  `rakamin-kf-analytics-467123.kimia_farma.kf_inventory`
WHERE
  opname_stock IS NOT NULL;

-- Buat tabel baru untuk kf_kantor_cabang
CREATE OR REPLACE TABLE `rakamin-kf-analytics-467123.kimia_farma.kf_cleaned_kantor_cabang` AS
SELECT
  branch_id,
  branch_category,
  branch_name,
  kota,
  provinsi,
  SAFE_CAST(rating AS FLOAT64) AS rating
FROM
  `rakamin-kf-analytics-467123.kimia_farma.kf_kantor_cabang`
WHERE
  rating IS NOT NULL;
