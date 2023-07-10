const { Client } = require('pg');
const _ = require('lodash');
const { getUsers } = require('./api');

const config = {
  user: 'postgres',
  password: 'postgres',
  host: 'localhost',
  port: 5432,
  database: 'fe_2023_1_not_rozetka',
};

const client = new Client(config);

const hairColors = [
  'black',
  'brown',
  'blonde',
  'red',
  'ginger',
  'white',
  'green',
  'pale',
  'blue',
  'rainbow',
];

function generateUser(u) {
  const {
    gender,
    name: { first, last },
    email,
    login: { password },
    dob: { date },
  } = u;

  const weight = _.random(50, 150, true);
  const height = _.random(1, 3, true);
  const footSize = _.random(20, 50, false);

  const hairColor = hairColors[_.random(0, hairColors.length - 1, false)];

  return `('${first}', '${last}', '${email}', '${password}', '${hairColor}', ${footSize}, ${
    gender === 'male'
  }, ${weight}, ${height}, '${date}')`;
}

function mapUsers(users) {
  return users.map((user) => generateUser(user)).join(',');
}
start();
async function start() {
  await client.connect();

  const users = await getUsers();

  await client.query(`
  CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(64) NOT NULL CHECK (first_name != ''),
    last_name VARCHAR(64) NOT NULL CHECK (last_name != ''),
    email VARCHAR(128) NOT NULL UNIQUE CHECK (email != ''),
    "password" VARCHAR (64) NOT NULL CHECK ("password" != ''),
    hair_color VARCHAR(64) CHECK(hair_color != ''),
    foot_size NUMERIC(3,1) CHECK(foot_size BETWEEN 20 AND 50),
    is_male BOOLEAN,
    weight NUMERIC(5, 2) CHECK(
      weight BETWEEN 0.1 AND 999
    ),
    height NUMERIC(3, 2) CHECK(
      height BETWEEN 0.5 AND 3
    ),
    birthday DATE CHECK(birthday <= current_date AND birthday > '1900-1-1'),
    created_at timestamp NOT NULL DEFAULT current_timestamp,
    updated_at timestamp NOT NULL DEFAULT current_timestamp
  );
  `);

  await client.query(`
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
    ${mapUsers(users)};
  `);

  await client.end();
}
