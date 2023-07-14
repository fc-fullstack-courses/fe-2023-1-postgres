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
-- 1 НФ (і 2 НФ)
CREATE TABLE users(
  id SERIAL PRIMARY KEY,
  first_name TEXT,
  last_name TEXT
);
-- не 2 НФ
CREATE TABLE teachers_to_courses (
  teacher_id INT,
  course_name TEXT,
  teachers_birthday DATE,
  PRIMARY KEY (teacher_id, course_name)
);
-- 2 НФ
CREATE TABLE teachers_to_courses (
  teacher_id INT,
  course_name TEXT,
  PRIMARY KEY (teacher_id, course_name)
);
--
CREATE TABLE teachers_data (
  id SERIAL PRIMARY KEY,
  teachers_birthday DATE
);
--