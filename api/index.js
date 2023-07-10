const axios = require('axios').default;


// axios.get('url')

const http = axios.create({
  baseURL: 'https://randomuser.me/api'
})

// http.get('users')

module.exports.getUsers = async () => {
  const { data: { results } } = await http.get('?results=300&seed=fe-2023-1&page=1');

  return results;
}