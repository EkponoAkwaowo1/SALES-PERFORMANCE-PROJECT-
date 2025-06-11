##Creating Table

DROP TABLE IF EXISTS pizza_sales;

CREATE TABLE pizza_sales (
pizza_id VARCHAR(20),
order_id VARCHAR(20),
pizza_name_id VARCHAR(50),
quantity INT,
order_date DATE,
order_time TIME,
unit_price DECIMAL(10, 3),
total_price DECIMAL(10, 3),
pizza_size VARCHAR(20),
pizza_category VARCHAR(50),
pizza_ingredients TEXT,
pizza_name TEXT,

PRIMARY KEY (pizza_id)
);

##Loading data from PC

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/pizza_sales_new.csv'
INTO TABLE pizza_sales
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

## or import using table wizard

##Checking out the data

SELECT * FROM portfolio_projects.pizza_sales;

SELECT * FROM pizza_sales
where pizza_id = null;

SELECT * 
FROM pizza_sales;

##Total Revenue
SELECT SUM(total_price) as Total_Revenue
FROM pizza_sales;

##Total Orders
SELECT COUNT( DISTINCT order_id) as Total_Orders
FROM pizza_sales;

##Avg Order Value 

SELECT SUM(total_price)/COUNT( DISTINCT order_id) as avg_order_value
FROM pizza_sales;

##Total Pizzas Sold
SELECT SUM(quantity) as Total_Pizzas_Sold
FROM pizza_sales;

##Average Pizzas Per Order
SELECT SUM(quantity) / COUNT(DISTINCT order_id) as Average_Pizzas_Per_Order
FROM pizza_sales;

## Daily Trend for Total Orders
SELECT DAYNAME(order_date) AS order_day, 
COUNT(DISTINCT order_id) AS total_orders  
FROM pizza_sales  
GROUP BY DAYNAME(order_date)
Order by total_orders DESC;

## Monthly Trend for Total Orders
SELECT monthname(order_date) AS month_name, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY monthname(order_date)
ORDER BY total_orders DESC;

## % of sales by pizza category
SELECT pizza_category, SUM(total_price) as total_revenue,
SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS Percentage
FROM pizza_sales
GROUP BY pizza_category;

## % of sales by pizza size
SELECT pizza_size, SUM(total_price) as total_revenue, 
SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) as Percentage
FROM pizza_sales
GROUP BY pizza_size
ORDER BY Percentage DESC;

##Total Pizza Sold by Category
SELECT pizza_category, SUM(quantity) as Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Pizza_Sold DESC;

##Top Five Best Sellers by Revenue
SELECT pizza_name, SUM(total_price) as Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Revenue DESC
LIMIT 5;

##Top Five Best Sellers by Quantity
SELECT pizza_name, SUM(quantity) as Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Quantity DESC
LIMIT 5;

##Top Five Best Sellers by Total Orders
SELECT pizza_name, COUNT(DISTINCT order_id) as Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC
LIMIT 5;

##Bottom Five Sellers by Revenue
SELECT pizza_name, SUM(total_price) as Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Revenue ASC
LIMIT 5;

##Bottom Five Sellers by Quantity
SELECT pizza_name, SUM(quantity) as Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Quantity ASC
LIMIT 5;

##Bottom Five Sellers by Total Orders
SELECT pizza_name, COUNT(DISTINCT order_id) as Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC
LIMIT 5;

