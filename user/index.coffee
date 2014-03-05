class User extends require('../base.coffee')

  resource: "users"

  createUser: (ops, cb)->
    @request @post, @route(), ops, cb

module.exports = (ops)->
  new User ops
