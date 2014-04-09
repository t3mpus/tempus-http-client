should = require 'should'
async = require 'async'
_ = require 'underscore'
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
      start: new Date('May 4 1988')
      end: new Date()
      message: "client created entry #{do {v1} = require 'uuid'}"
      projectId: project.id
    }, (err, entry) ->
      throw err if err
      entry.project = project
      sweeper.add entry
      checker entry
      session.timeEntry.get entry.id, (err, entry) ->
        throw err if err
        checker entry
        done()

  it 'cannot get a bad time entry', (done)->
    session.timeEntry.get Number.MAX_VALUE, (err, entry)->
      err.should.have.property 'statusCode', 404
      should.ok !entry
      done()

  createTestEntries = (num, id, cb) ->
    async.each [1..num], (n, ncb)->
      session.timeEntry.create {
        start: new Date('May 4 1988')
        end: new Date()
        message: "test entry for project #{do {v4} = require 'uuid'}"
        projectId: id
      }, (err, entry)->
        return ncb(err) if err
        entry.project = project
        sweeper.add entry
        ncb()
    , cb


  it 'can get time entries for a project', (done)->
    createTestEntries 100, project.id, (err) ->
      throw err if err
      session.timeEntry.getForProject project.id, (err, entries)->
        throw err if err
        _.each entries, checker
        done()

