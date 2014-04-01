should = require 'should'
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

  it 'can delete a time entry for project', (done)->
    session.timeEntry.create {
      start: new Date('May 4 1988')
      end: new Date()
      message: "client created entry #{do {v1} = require 'uuid'}"
      projectId: project.id
    }, (err, entry) ->
      throw err if err
      entry.project = project
      checker entry
      session.timeEntry.get entry.id, (err, entry) ->
        throw err if err
        checker entry
        session.timeEntry.delete entry.id, (err) ->
          throw err if err
          done()

  it 'cannot delete a non existent time entry', (done)->
    session.timeEntry.get Number.MAX_VALUE, (err) ->
      err.should.have.property 'statusCode', 404
      session.timeEntry.delete Number.MAX_VALUE, (err)->
        err.should.have.property 'statusCode', 404
        done()
