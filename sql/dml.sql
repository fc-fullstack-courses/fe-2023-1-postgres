-- занесення даних у таблицю
INSERT INTO users 
-- довільний порядок вставки даних
(height, first_name, last_name, birthday, email, is_male) 
VALUES 
-- вставка декількох користувачів одночасно
(0.01, 'User', 'Userenko', '1999-01-01', 'mail@mail.com', true),
(1.62, '', '', '1699-01-02', '', true),
(1.35, 'User', 'Userenko', '1983-05-14', 'mail2@mail.com', NULL),
(-0.5, 'User', 'Userenko', '1999-01-01', 'mail3@mail.com', true);