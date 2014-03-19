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

  url: (uri) ->
    env = process.NODE_ENV
    if env
      env = env.toLowerCase()
    if not env or env is 'development'
      host = 'http://localhost'
      port = '3000'
    else
      console.log 'Client running in production mode'
      throw new Error """
        We are not ready to target anything but development
        """
    s = "#{host}"
    if port
      s += ":#{port}"
    if uri
      s += "/#{encodeURIComponent uri}"

    return s



  req_options: (uri, body) ->
    url: @url uri
    json: true
    body: body if body

  request: (method, uri, body, cb) ->
    fun = request[method]
    if !fun
      throw new Error "Request doesn't have #{method} defined"
    if typeof fun isnt 'function'
      throw new Error "Request #{method} is not a function"

    if typeof body is 'function'
      cb = body

    options = @req_options uri, body

    fun options, (err, res, resBody)->
      cb res, resBody

module.exports = Base
