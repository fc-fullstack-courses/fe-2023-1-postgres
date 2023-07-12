const fs = require('fs').promises;
const _ = require('lodash');
const { Client } = require('pg');
const { getUsers } = require('./api');
const config = require('./configs/db.json');
const {
  manufacturers: { chanceOfBeingManufacturer },
  orders: { chanceToMakeOrder },
} = require('./configs/randomGeneration.json');
const {
  mapUsers,
  mapManufacturers,
  mapProducts,
  mapOrders,
  mapOrdersToProducts,
} = require('./utils');

const client = new Client(config);

start();
async function start() {
  await client.connect();

  const resetDBQuery = await fs.readFile(
    './sql/not_rozetka/resetDB.sql',
    'utf-8'
  );

  const users = await getUsers();

  await client.query(resetDBQuery);

  // створення користувачів
  const { rows: userIds } = await client.query(`
    INSERT INTO users (
      first_name,
      last_name,
      email,
      password,
      hair_color,
      foot_size,
      is_male,
      weight,
      height,
      birthday
    ) VALUES 
    ${mapUsers(users)}
    RETURNING id;
  `);

  // визначення виробників
  const manufacturers = userIds.filter(
    () => _.random(0, 100) <= chanceOfBeingManufacturer
  );

  // створення виробників
  const { rows: manufacturerIds } = await client.query(`
  INSERT INTO manufacturers (
    user_id
  ) VALUES
  ${mapManufacturers(manufacturers)}
  RETURNING id`);

  // створення продуктів
  const { rows: productIds } = await client.query(`
  INSERT INTO products (
    manufacturer_id,
    name,
    category,
    price,
    quantity
  ) VALUES
  ${mapProducts(manufacturerIds)}
  RETURNING id`);

  // створення замовлень
  const orderingUsers = userIds.filter(
    () => _.random(0, 100) <= chanceToMakeOrder
  );

  const { rows: orderIds } = await client.query(`
  INSERT INTO orders (
    customer_id
  ) VALUES
  ${mapOrders(orderingUsers)}
  RETURNING id`);

  // // заповнення замовлень
  await client.query(`
  INSERT INTO products_to_orders (
    order_id,
    product_id,
    quantity
  ) VALUES
  ${mapOrdersToProducts(orderIds, productIds)}
 `);

  await client.end();
}
