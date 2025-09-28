-- STEP 1: Remove duplicates from dimension tables

-- Remove duplicates in dim_customers
WITH cte_customers AS (
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY customerid ORDER BY customerid) AS rn
    FROM dim_customers
)
DELETE FROM cte_customers
WHERE rn > 1;

-- Remove duplicates in dim_products
WITH cte_products AS (
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY stockcode ORDER BY stockcode) AS rn
    FROM dim_products
)
DELETE FROM cte_products
WHERE rn > 1;

-- Remove duplicates in dim_date
WITH cte_date AS (
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY date_id ORDER BY date_id) AS rn
    FROM dim_date
)
DELETE FROM cte_date
WHERE rn > 1;

-- STEP 2: Add Primary Keys to Dimension Tables

ALTER TABLE dim_customers
    ADD CONSTRAINT PK_dim_customers PRIMARY KEY (customerid);

ALTER TABLE dim_products
    ADD CONSTRAINT PK_dim_products PRIMARY KEY (stockcode);

ALTER TABLE dim_date
    ADD CONSTRAINT PK_dim_date PRIMARY KEY (date_id);

-- STEP 3: Add Foreign Keys to Fact Table

ALTER TABLE fact_sales
    ADD CONSTRAINT FK_fact_customers
    FOREIGN KEY (customerid)
    REFERENCES dim_customers(customerid);

ALTER TABLE fact_sales
    ADD CONSTRAINT FK_fact_products
    FOREIGN KEY (stockcode)
    REFERENCES dim_products(stockcode);

ALTER TABLE fact_sales
    ADD CONSTRAINT FK_fact_date
    FOREIGN KEY (date_id)
    REFERENCES dim_date(date_id);
