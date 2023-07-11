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
/*
Знайдіть
  - середній зріст користувачів
  - середній зріст чоловіків та жінок
  - мінімальний розмір ноги чоловіків та жінок
  - мінімальну, максимальну і серердню вагу чоловіків та жінок

*/

--   - середній зріст користувачів
SELECT avg(height) FROM users;
-- - середній зріст чоловіків та жінок
SELECT avg(height), is_male FROM users
GROUP BY is_male;
-- - мінімальний розмір ноги чоловіків та жінок
SELECT min(foot_size), is_male
FROM users
GROUP BY is_male;
-- - мінімальну, максимальну і серердню вагу чоловіків та жінок
SELECT is_male, min(weight), avg(weight), max(weight)
FROM users
GROUP BY is_male;
--
SELECT avg(height), is_male 
FROM users
WHERE weight < 100 -- звуження області пошуків.
GROUP BY is_male;
-- кількість людей з різними кольорами волосся, не показувати групи, в якіх знаходяться менше ніж 30 людей
SELECT * FROM (
  SELECT count(*) amount, hair_color
FROM users
GROUP BY hair_color
) hc_amount
WHERE amount > 30; -- фільтрація рядків / кортежів не можна агрегатні
--
SELECT count(*), hair_color
FROM users
GROUP BY hair_color
HAVING count(*) > 30; -- фільтрація груп, можна агрегатні, не розуміє псевдоніми
-- середній розмір ноги людей з різними кольорами волосся. Відфільтрувати середні розміри, менші ніж 35
SELECT avg(foot_size), hair_color
FROM users
GROUP BY hair_color
HAVING avg(foot_size) >= 35;