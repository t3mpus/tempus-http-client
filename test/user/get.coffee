should = require 'should'
index = require '../session-store'
uuid = require 'uuid'
sweeper = require './sweeper'
checker = require './checker'

describe 'User Get', ->

  session = null

  before -> session = index()

  it 'should allow user get', (done) ->
    email = uuid.v1() + "-test-user@email.com"
    session.user.createUser {
      firstName: 'Test'
      lastName: 'User'
      email: email
      password: "password"
    }, (err, user) ->
      throw err if err
      checker user, yes
      session.setCredentials user.credentials
      session.user.get user.id, (err, user)->
        throw new Error err.message if err?
        done()
