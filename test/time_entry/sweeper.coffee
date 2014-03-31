time_entries = []
store = require('../session-store')
{filterSeries} = require 'async'

module.exports =
  flush: (cb)->
    filterSeries time_entries
      ,(t, c) ->
        session = store()
        session.setCredentials t.project.user.credentials
        session.timeEntry.delete t.id, (err) ->
          c null, err?
      ,(left) ->
        if left?.length > 0
          throw new Error 'not all time entries deleted'
        cb()

  add: (entry)->
    if not entry.project?.user?
      throw new Error "Test time entries must attach a user object with credentials"
    time_entries.push entry

