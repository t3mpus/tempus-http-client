request = require 'request'
credentials = require './credentials'

class Base

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
      s += "/#{uri}"

    return s

  req_options: (uri, body) ->
    url: @url uri
    json: true
    body: body if body
    hawk:
      credentials: credentials.get() if credentials.get()

  request: (method, uri, body, cb) ->
    fun = request[method]
    if !fun
      throw new Error "Request doesn't have #{method} defined"
    if typeof fun isnt 'function'
      throw new Error "Request #{method} is not a function"

    if typeof body is 'function'
      cb = body
      body = null

    options = @req_options uri, body

    fun options, (err, res, resBody)->
      cb res, resBody


  ###
  # CRUD functionality
  ###

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



module.exports = Base
