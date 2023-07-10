const _ = require('lodash');
const {
  hairColors,
  maxFootSize,
  maxHeight,
  maxWeight,
  minFootSize,
  minHeight,
  minWeight,
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
