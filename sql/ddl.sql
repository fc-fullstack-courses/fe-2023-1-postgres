-- створення таблиці в БД
CREATE TABLE users(
  -- id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(64) NOT NULL CHECK (first_name != ''),
  last_name VARCHAR(64) NOT NULL CHECK (last_name != ''),
  email VARCHAR(256) NOT NULL UNIQUE, 
  height NUMERIC(3, 2) NOT NULL CONSTRAINT "invalid height" CHECK(
    height > 0.4
    AND height < 3
  ),
  is_male BOOLEAN DEFAULT true, -- значення за замовчуванням
  birthday DATE NOT NULL CHECK(
    birthday > '1900-01-01'
    AND birthday < current_date
  ), -- UNIQUE(email) -- обмеження таблиці
  CONSTRAINT "invalid email" CHECK (
    email ~ '^[a-zA-Z0-9]{1,32}@[a-z]{2,32}\.[a-z]{2,32}$' -- регулярка
  )
);
--
CREATE TABLE a(
  b INT,
  c INT,
  CONSTRAINT "Unique b and c values" UNIQUE(b,c) -- унікальні комбінації значень b та с
);

-- DROP TABLE a;

-- INSERT INTO a (b, c)
-- VALUES (10, 5),
-- (15,4),
-- (10,3),
-- (1,5),
-- (10,5);

/*
 символьні типи даних 
 text - будь який текст будь якої довжини
 
 char(5) - текст фіксованої довжини
 '12345'
 '123  '
 '1    '
 '12345'6789
 
 varchar(5) - текст змінної довжини
 '12345'
 '123'
 '1'
 '12345'6789
 
 числові типи
 numeric(точність, масштаб)
 
 точність - загальна кількість цифр
 масштаб - кількість цифр після крапки
 */
/*
 Обмеження:
 Більшість обмежень зберігаються у таблиці у якості об'єктів. У цих об'єктів є імена, які записуються у вигляді: 
 "назваТаблиці_назваСтовпчика_назваОбмеження"
 
 
 NOT NULL - забороняє записувати NULL у стовпчик (не зберігається як об'єкт)
 
 UNIQUE - забороняє повторні значення у стовпчику або групі стовпчиків
 
 CHECK - загальна перевірка, якщо умова правдива то дія дозволяється інакше помилка
 
 PRIMARY KEY - первинний ключ, комбінація обмежень UNIQUE і NOT NULL. Один на таблицю
*/
--Видалення таблиці
DROP TABLE users;

-- Зміна структури таблиці
-- ALTER TABLE 
-- Додавання нового стовпчика(-ів)
ALTER TABLE users 
ADD COLUMN eye_color VARCHAR(100) NOT NULL DEFAULT 'brown' CHECK(eye_color != ''),
ADD COLUMN hair_color VARCHAR(100) CHECK(hair_color != '');
-- Видалення стовпчиків
ALTER TABLE users
DROP COLUMN hair_color;
-- Додавання обмежень
ALTER TABLE users
ADD UNIQUE(email);
-- Додавання NOT NULL
ALTER TABLE users
ALTER COLUMN is_male SET NOT NULL;
-- Видалення обмежень
ALTER TABLE users
DROP CONSTRAINT "User must have correct name";
-- Видалення NOT NULL
ALTER TABLE users
ALTER COLUMN is_male DROP NOT NULL;
-- Зміна значень за замовчанням
ALTER TABLE users
ALTER COLUMN height
SET DEFAULT 1.5;
-- "Видалення" значень за замовчанням (воно по факту стає NULL)
ALTER TABLE users
ALTER COLUMN height
DROP DEFAULT;
-- Зміна типу даних
ALTER TABLE users
ALTER COLUMN email
TYPE VARCHAR(128);
-- Перейменування:
--  Стовпчика
ALTER TABLE users RENAME COLUMN last_name TO surname;
-- таблиці
ALTER TABLE users RENAME TO people;
-- Створення нової БД
CREATE DATABASE fe_2023_1_not_rozetka;