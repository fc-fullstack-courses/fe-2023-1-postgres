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
--
