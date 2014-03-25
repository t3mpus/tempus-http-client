users = []
session = require('../session-store')()
{filterSeries} = require 'async'

module.exports =
  flush: (cb)->
    filterSeries users
      ,(u, c) ->
        session.setCredentials u.credentials
        session.user.delete u.id, (err) ->
          c null, err?
      ,(left) ->
        if left?.length > 0
          throw new Error 'not all users deleted'
        cb()

  add: (user)-> users.push user

