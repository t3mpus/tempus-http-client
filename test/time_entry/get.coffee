should = require 'should'
sweeper = require './sweeper'
checker = require './checker'

session = require('../session-store')()

getProject = require('./project')

module.exports = ->
  project = null

  before (done) ->
    getProject (p) ->
      project = p
      session.setCredentials p.user.credentials
      done()

  it 'can get a time entry for project', (done)->
    session.timeEntry.create {
    }, (err, entry) ->
      throw err if err
      entry.project = project
      sweeper.add entry
      checker entry
      session.timeEntry.get entry.id, (err, entry) ->
        throw err if err
        checker entry
        done()

  it 'cannot get a bad time entry'
