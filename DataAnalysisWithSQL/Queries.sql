-- KPI--
-- Total sales for each region
SELECT region, SUM(amount) AS total_sales
FROM sales
JOIN geo ON sales.geoid = geo.geoid
GROUP BY region
ORDER BY total_sales DESC;

-- Average sale amount for each salesperson
SELECT salesperson, AVG(amount) AS avg_sale_amount
FROM sales
JOIN people ON sales.spid = people.spid
GROUP BY salesperson
ORDER BY avg_sale_amount DESC;

-- Number of customers acquired by each salesperson
SELECT salesperson, COUNT(DISTINCT customers) AS num_customers_acquired
FROM sales
JOIN people ON sales.spid = people.spid
GROUP BY salesperson
ORDER BY num_customers_acquired DESC;

-- Number of boxes sold for each product category
SELECT category, SUM(boxes) AS num_boxes_sold
FROM sales
JOIN products ON sales.pid = products.pid
GROUP BY category
ORDER BY num_boxes_sold DESC;

-- Average cost per box for each product category
SELECT category, AVG(cost_per_box) AS avg_cost_per_box
FROM sales
JOIN products ON sales.pid = products.pid
GROUP BY category
ORDER BY avg_cost_per_box DESC;

-- Joins--
-- 1 Which salesperson has generated the highest total sales for their region? –

SELECT salesperson, region, SUM(amount) AS total_sales
FROM sales
JOIN geo ON sales.geoid = geo.geoid
JOIN people ON sales.spid = people.spid
GROUP BY salesperson, region
ORDER BY total_sales DESC
LIMIT 1;

-- 2 What is the average price per box of products sold in each region? --

SELECT region, AVG(cost_per_box) AS avg_price_per_box
FROM sales
JOIN products ON sales.pid = products.pid
JOIN geo ON sales.geoid = geo.geoid
GROUP BY region
ORDER BY avg_price_per_box DESC;

-- Cases --
-- 3 What is the sales performance of each salesperson, categorized as high, medium, or low?--

SELECT salesperson,
  CASE
    WHEN SUM(amount) >= 100000 THEN 'High'
    WHEN SUM(amount) >= 50000 THEN 'Medium'
    ELSE 'Low'
  END AS sales_performance
FROM sales
JOIN people ON sales.spid = people.spid
GROUP BY salesperson;

-- 4 What is the average number of boxes sold per customer for each product category?--

SELECT category, AVG(boxes / customers) AS avg_boxes_per_customer
FROM sales
JOIN products ON sales.pid = products.pid
GROUP BY category
ORDER BY avg_boxes_per_customer DESC;

-- Group by--
-- 5 What is the total sales for each product category by region? --

SELECT category, region, SUM(amount) AS total_sales
FROM sales
JOIN products ON sales.pid = products.pid
JOIN geo ON sales.geoid = geo.geoid
GROUP BY category, region
ORDER BY category, region;

-- 6 What is the average sale amount for each salesperson, grouped by product category?--

SELECT salesperson, category, AVG(amount) AS avg_sale_amount
FROM sales
JOIN products ON sales.pid = products.pid
JOIN people ON sales.spid = people.spid
GROUP BY salesperson, category
ORDER BY salesperson, category;

-- Combination of joins, cases, and group by--

-- 7 What is the sales performance of each salesperson for products in the, categorized as high, medium, or low?--

SELECT salesperson,
  CASE
    WHEN SUM(amount) >= 100000 THEN 'High'
    WHEN SUM(amount) >= 50000 THEN 'Medium'
    ELSE 'Low'
  END AS sales_performance
FROM sales
JOIN people ON sales.spid = people.spid
JOIN products ON sales.pid = products.pid
WHERE category = 'Bars'
GROUP BY salesperson
ORDER BY sales_performance DESC;

-- 8 What is the average sale amount for each product category, grouped by region and salesperson?--
SELECT salesperson, category, region, AVG(amount) AS avg_sale_amount
FROM sales
JOIN products ON sales.pid = products.pid
JOIN people ON sales.spid = people.spid
JOIN geo ON sales.geoid = geo.geoid
GROUP BY salesperson, category, region
ORDER BY salesperson, category, region;

-- 9 What is the total sales for each product category, grouped by region and month?--
SELECT category, region, MONTH(saledate) AS month, SUM(amount) AS total_sales
FROM sales
JOIN products ON sales.pid = products.pid
JOIN geo ON sales.geoid = geo.geoid
GROUP BY category, region, month
ORDER BY category, region, month;


