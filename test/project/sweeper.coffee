projects = []
store = require('../session-store')
{filterSeries} = require 'async'

module.exports =
  flush: (cb)->
    filterSeries projects
      ,(p, c) ->
        session = store()
        session.setCredentials p.user.credentials
        session.project.delete p.id, (err) ->
          c null, err?
      ,(left) ->
        if left?.length > 0
          throw new Error 'not all projects deleted'
        cb()

  add: (project)-> projects.push project

