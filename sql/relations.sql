/*
  Класифікації зв'язків між сутностями:

    по кількості сутностей у зв'язку:
      - унарні (посилання запису з таблиці на інший запис с цієї таблиці 
      | відповідь на повідомлення)
      - бінарний (запис з однієї таблиці посилається запис з іншої 
      | студент - екзамен | екзамен - дисципліна
      )
      - тернарний (набагато рідший, досить часто можна перетворити на бінарний)

    Вид зв'язку:
      - 1 : 1 ( людина - ідентифікаційний код, машина - водій)
      - 1 : m (найчастіший, один викладач - багато груп, один автор - багато книг, один тімлід - багато проектів)
      - m : n (чати- користувачі, замовлення - товари)

    По обов'язковості:
    - Жорсткі (обов'язкові, 1)
    - Нежорсткі (необов'язкові, 0)
    машина 0 : 0 водій
    людина 1 : 0 ідентифікаційний код

*/

-- 1 : 1
CREATE TABLE countries (
  id SERIAL PRIMARY KEY,
  name TEXT
);
--
CREATE TABLE presidents (
  id SERIAL PRIMARY KEY,
  name TEXT,
  country_id INT NOT NULL UNIQUE REFERENCES countries DEFERRABLE INITIALLY DEFERRED
);
--
ALTER TABLE countries
ADD COLUMN  president_id INT NOT NULL UNIQUE REFERENCES presidents DEFERRABLE INITIALLY DEFERRED;
--
BEGIN; -- транзакція розпочата
INSERT INTO countries (name, president_id)
VALUES 
('Ukraine', 1);
INSERT INTO presidents (name, country_id) 
VALUES
('Volodymyr Zelenskyy', 1);
COMMIT; -- транзакція завершена

DROP TABLE countries CASCADE;

DROP TABLE presidents CASCADE;