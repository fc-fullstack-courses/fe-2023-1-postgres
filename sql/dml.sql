-- занесення даних у таблицю
INSERT INTO users 
-- довільний порядок вставки даних
( height, first_name, last_name, birthday, email, is_male) 
VALUES 
-- вставка декількох користувачів одночасно
(0.51, 'User', 'Userenko', '1999-01-01', 'asds@sadsa.asds', true),
(1.62, 'User', 'Userenko', '2023-07-04', 'mail4@gmail.com', true),
(1.35, 'User', 'Userenko', '1983-05-14', 'mail2@mail.com', NULL),
(3.95, 'User', 'Userenko', '1999-01-01', 'mail3@mail.com', true);