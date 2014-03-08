request = require 'request'

class Base

  post: "post"
  get: "get"
  delete: "del"
  put: "put"
  head: "head"

  constructor: (@options)->

  route: (ex, qs)->
    @resource

  request: (method, uri, body, cb) ->
    fun = request[method]
    if !fun
      throw new Error "Request doesn't have #{method} defined"

module.exports = Base
