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

module.exports = Base
