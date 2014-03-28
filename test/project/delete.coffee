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

  it 'can delete a project', (done)->
    session.project.create {
      name: 'Project Test Create'
      createdDate: new Date().toJSON()
    }, (err, project) ->
      throw err if err
      checker project
      session.project.get project.id, (err, project) ->
        throw err if err
        checker project
        session.project.delete project.id, (err) ->
          throw err if err
          done()

  it 'cannot delete a non existent project', (done)->
    id = Number.MAX_VALUE
    session.project.get id, (err) ->
      err.should.have.property 'statusCode'
      session.project.delete id, (err) ->
        err.should.have.property 'statusCode'
        done()
