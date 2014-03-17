class User extends require('../base.coffee')

  resource: "users"

  createUser: (ops, cb)->
    @request @post, @route(), ops, (res, body) ->
      if res.statusCode is 200
        cb null, body
      else
        cb {
          statusCode: res.statusCode
        }, body

module.exports = (ops)->
  new User ops
