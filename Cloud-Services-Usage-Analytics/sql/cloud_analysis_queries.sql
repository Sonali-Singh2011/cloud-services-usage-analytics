CREATE DATABASE cloud_usage_analytics;
USE cloud_usage_analytics;

SHOW DATABASES;





CREATE TABLE cloud_usage (
    usage_date DATE,
    cloud_provider VARCHAR(50),
    service_type VARCHAR(50),
    region VARCHAR(50),
    usage_hours DECIMAL(10,2),
    storage_gb DECIMAL(10,2),
    api_requests INT,
    cost_usd DECIMAL(10,2),
    customer_type VARCHAR(50)
);


USE cloud_usage_analytics;

SET GLOBAL local_infile = 1;


TRUNCATE TABLE cloud_usage;

SELECT COUNT(*) FROM cloud_usage;
SHOW VARIABLES LIKE "secure_file_priv";


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cloud_services.csv'
INTO TABLE cloud_usage
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;


SELECT * 
FROM cloud_usage
LIMIT 10;


SELECT SUM(cost_usd) AS total_cloud_cost
FROM cloud_usage;


SELECT service_type, COUNT(*) AS usage_count
FROM cloud_usage
GROUP BY service_type
ORDER BY usage_count DESC;



SELECT region, COUNT(*) AS total_usage
FROM cloud_usage
GROUP BY region
ORDER BY total_usage DESC;


SELECT 
    YEAR(usage_date) AS year,
    MONTH(usage_date) AS month,
    SUM(cost_usd) AS monthly_cost
FROM cloud_usage
GROUP BY year, month
ORDER BY year, month;


SELECT 
    service_type,
    SUM(cost_usd) AS total_cost
FROM cloud_usage
GROUP BY service_type
ORDER BY total_cost DESC;


SELECT service_type, SUM(cost_usd)
FROM cloud_usage
GROUP BY service_type;



SELECT 
    customer_type,
    COUNT(*) AS total_usage,
    SUM(cost_usd) AS total_cost
FROM cloud_usage
GROUP BY customer_type
ORDER BY total_cost DESC;



SELECT 
    region,
    COUNT(*) AS total_usage,
    SUM(cost_usd) AS total_cost
FROM cloud_usage
GROUP BY region
ORDER BY total_cost DESC;



SELECT 
    usage_date,
    service_type,
    region,
    customer_type,
    cost_usd
FROM cloud_usage
ORDER BY cost_usd DESC
LIMIT 10;