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