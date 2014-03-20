should = require 'should'
index = require '../session-store'
uuid = require 'uuid'

describe 'User deletion', ->

  session = null

  before -> session = index()

  it 'should allow user deletion', (done) ->
    email = uuid.v1() + "-test-user@email.com"
    session.user.createUser {
      firstName: 'Test'
      lastName: 'User'
      email: email
      password: "password"
    }, (err, user) ->
      throw err if err
      session.setCredentials user.credentials
      session.user.delete user.id, (err)->
        throw new Error err.message if err?
        done()
