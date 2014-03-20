should = require 'should'
index = require '../session-store'
uuid = require 'uuid'

describe 'User Creations', ->

  session = null

  before -> session = new index()

  it 'should allow user deletion', (done) ->
    email = uuid.v1() + "-test-user@email.com"
    session.user.createUser {
      firstName: 'Test'
      lastName: 'User'
      email: email
      password: "password"
    }, (err, user) ->
      throw err if err
      session.user.delete user.id, (err)->
        throw err if err
        done()
