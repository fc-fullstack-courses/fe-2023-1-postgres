-- SELECT email
-- FROM users, orders
-- WHERE users.id = customer_id
-- GROUP BY users.email;
-- JOIN - поєднує данні декількох таблиць у одному запиті
SELECT * FROM users
JOIN orders ON orders.customer_id = users.id;
-- поєднання декількох таблиць
SELECT * FROM users
JOIN manufacturers ON users.id = user_id
JOIN orders ON users.id = customer_id;
-- Немає різниці з якої таблиці ви будете розпочинати об'єднання
SELECT * FROM orders
JOIN users ON customer_id = users.id
JOIN manufacturers ON user_id = users.id;
-- всі дані першого замовлення
SELECT *
FROM orders AS o
JOIN products_to_orders pto ON o.id = pto.order_id
JOIN products p ON p.id = pto.product_id
WHERE o.id = 1;
-- Отримати всі замовлення з їжею
SELECT order_id
FROM products p
JOIN products_to_orders pto ON p.id = product_id
WHERE p.category ILIKE 'food'
GROUP BY order_id
ORDER BY order_id ASC;
-- Кількість товарів з категорії їжи в певному замовленні (34)
SELECT count(*)
FROM products_to_orders pto
JOIN products p ON p.id = pto.product_id
WHERE p.category ILIKE 'food' AND order_id = 288;
-- Кількість товарів з категорії їжи в кожному замовленні
SELECT count(*), order_id
FROM products_to_orders pto
JOIN products p ON p.id = pto.product_id
WHERE p.category ILIKE 'food'
GROUP BY order_id
ORDER BY count(*) ASC;