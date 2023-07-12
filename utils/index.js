const _ = require('lodash');
const {
  users: {
    hairColors,
    maxFootSize,
    maxHeight,
    maxWeight,
    minFootSize,
    minHeight,
    minWeight,
  },
  products: {
    minPrice,
    minQuantity,
    maxPrice,
    maxQuantity,
    categories,
    amountProducts,
  },
  orders: {
    minOrders,
    maxOrders,
    minOrderQuantity,
    maxOrderQuantity,
    minProductsInOrder,
    maxProductsInOrder,
  },
} = require('../configs/randomGeneration.json');

const generateUser = (u) => {
  const {
    gender,
    name: { first, last },
    email,
    login: { password },
    dob: { date },
  } = u;

  const weight = _.random(minWeight, maxWeight, true);
  const height = _.random(minHeight, maxHeight, true);
  const footSize = _.random(minFootSize, maxFootSize, false);

  const hairColor = hairColors[_.random(0, hairColors.length - 1, false)];

  return `('${first}', '${last}', '${email}', '${password}', '${hairColor}', ${footSize}, ${
    gender === 'male'
  }, ${weight}, ${height}, '${date}')`;
};

module.exports.mapUsers = (users) =>
  users.map((user) => generateUser(user)).join(',');

const mapManufacturers = (users) =>
  users.map((user) => `(${user.id})`).join(',');

module.exports.mapManufacturers = mapManufacturers;

const generateProduct = (manufacturers, index) => {
  const manufacturerId =
    manufacturers[_.random(0, manufacturers.length - 1, false)].id;

  return `(
    ${manufacturerId},
    'Product ${index}',
    '${categories[_.random(0, categories.length - 1, false)]}',
    ${_.random(minPrice, maxPrice, true)},
    ${_.random(minQuantity, maxQuantity, false)}    
  )`;
};

module.exports.mapProducts = (
  manufacturers,
  amountOfProducts = amountProducts
) => {
  return new Array(amountOfProducts)
    .fill(undefined)
    .map((value, index) => generateProduct(manufacturers, index))
    .join(',');
};

const mapOrders = (users) =>
  users
    .map((user) =>
      new Array(_.random(minOrders, maxOrders, false))
        .fill(undefined)
        .map(() => `(${user.id})`)
        .join(',')
    )
    .join(',');

const mapOrdersToProducts = (orders, products) =>
  orders
    .map((order) => {
      // відбір продуктів
      const productsInOrder = new Array(
        _.random(minProductsInOrder, maxProductsInOrder)
      )
        .fill(undefined)
        .map(() => products[_.random(0, products.length - 1)]);

      // відалення повторюючихся продуктів
      const filteredProducts = [...new Set(productsInOrder)];
      // повертаємо рядок виду (1, 4 , 18)
      return filteredProducts
        .map(
          (product) =>
            `(${order.id}, ${product.id}, ${_.random(
              minOrderQuantity,
              maxOrderQuantity
            )})`
        )
        .join(',');
    })
    .join(',');

module.exports.mapOrders = mapOrders;
module.exports.mapOrdersToProducts = mapOrdersToProducts;
