const axios = require('axios').default;
const { results, seed } = require('../configs/api.json');

// axios.get('url')

const http = axios.create({
  baseURL: 'https://randomuser.me/api',
});

// http.get('users')

module.exports.getUsers = async () => {
  const {
    data: { results: users },
  } = await http.get(`?results=${results}&seed=${seed}&page=1`);

  return users;
};
