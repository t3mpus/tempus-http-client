should = require 'should'
sweeper = require './sweeper'
checker = require './checker'

session = require('../session-store')()

getUser = require('./user')

module.exports = ->
  user = null

  before (done) ->
    getUser (u) ->
      user = u
      session.setCredentials user.credentials
      done()

  it 'can get a project', (done)->
    session.project.create {
      name: 'Project Test Create'
      createdDate: new Date().toJSON()
    }, (err, project) ->
      throw err if err
      project.user = user
      sweeper.add project
      checker project
      session.project.get project.id, (err, project) ->
        throw err if err
        checker project
        done()

  it 'cannot get a bad project', (done) ->
    session.project.get Number.MAX_VALUE, (err)->
      err.should.have.property 'statusCode'
      done()
