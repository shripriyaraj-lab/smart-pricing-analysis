CREATE DATABASE pricing_project;
USE pricing_project;
CREATE TABLE sales_data (
    country VARCHAR(50),
    product VARCHAR(50),
    category VARCHAR(50),
    price_usd DECIMAL(10,2),
    units_sold INT,
    profit_usd DECIMAL(10,2)
);
INSERT INTO sales_data VALUES
('India','Laptop','Electronics',500,200,10000),
('USA','Laptop','Electronics',900,150,20000),
('Germany','Laptop','Electronics',850,120,18000),
('Brazil','Laptop','Electronics',600,180,12000),
('UK','Laptop','Electronics',880,130,19000),

('India','Phone','Electronics',200,500,15000),
('USA','Phone','Electronics',600,300,25000),
('Germany','Phone','Electronics',550,280,23000),
('Brazil','Phone','Electronics',300,400,16000),
('UK','Phone','Electronics',580,270,24000);
SELECT * FROM sales_data;
SELECT SUM(profit_usd) AS total_profit
FROM sales_data;
SELECT country,
       SUM(profit_usd) AS total_profit
FROM sales_data
GROUP BY country;
SELECT product,
       AVG(price_usd) AS average_price
FROM sales_data
GROUP BY product;
SELECT country,
       SUM(profit_usd) AS total_profit
FROM sales_data
GROUP BY country
HAVING total_profit > 30000;
CREATE TABLE product_info (
    product VARCHAR(50),
    supplier VARCHAR(50)
);
INSERT INTO product_info VALUES
('Laptop','Dell'),
('Phone','Samsung');
SELECT 
    s.country,
    s.product,
    p.supplier,
    s.profit_usd
FROM sales_data s
JOIN product_info p
ON s.product = p.product;
DELIMITER //

CREATE TRIGGER check_profit
BEFORE INSERT ON sales_data
FOR EACH ROW
BEGIN
    IF NEW.profit_usd < 0 THEN
        SET NEW.profit_usd = 0;
    END IF;
END//

DELIMITER ;
INSERT INTO sales_data VALUES
('India','Tablet','Electronics',400,50,-5000);
SELECT * FROM sales_data;
