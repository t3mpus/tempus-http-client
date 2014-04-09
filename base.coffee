request = require 'request'
capitalize = require 'capitalize'
plural = require 'plural'
credentials = require './credentials'

class Base

  constructor: (@options)->
    if @belongs_to?
      @establish_belongs_to()

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


  handler: (verb, path, ops, cb) ->
    if typeof ops is 'function'
      cb = ops
      ops = null

    @request verb, path, ops, (res, body)->
      if res.statusCode is 200
        cb null, body
      else
        cb {
          statusCode: res.statusCode
          message: body.error
        }

  ###
  # Relationship logic
  ###
  establish_belongs_to:()->
    @["getFor#{capitalize @belongs_to}"] = (id, cb) =>
      @handler "get", "#{plural @belongs_to, 2}/#{id}/#{@resource}", cb

  ###
  # CRUD functionality
  ###

  create: (ops, cb)->
    @handler "post", @route(), ops, cb

  delete: (id, cb)->
    @handler "del", "#{@route()}/#{id}", cb

  get: (id, cb) ->
    @handler "get", "#{@route()}/#{id}", cb

module.exports = Base
