-- Отримати всі товари у певному замовлені
SELECT p.*
FROM products p
JOIN products_to_orders pto ON pto.product_id = p.id
WHERE pto.order_id = 1;
-- Отримати кількість товарів у певного виробника
SELECT count(*)
FROM manufacturers m
JOIN products p ON m.id = manufacturer_id
WHERE m.id = 2;
--
SELECT name,quantity
FROM manufacturers m
JOIN products p ON m.id = manufacturer_id
WHERE m.id = 2;
--
SELECT sum(quantity)
FROM manufacturers m
JOIN products p ON m.id = manufacturer_id
WHERE m.id = 2;
-- Отримати вартість певного замовлення
SELECT sum(p.price * pto.quantity)
FROM products p
JOIN products_to_orders pto ON pto.product_id = p.id
WHERE order_id = 1;
-- Отримати вартість кожного замовлення
SELECT order_id ,sum(p.price * pto.quantity)
FROM products p
JOIN products_to_orders pto ON pto.product_id = p.id
GROUP BY order_id
ORDER BY order_id;
-- Кількість замовлень певного користувача
SELECT email, count(*)
FROM users u
JOIN orders o ON o.customer_id = u.id
WHERE u.id = 3
GROUP BY u.id;
-- *
-- знайти товар, який зустрічається у найбільшій кількості унікальних замовлень
SELECT p.name ,count(*) amount
FROM products p
JOIN products_to_orders pto ON pto.product_id = p.id
GROUP BY p.id
ORDER BY amount DESC
LIMIT 1;
-- Отримати всіх користувачів і кількість придбаних ними укікальних товарів (через підзапити)
SELECT u.id user_id, p.id product_id
FROM users u
JOIN orders o ON o.customer_id = u.id
JOIN products_to_orders pto ON pto.order_id = o.id
JOIN products p ON p.id = pto.product_id
GROUP BY u.id, p.id;
--
SELECT user_id, count(product_id) FROM (
  SELECT u.id user_id, p.id product_id
  FROM users u
  JOIN orders o ON o.customer_id = u.id
  JOIN products_to_orders pto ON pto.order_id = o.id
  JOIN products p ON p.id = pto.product_id
  GROUP BY u.id, p.id
) as user_is_with_product_id
GROUP BY user_id;
-- Всі замовлення з підсумковою вартістю, яка є вищею ніж середня вартість замовлення (через підзапити)
-- 1. кожне замовлення з його вартістю
SELECT order_id, sum(p.price * pto.quantity) total_price
FROM products p
JOIN products_to_orders pto ON pto.product_id = p.id
GROUP BY order_id
ORDER BY order_id;
-- 2. знаходимо середню вартість замовлення
SELECT avg(total_price) 
FROM (
  SELECT order_id ,sum(p.price * pto.quantity) total_price
  FROM products p
  JOIN products_to_orders pto ON pto.product_id = p.id
  GROUP BY order_id
  ORDER BY order_id
) orders_with_prices;
-- 3. Збираємо у фінальне рішення
SELECT order_id, total_price FROM (
  SELECT order_id, sum(p.price * pto.quantity) total_price
  FROM products p
  JOIN products_to_orders pto ON pto.product_id = p.id
  GROUP BY order_id
  ORDER BY order_id
) orders_with_prices
WHERE total_price > (SELECT avg(total_price) 
FROM (
  SELECT order_id ,sum(p.price * pto.quantity) total_price
  FROM products p
  JOIN products_to_orders pto ON pto.product_id = p.id
  GROUP BY order_id
  ORDER BY order_id
) orders_with_prices);
-- SELECT users.* FROM users
-- WHERE id > (SELECT 2*5);
-- GROUP BY x, y, c
-- SELECT *
-- FROM (SELECT * from users)
-- JOIN (SELECT * from)