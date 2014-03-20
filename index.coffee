_ = require 'underscore'
credentials = require './credentials'

class TempusHTTPClient
  constructor: (ops) ->

    modules = [
      'user'
    ]

    _.each modules, (m)=>
      @[m] = require("./#{m}")(ops)

  setCredentials: (streetCred) ->
    credentials.set streetCred

module.exports = TempusHTTPClient
