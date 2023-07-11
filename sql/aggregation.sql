/*
  Агрегатні функції - отримуюють одиничний результат с поміж багатьох даних

  основні агрегатні функції:
    - avg
    - count - рахує кількість рядків
    - min
    - max
    - sum - схожий на reduce
*/
-- середній розмір ноги користувачів
SELECT avg( foot_size ) FROM users; 
-- максимальний розмір ноги
SELECT max( foot_size ) FROM users; 
-- сумарна вага всіх користувачів
SELECT sum(weight) FROM users;
-- кількість користувачів
SELECT count(*) FROM users;
-- кількість чоловіків
SELECT count(*) FROM users WHERE is_male;
-- кількість чоловіків та жінок
SELECT count(*) AS "кількість", is_male FROM users
GROUP BY is_male;
-- 
SELECT id, count(*), is_male
FROM users
GROUP BY id;

-- SELECT foot_size FROM users
-- GROUP BY foot_size;