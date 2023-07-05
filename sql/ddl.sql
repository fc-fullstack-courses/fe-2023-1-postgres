-- створення таблиці в БД
CREATE TABLE users(
  first_name VARCHAR(64) NOT NULL,
  last_name VARCHAR(64) NOT NULL,
  email VARCHAR(256) NOT NULL UNIQUE,
  height NUMERIC(3,2) NOT NULL,
  is_male BOOLEAN,
  birthday DATE NOT NULL,
  -- UNIQUE(email) -- обмеження таблиці
);

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



*/

--Видалення таблиці
DROP TABLE users;