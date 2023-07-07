-- Отримання даних з усієї таблиці
SELECT * FROM users; 
-- отримання певних даних
SELECT id, email, first_name, surname FROM users;
-- фільтрація результатів
SELECT * FROM users 
WHERE height >1.5;
-- всі користувачі з парними id
SELECT * FROM users
WHERE id % 2 = 0;
-- всі чоловіки, зріст яких менше метра
SELECT * FROM users
WHERE height < 1 AND is_male;
-- всі користувачі з певними іменами
SELECT * FROM users
-- WHERE first_name = 'User1' OR first_name = 'User2';
WHERE first_name IN ('User1', 'User2');
-- 
SELECT * FROM users
WHERE email ~ '^m.{0,}';
--
SELECT * FROM users
-- WHERE height >= 1 AND height <=2.5;
WHERE height BETWEEN 1 AND 2.5;
-- перейменування виводів
SELECT first_name AS "Ім'я", surname AS "Прізвище", email Пошта
FROM users;
-- Пагінація в БД
SELECT * FROM users
LIMIT 2 OFFSET 0;
-- Відобразити id, email і повне ім'я
SELECT id, email, first_name || ' ' || surname AS "full name", birthday
FROM users;
-- або
SELECT id, email, concat(first_name, ' ', surname) AS "full name", birthday
FROM users;
-- Всі користувачі, повне ім'я яких менше ніж 16 символів
SELECT id, email, concat(first_name, ' ', surname) AS full_name, birthday
FROM users
WHERE length(concat(first_name, ' ', surname)) < 16;
-- 
SELECT * FROM (
  SELECT id, email, concat(first_name, ' ', surname) AS full_name, birthday
  FROM users
) AS "users_with_full_name"
WHERE length(full_name) < 16;
-- 
SELECT *  FROM (
  SELECT  concat(first_name, ' ', surname) AS full_name, *
  FROM users
) AS "users_with_full_name"
WHERE length(full_name) < 16;
