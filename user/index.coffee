class User extends require('../base.coffee')

  resource: "users"

module.exports = (ops)->
  new User ops
