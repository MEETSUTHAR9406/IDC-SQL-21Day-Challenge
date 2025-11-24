CREATE DATABASE IDC_PIZZA;
USE IDC_PIZZA;

CREATE TABLE pizza_types (
    pizza_type_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    ingredients TEXT
);

CREATE TABLE pizzas (
    pizza_id VARCHAR(50) PRIMARY KEY,
    pizza_type_id VARCHAR(50),
    size VARCHAR(10),
    price DECIMAL(5 , 2 ),
    FOREIGN KEY (pizza_type_id)
        REFERENCES pizza_types (pizza_type_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    date DATE,
    time TIME
);

CREATE TABLE order_details (
    order_details_id INT PRIMARY KEY,
    order_id INT,
    pizza_id VARCHAR(50),
    quantity INT,
    FOREIGN KEY (order_id)
        REFERENCES orders (order_id),
    FOREIGN KEY (pizza_id)
        REFERENCES pizzas (pizza_id)
);	

SELECT * FROM pizza_types;
SELECT * FROM pizzas;
SELECT * FROM orders;
SELECT * FROM order_details;

-- Phase 1: Foundation & Inspection

-- 1. List all unique pizza categories (DISTINCT).
SELECT DISTINCT category FROM pizza_types;

-- 2. Display pizza_type_id, name, and ingredients, replacing NULL ingredients with "Missing Data". Show first 5 rows.
SELECT pizza_type_id, name, IFNULL(ingredients, 'Missing Data') AS pizza_ingredients FROM pizza_types LIMIT 5;

-- 3. Check for pizzas missing a price (IS NULL).
SELECT pizza_id, size, price FROM pizzas WHERE price IS NULL OR price = '' OR price = ' ';

-- Phase 2: Filtering & Exploration

-- 1. Orders placed on '2015-01-01' (SELECT + WHERE).
SELECT * FROM orders WHERE date = '2015-01-01';

-- 2. List pizzas with price descending.
SELECT * FROM pizzas ORDER BY price DESC;

-- 3. Pizzas sold in sizes 'L' or 'XL'.
SELECT pizza_type_id, size, price FROM pizzas WHERE size = 'L' OR size = 'XL';

-- 4 Pizzas priced between $15.00 and $17.00.
SELECT pizza_type_id, size, price FROM pizzas WHERE price BETWEEN 15.00 AND 17.00;

-- 5. Pizzas with "Chicken" in the name.
SELECT name, category, ingredients FROM pizza_types WHERE category = 'Chicken';

-- 6. Orders on '2015-02-15' or placed after 8 PM.
SELECT * FROM orders WHERE date = '2015-02-15' OR time = '20:00:00';

-- Phase 3: Sales Performance

-- 1. Total quantity of pizzas sold (SUM).
SELECT SUM(quantity) AS total_pizzas_sold FROM order_details;

-- 2. Average pizza price (AVG).
SELECT AVG(price) AS average_price FROM pizzas;

-- 3. Total order value per order (JOIN, SUM, GROUP BY).
SELECT 
    od.order_id, SUM(od.quantity * p.price) AS total_order_value
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id
GROUP BY od.order_id;

-- 4. Total quantity sold per pizza category (JOIN, GROUP BY).
SELECT 
    pt.category, SUM(od.quantity) AS total_quantity
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id
        JOIN
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category;

-- 5. Categories with more than 5,000 pizzas sold (HAVING).
SELECT 
    pt.category, SUM(od.quantity) AS total_quantity
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id
        JOIN
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
HAVING SUM(od.quantity) > 5000;

-- 6. Pizzas never ordered (LEFT/RIGHT JOIN).
SELECT 
    p.pizza_id, p.pizza_type_id, p.size, p.price
FROM
    pizzas p
        LEFT JOIN
    order_details od ON p.pizza_id = od.pizza_id
WHERE
    od.pizza_id IS NULL;
    
-- 7. Price differences between different sizes of the same pizza (SELF JOIN).
SELECT 
    p1.pizza_type_id,
    p1.size AS size1,
    p2.size AS size2,
    p1.price AS price1,
    p2.price AS price2,
    (p2.price - p1.price) AS price_difference
FROM
    pizzas p1
        JOIN
    pizzas p2 ON p1.pizza_type_id = p2.pizza_type_id
        AND p1.size < p2.size
ORDER BY p1.pizza_type_id , p1.size;