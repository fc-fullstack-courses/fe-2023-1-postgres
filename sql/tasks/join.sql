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
-- Всі замовлення з підсумковою вартістю, яка є вищею ніж середня вартість замовлення (через підзапити)

-- SELECT users.* FROM users
-- WHERE id > (SELECT 2*5);
-- GROUP BY x, y, c
-- SELECT *
-- FROM (SELECT * from users)
-- JOIN (SELECT * from)