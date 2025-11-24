# 🍕 The Great Pizza Analytics Challenge

Welcome to the **Great Pizza Analytics Challenge**!

You are the data analyst for **IDC Pizza**, working with real-world style schema and queries.  
This file documents the full SQL program used to create the database and answer all challenge questions.

---

## Database Setup

```sql
CREATE DATABASE IDC_PIZZA;
USE IDC_PIZZA;
```

## Table Creation

### pizza_types
```sql
CREATE TABLE pizza_types (
    pizza_type_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    ingredients TEXT
);
```

### pizzas
```sql
CREATE TABLE pizzas (
    pizza_id VARCHAR(50) PRIMARY KEY,
    pizza_type_id VARCHAR(50),
    size VARCHAR(10),
    price DECIMAL(5 , 2 ),
    FOREIGN KEY (pizza_type_id)
        REFERENCES pizza_types (pizza_type_id)
);
```

### orders
```sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    date DATE,
    time TIME
);
```

### order_details
```sq;
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
```

## View Data
```sql
SELECT * FROM pizza_types;
SELECT * FROM pizzas;
SELECT * FROM orders;
SELECT * FROM order_details;
```

# Phase 1: Foundation & Inspection
-- Unique pizza categories
```sql
SELECT DISTINCT category FROM pizza_types;
```

-- First 5 rows with ingredient cleanup
```sql
SELECT 
    pizza_type_id, 
    name, 
    IFNULL(ingredients, 'Missing Data') AS pizza_ingredients 
FROM pizza_types 
LIMIT 5;
```

-- Pizzas missing a price
```sql
SELECT pizza_id, size, price 
FROM pizzas 
WHERE price IS NULL OR price = '' OR price = ' ';
```

# Phase 2: Filtering & Exploration
-- Orders on 2015-01-01
```sql
SELECT * FROM orders WHERE date = '2015-01-01';
```

-- Pizzas sorted by price
```sql
SELECT * FROM pizzas ORDER BY price DESC;
```

-- Pizzas sized L or XL
```sql
SELECT pizza_type_id, size, price 
FROM pizzas 
WHERE size = 'L' OR size = 'XL';
```

-- Pizzas priced between 15 and 17
```sql
SELECT pizza_type_id, size, price 
FROM pizzas 
WHERE price BETWEEN 15.00 AND 17.00;
```

-- Pizzas with "Chicken" in the name
```sql
SELECT name, category, ingredients 
FROM pizza_types 
WHERE category = 'Chicken';
```

-- Orders on 2015-02-15 or after 8 PM
```sql
SELECT * 
FROM orders 
WHERE date = '2015-02-15' OR time = '20:00:00';
```

# Phase 3: Sales Performance
-- Total quantity of pizzas sold
```sql
SELECT SUM(quantity) AS total_pizzas_sold FROM order_details;
```

-- Average pizza price
```sql
SELECT AVG(price) AS average_price FROM pizzas;
```

-- Total order value per order
```sql
SELECT 
    od.order_id, 
    SUM(od.quantity * p.price) AS total_order_value
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
GROUP BY od.order_id;
```

-- Total quantity sold per category
```sql
SELECT 
    pt.category, 
    SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category;
```

-- Categories selling more than 5000 pizzas
```sql
SELECT 
    pt.category, 
    SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
HAVING SUM(od.quantity) > 5000;
```

-- Pizzas never ordered
```sql
SELECT 
    p.pizza_id, 
    p.pizza_type_id, 
    p.size, 
    p.price
FROM pizzas p
LEFT JOIN order_details od ON p.pizza_id = od.pizza_id
WHERE od.pizza_id IS NULL;
```

-- Price differences between pizza sizes (Self Join)
```sql
SELECT 
    p1.pizza_type_id,
    p1.size AS size1,
    p2.size AS size2,
    p1.price AS price1,
    p2.price AS price2,
    (p2.price - p1.price) AS price_difference
FROM pizzas p1
JOIN pizzas p2 
    ON p1.pizza_type_id = p2.pizza_type_id
   AND p1.size < p2.size
ORDER BY p1.pizza_type_id, p1.size;
```
