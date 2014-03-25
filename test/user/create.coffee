should = require 'should'
index = require '../session-store'
sweeper = require './sweeper'
uuid = require 'uuid'
checker = require './checker'

describe 'User Creations', ->

  session = null

  before -> session = new index()

  after (done) -> sweeper.flush done

  it 'should allow user creation', (done) ->
    email = uuid.v1() + "-test-user@email.com"
    session.user.create {
      firstName: 'Test'
      lastName: 'User'
      email: email
      password: "password"
    }, (err, user) ->
      throw err if err
      checker user, yes
      sweeper.add user
      done()

  it 'should not allow a user without proper info register', (done)->
    session.user.create {
      firstNAME: 'bad'
      lastNAME: 'user'
      email: 'www.google.com'
      password: '#sorrynotsorry'
    }, (err, user) ->
      err.should.have.property 'statusCode', 400
      err.should.have.property 'message'
      throw new Error "User object shouldn't be defined" if user
      done()
