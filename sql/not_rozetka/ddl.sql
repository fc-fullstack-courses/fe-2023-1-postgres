CREATE TABLE products (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(200) NOT NULL CHECK("name" != ''),
  "category" VARCHAR(128) NOT NULL CHECK("category" != ''),
  "price" NUMERIC(15, 2) CHECK ("price" > 0),
  "quantity" INT NOT NULL CHECK("quantity" >= 0),
  created_at timestamp NOT NULL DEFAULT current_timestamp,
  updated_at timestamp NOT NULL DEFAULT current_timestamp,
  UNIQUE("name", "category")
);
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(64) NOT NULL CHECK (first_name != ''),
  last_name VARCHAR(64) NOT NULL CHECK (last_name != ''),
  email VARCHAR(128) NOT NULL UNIQUE CHECK (email != ''),
  "password" VARCHAR (64) NOT NULL CHECK ("password" != ''),
  created_at timestamp NOT NULL DEFAULT current_timestamp,
  updated_at timestamp NOT NULL DEFAULT current_timestamp
);
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_id INTEGER NOT NULL REFERENCES users (id), -- 1:m
  created_at timestamp NOT NULL DEFAULT current_timestamp,
  updated_at timestamp NOT NULL DEFAULT current_timestamp
);

-- m : n
CREATE TABLE products_to_orders (
  product_id INT REFERENCES products,
  order_id INT REFERENCES orders,
  quantity INT NOT NULL CHECK(quantity > 0),
  PRIMARY KEY (product_id, order_id)
);

-- Створення користувачів
INSERT INTO users (
first_name,
last_name,
email,
password
)
VALUES (
    'Anton',
    'Shevchenko',
    'anton@gmail.com',
    '12345admin'
  ),
(
    'User',
    'Userenko',
    'user@gmail.com',
    'lfbdciur3rg923enwoda'
  );
-- Створення замовлень
INSERT INTO orders (customer_id)
VALUES (1),
(2),
(1),
(1);
-- Створення товарів
INSERT INTO products (name, category, price, quantity)
VALUES (
    'пилосос',
    'побутова техніка',
    9999.99,
    1000
  ),
('Iphone XLXIV', 'смартфони', 35999.99, 1500),
('Телевізор', 'побутова техніка', 59999.99, 50),
('Чайник', 'дрібна техніка', 1500, 73);
-- Заповнення замовлень товарами
INSERT INTO products_to_orders
(order_id, product_id, quantity)
VALUES
(2, 2, 2),
(3, 4, 1),
(4, 1, 3),
(4, 3, 1),
(5,2,1),
(5,3,1),
(5,1,1),
(6,4,4);
--