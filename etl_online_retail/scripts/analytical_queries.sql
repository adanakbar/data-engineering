-- Total Sales Per Month

SELECT 
    d.year, 
    d.month, 
    SUM(f.total_amount) AS monthly_sales
FROM fact_sales f
JOIN dim_date d ON f.date_id = d.date_id
GROUP BY d.year, d.month
ORDER BY d.year, d.month;

-- Top 5 Products by Revenue

SELECT 
    p.description AS product_name, 
    SUM(f.total_amount) AS total_revenue
FROM fact_sales f
JOIN dim_products p ON f.stockcode = p.stockcode
GROUP BY p.description
ORDER BY total_revenue DESC
LIMIT 5;


-- Revenue by Country

SELECT 
    c.country, 
    SUM(f.total_amount) AS revenue
FROM fact_sales f
JOIN dim_customers c ON f.customerid = c.customerid
GROUP BY c.country
ORDER BY revenue DESC;

-- Average Order Value per Customer

SELECT 
    c.country, 
    SUM(f.total_amount) AS revenue
FROM fact_sales f
JOIN dim_customers c ON f.customerid = c.customerid
GROUP BY c.country
ORDER BY revenue DESC;

-- Total Revenue by Year

SELECT 
    d.year,
    SUM(f.total_amount) AS yearly_revenue
FROM fact_sales f
JOIN dim_date d ON f.date_id = d.date_id
GROUP BY d.year
ORDER BY d.year;


