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
/*
  Багатозначна залежність - залежність X -> Y, коли для одного Х існує багато Y
*/
-- не 4 НФ
/*
  - служби доставки
  - види товарів
  - локації для доставки
*/
CREATE TABLE delivery_services (
  id INT,
  name TEXT
);
--
CREATE TABLE product_types (
  id INT,
  name TEXT
);
--
CREATE TABLE delivery_services_to_product_types (
  service_id INT REFERENCES delivery_services,
  product_type_id INT REFERENCES product_types,
  location TEXT NOT NULL,
  PRIMARY KEY (service_id, product_type_id)
);
--
INSERT INTO delivery_services_to_product_types
(service_id, product_id, location) VALUES
(1,1,'Kyiv'),
(1,1,'Zaporizhzhia'),
(1,1,'Dnipro'),
(1,1,'Lviv'),
(1,1,'Odesa'),
(2,1,'Odesa');
-- 4 НФ
CREATE TABLE delivery_services (
  id INT,
  name TEXT
);
--
CREATE TABLE product_types (
  id INT,
  name TEXT
);
--
CREATE TABLE locations (
  location TEXT
);
--
CREATE TABLE delivery_services_to_locations (
  service_id INT,
  location TEXT,
  PRIMARY KEY(service_id, location_id)
);
--
CREATE TABLE delivery_services_to_product_types (
  service_id INT REFERENCES delivery_services,
  product_type_id INT REFERENCES product_types,
  PRIMARY KEY (service_id, product_type_id)
);
--
INSERT INTO delivery_services_to_locations
VALUES
(1, 'Kyiv'),
(1, 'Zaporizhzhia'),
(1, 'Dnipro'),
(2, 'Odesa');
--
INSERT INTO delivery_services_to_product_types
VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 1);