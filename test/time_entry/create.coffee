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

  it 'can create a time entry for project', (done)->
    session.timeEntry.create {
      start: new Date('May 4 1988')
      end: new Date()
      message: "client created entry #{do {v1} = require 'uuid'}"
      projectId: project.id
    }, (err, entry) ->
      throw err if err
      entry.project = project
      sweeper.add entry
      checker entry
      done()
