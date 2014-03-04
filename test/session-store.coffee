index = require '../index'

module.exports = ()->
  new index
    url: process.env.TEMPUS_API_URL || 'http://localhost:3000'
