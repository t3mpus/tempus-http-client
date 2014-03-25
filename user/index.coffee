class User extends require('../base.coffee')

  resource: "users"

  create: (ops, cb)->
    @request "post", @route(), ops, (res, body) ->
      if res.statusCode is 200
        cb null, body
      else
        cb {
          statusCode: res.statusCode
          message: body.error
        }

  delete: (id, cb)->
    @request "del", "#{@route()}/#{id}", (res, body)->
      if res.statusCode is 200
        cb null
      else
        cb {
          statusCode: res.statusCode
          message: body.error or body
        }

  get: (id, cb) ->
    @request "get", "#{@route()}/#{id}", (res, body)->
      if res.statusCode is 200
        cb null, body
      else
        cb {
          statusCode: res.statusCode
          message: body.error or body
        }

module.exports = (ops)->
  new User ops
