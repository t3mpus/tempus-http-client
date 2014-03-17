should = require 'should'
index = require '../session-store'
uuid = require 'uuid'

describe 'User Creations', ->

  session = null

  before -> session = new index()

  it 'should allow user creation', (done) ->
    email = uuid.v1() + "-test-user@email.com"
    session.user.createUser {
      firstName: 'Test'
      lastName: 'User'
      email: email
      password: "password"
    }, (err, user) ->
      throw err if err
      user.should.have.property 'id'
      user.should.have.property 'firstName', 'Test'
      user.should.have.property 'lastName', 'User'
      user.should.have.property 'email'
      user.should.have.property 'credentials'
      user.credentials.should.have.property 'secret'
      user.credentials.should.have.property 'user_identifier'
      done()

  it 'should not allow a user without proper info register', (done)->
    session.user.createUser {
      firstNAME: 'bad'
      lastNAME: 'user'
      email: 'www.google.com'
      password: '#sorrynotsorry'
    }, (err, user) ->
      err.should.have.property 'statusCode', 400
      err.should.have.property 'message'
      throw new Error "User object shouldn't be defined" if user
      done()
