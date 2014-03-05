_ = require 'underscore'

class TempusHTTPClient
  constructor: (ops) ->

    modules = [
      'user'
    ]

    _.each modules, (m)=>
      @[m] = require("./#{m}")(ops)

module.exports = TempusHTTPClient
