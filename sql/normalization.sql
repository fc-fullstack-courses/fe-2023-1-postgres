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
/*
транзитивна функціональна залежність - залежність не тількі від ключа а і від якогось неключового атрибута
добре:
id > attr1
id > attr2

погано:
id > attr1 > attr2
*/
-- не 3 НФ
CREATE TABLE employees (
  id SERIAL PRIMARY KEY,
  name TEXT,
  email TEXT,
  department TEXT,
  department_phone_number VARCHAR(64)
);
--
INSERT INTO employees
(name, email, department, department_phone_number)
VALUES 
('Test', 'test@test.test', 'HR', '147852369'),
('Test2', 'test2@test.test', 'IT', '963852741'),
('Test3', 'test3@test.test', 'QA', '987654321'),
('Test4', 'test4@test.test', 'HR', '987654321');
-- 3 НФ
CREATE TABLE employees (
  id SERIAL PRIMARY KEY,
  name TEXT,
  email TEXT,
  department_id INT
);
--
CREATE TABLE departments(
  id SERIAL PRIMARY KEY,
  department TEXT,
  department_phone_number VARCHAR(64)
);
-- не BCNF
/*
  є сутності студентів, викладачів та предметів
  студенти вивчають багато предметів,
  кожен викладач веде 1 предмет
  teacher n : 1 subject
  students m : n subject
  students m : n teachers
*/
CREATE TABLE students (
  id INT PRIMARY KEY,
  name TEXT
);
--
CREATE TABLE teachers (
  id INT PRIMARY KEY,
  name TEXT
);
--
CREATE TABLE students_to_teachers_to_subjects (
  teacher_id INT REFERENCES teachers,
  student_id INT REFERENCES students,
  subject VARCHAR(64),
  PRIMARY KEY (teacher_id, student_id)
);
-- 
INSERT INTO students_to_teachers_to_subjects
(teacher_id, student_id, subject) 
VALUES
(1,1,'Math'),
(1,2,'Math'),
(2,1,'Physics'),
(2,2,'Physical Education');
-- BCNF
CREATE TABLE students (
  id INT PRIMARY KEY,
  name TEXT
);

CREATE TABLE subjects (
  id INT PRIMARY KEY,
  name TEXT
);

CREATE TABLE teachers (
  id INT PRIMARY KEY,
  subject_id INT REFERENCES subjects,
  name TEXT
);
--
CREATE TABLE students_to_teachers (
  teacher_id INT REFERENCES teachers,
  student_id INT REFERENCES students,
  PRIMARY KEY (teacher_id, student_id)
);
--
