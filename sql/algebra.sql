CREATE TABLE numbers(
  a INT,
  b INT
);
--
CREATE TABLE names(
  id INT,
  name VARCHAR(64)
);
--
INSERT INTO numbers
(a, b) VALUES
(1,1),
(2,85),
(3,-1525),
(4,6547684),
(5,987684543),
(10,647684);
--
INSERT INTO names
(id, name) VALUES
(1, 'Test'),
(2, 'User'),
(5, 'John'),
(6, 'Jane');
--
SELECT * FROM names;
--
SELECT * FROM numbers;
--
SELECT * FROM names, numbers;
--
SELECT id FROM names
UNION
SELECT a FROM numbers;
--
SELECT id FROM names
INTERSECT
SELECT a FROM numbers;
-- 
SELECT id FROM names
EXCEPT
SELECT a FROM numbers;
-- 
SELECT a FROM numbers
EXCEPT
SELECT id FROM names;
-- Всі користувачі, які не робили замовлення
SELECT id FROM users
EXCEPT
SELECT customer_id FROM orders;
-- Всі користувачі, які робили замовлення
SELECT id FROM users
INTERSECT
SELECT customer_id FROM orders;
