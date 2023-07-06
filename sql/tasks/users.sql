/*
  Створити таблицю users
    в таблиці мають бути всі стовпчики, що є у мене, а також:
      - вага
      - рейтинг

    В таблиці мають бути прописані наступні обмеження на додачу до існуючих:
      - Пара стовпчиків ім'я та прізвища має бути унікальною
      - Переробити обмеження для імені та прізвища. Повне ім'я не має дорівнювати пустому рядку. Напишіть через обмеження таблиці
      - вага користувача має бути у межах діапазону від 0 до 500
      - Новим обмеженням дати людиночитаємі назви
      - рейтинг має коливатися від 1 до 5
*/

CREATE TABLE users(
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(64) NOT NULL,
  last_name VARCHAR(64) NOT NULL,
  email VARCHAR(256) NOT NULL, 
  height NUMERIC(3, 2) NOT NULL CONSTRAINT "invalid height" CHECK(
    height > 0.4
    AND height < 3
  ),
  is_male BOOLEAN DEFAULT true, 
  birthday DATE NOT NULL CHECK(
    birthday > '1900-01-01'
    AND birthday < current_date
  ), 
  "weight" NUMERIC(5,2) CONSTRAINT "weight must be in range 0 - 500" CHECK(weight > 0 AND weight < 500),
  rating NUMERIC(2, 1) CONSTRAINT "rating must be in range 1 - 5" CHECK(rating >= 1 AND rating <= 5),
  CONSTRAINT "Unique name pairs" UNIQUE (first_name, last_name),
  CONSTRAINT "User must have correct name" 
  CHECK(first_name != '' AND last_name != ''),
  CONSTRAINT "invalid email" CHECK (
    email ~ '^[a-zA-Z0-9]{1,32}@[a-z]{2,32}\.[a-z]{2,32}$' 
  )
);