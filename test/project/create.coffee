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

  it 'can create a project', (done)->
    session.project.create {
      name: 'Project Test Create'
      createdDate: new Date().toJSON()
    }, (err, project) ->
      throw err if err
      project.user = user
      sweeper.add project
      checker project
      done()


  it 'will fail bad info', (done)->
    session.project.create {
      badKey: 'badkey'
    }, (err) ->
      err.statusCode.should.be.equal 400
      done()
