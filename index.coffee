_ = require 'underscore'
credentials = require './credentials'

class TempusHTTPClient
  constructor: (ops) ->

    modules = [
      'user'
      'project'
      {api: 'timeEntry', module: 'time_entry'}
    ]

    _.each modules, (m)=>
      if m.api? and m.module?
        @[m.api] = require("./#{m.module}")(ops)
      else
        @[m] = require("./#{m}")(ops)

  setCredentials: (streetCred) ->
    credentials.set streetCred

module.exports = TempusHTTPClient
