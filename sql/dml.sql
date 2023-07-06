-- занесення даних у таблицю
-- Create
INSERT INTO users 
-- довільний порядок вставки даних
( height, first_name, last_name, birthday, email, is_male) 
VALUES 
-- вставка декількох користувачів одночасно
(0.51, 'User1', 'Userenko', '1999-01-01', 'asds@sadsa.asds', true),
(1.62, 'User2', 'Userenko', '2023-07-04', 'mail4@gmail.com', true),
(1.35, 'User3', 'Userenko', '1983-05-14', 'mail2@mail.com', false),
(2.95, 'User4', 'Userenko', '1999-01-01', 'mail3@mail.com', true);
-- Зміна даних в таблиці
-- Update
UPDATE users SET weight = 60; -- встановлює значення всім записам
UPDATE users SET weight = 75
WHERE is_male = FALSE; -- зміна ваги для всіх жінок
-- оновлення конкретного користувача
UPDATE users SET height = 1.67
WHERE id = 1;
-- оновлення декількох значень.
UPDATE users SET 
first_name = 'Anton', 
email = 'anton@mail.com', 
weight = 123 
WHERE id = 2;
-- Видалення записів
DELETE FROM users; -- видаляє всі записи в таблиці
DELETE FROM users WHERE id = 3;
DELETE FROM users WHERE height > 1.65;