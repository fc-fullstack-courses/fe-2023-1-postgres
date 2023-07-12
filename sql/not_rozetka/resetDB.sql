DROP TABLE IF EXISTS products_to_orders CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS manufacturers CASCADE;
DROP TABLE IF EXISTS users CASCADE;
--
CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(64) NOT NULL CHECK (first_name != ''),
  last_name VARCHAR(64) NOT NULL CHECK (last_name != ''),
  email VARCHAR(128) NOT NULL UNIQUE CHECK (email != ''),
  "password" VARCHAR (64) NOT NULL CHECK ("password" != ''),
  hair_color VARCHAR(64) CHECK(hair_color != ''),
  foot_size NUMERIC(3, 1) CHECK(
    foot_size BETWEEN 20 AND 50
  ),
  is_male BOOLEAN,
  weight NUMERIC(5, 2) CHECK(
    weight BETWEEN 0.1 AND 999
  ),
  height NUMERIC(3, 2) CHECK(
    height BETWEEN 0.5 AND 3
  ),
  birthday DATE CHECK(
    birthday <= current_date
    AND birthday > '1900-1-1'
  ),
  created_at timestamp NOT NULL DEFAULT current_timestamp,
  updated_at timestamp NOT NULL DEFAULT current_timestamp
);
-- 0 : 1 (нежорстке)
CREATE TABLE manufacturers (
  id SERIAL PRIMARY KEY,
  user_id INT NOT NULL UNIQUE REFERENCES users ON DELETE CASCADE ON UPDATE CASCADE,
  -- обов'язково має бути користувач
  created_at timestamp NOT NULL DEFAULT current_timestamp,
  updated_at timestamp NOT NULL DEFAULT current_timestamp
);
--
ALTER TABLE users
ADD COLUMN manufacturer_id INT UNIQUE REFERENCES manufacturers ON DELETE CASCADE ON UPDATE CASCADE;
--
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_id INTEGER NOT NULL REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE,
  created_at timestamp NOT NULL DEFAULT current_timestamp,
  updated_at timestamp NOT NULL DEFAULT current_timestamp
);
--
CREATE TABLE IF NOT EXISTS products (
  "id" SERIAL PRIMARY KEY,
  manufacturer_id INT NOT NULL REFERENCES manufacturers ON DELETE CASCADE ON UPDATE CASCADE,
  "name" VARCHAR(200) NOT NULL CHECK("name" != ''),
  "category" VARCHAR(128) NOT NULL CHECK("category" != ''),
  "price" NUMERIC(15, 2) CHECK ("price" > 0),
  "quantity" INT NOT NULL CHECK("quantity" >= 0),
  created_at timestamp NOT NULL DEFAULT current_timestamp,
  updated_at timestamp NOT NULL DEFAULT current_timestamp,
  UNIQUE("name", "category")
);
--
CREATE TABLE products_to_orders (
  product_id INT REFERENCES products ON DELETE CASCADE ON UPDATE CASCADE,
  order_id INT REFERENCES orders ON DELETE CASCADE ON UPDATE CASCADE,
  quantity INT NOT NULL CHECK(quantity > 0),
  PRIMARY KEY (product_id, order_id)
);