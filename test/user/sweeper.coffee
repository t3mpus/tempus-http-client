users = []
session = require('../session-store')()
{filter} = require 'async'

module.exports =
  flush: (cb)->
    filter users
      ,(u, c) ->
        session.user.delete u.id, (err) ->
          c null, err?
      ,(left) ->
        if left?.length > 0
          throw new Error 'not all users deleted'
        cb()

  add: (user)-> users.push user

