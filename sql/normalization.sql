/*
Нормальні форми:
- 1
- 2
- 3
- Бойса-Кодда
- 4
- 5
- Доменнко-ключова
- 6
*/
-- не 1 НФ
CREATE TABLE users(
  first_name TEXT,
  last_name TEXT
); 
-- 1 НФ
CREATE TABLE users(
  id SERIAL PRIMARY KEY,
  first_name TEXT,
  last_name TEXT
);
