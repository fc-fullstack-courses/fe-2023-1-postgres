-- створення таблиці в БД
CREATE TABLE users(
  first_name VARCHAR(64),
  last_name VARCHAR(64),
  email VARCHAR(256),
  height NUMERIC(3,2),
  is_male BOOLEAN,
  birthday DATE
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

--Видалення таблиці
DROP TABLE users;