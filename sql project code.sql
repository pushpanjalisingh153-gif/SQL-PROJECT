CREATE TABLE item (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(100),
    category TEXT,
    price NUMERIC(10,2),
    stock_quantity INT,
    is_available BOOLEAN,
    added_on DATE
);
select*from item;


CREATE TABLE sorder (
    sorder_id INT PRIMARY KEY,
    item_id INT,
    quantity INT,
    sorder_date DATE,
    customer_name VARCHAR(50),
    payment_method VARCHAR(50),
    CONSTRAINT fk_item
    FOREIGN KEY (item_id)
    REFERENCES item(item_id)
    ON DELETE CASCADE
);
select*from sorder;

-- Q1: Show each order with product name and price

SELECT
    o.order_id,
    p.products_name,
    p.price
FROM orders o
JOIN productss p
ON o.products_id = p.products_id;

-- Q2: Show all products including unordered products

SELECT
    p.products_id,
    p.products_name,
    o.order_id
FROM productss p
LEFT JOIN orders o
ON p.products_id = o.products_id;

-- Q3: Show orders of Electronics category

SELECT
    o.order_id,
    p.products_name,
    p.category,
    o.quantity
FROM orders o
JOIN productss p
ON o.products_id = p.products_id
WHERE p.category = 'Electronics';

-- Q4: Sort orders by product price descending

SELECT
    o.order_id,
    p.products_name,
    p.price
FROM orders o
JOIN productss p
ON o.products_id = p.products_id
ORDER BY p.price DESC;

-- Q5: Count orders for each product

SELECT
    p.products_name,
    COUNT(o.order_id) AS total_orders
FROM productss p
LEFT JOIN orders o
ON p.products_id = o.products_id
GROUP BY p.products_id, p.products_name;

-- Q6: Calculate total revenue per product

SELECT
    p.products_name,
    COALESCE(SUM(p.price * o.quantity), 0) AS total_revenue
FROM productss p
LEFT JOIN orders o
ON p.products_id = o.products_id
GROUP BY p.products_id, p.products_name;

-- Q7: Products having total revenue greater than 2000

SELECT
    p.products_name,
    SUM(p.price * o.quantity) AS total_revenue
FROM productss p
JOIN orders o
ON p.products_id = o.products_id
GROUP BY p.products_id, p.products_name
HAVING SUM(p.price * o.quantity) > 2000;

-- Q8: Show unique customers who ordered Fitness products

SELECT DISTINCT
    o.customer_name
FROM orders o
JOIN productss p
ON o.products_id = p.products_id
WHERE p.category = 'Fitness';

