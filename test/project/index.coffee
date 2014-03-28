{flush} = require './sweeper'
{v1} = require 'uuid'
session = require('../session-store')()
userSweeper = require('../user/sweeper')
{series} = require 'async'

describe 'Project', ->

  user = null

  before (done)->
    email = v1() + "-test-user@email.com"
    session.user.create {
      firstName: 'Test'
      lastName: 'User'
      email: email
      password: "password"
    }, (err, user) ->
      throw err if err
      userSweeper.add user
      done()


  describe 'Create', require('./create') user

  #describe 'Get', require './get'

  #describe 'Delete', require './delete'

  after (done) ->
    series [flush, userSweeper.flush], done
