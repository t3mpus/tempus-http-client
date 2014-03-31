{flush} = require './sweeper'
userSweeper = require('../user/sweeper')
projectSweeper = require('../project/sweeper')
{series} = require 'async'

describe 'Time Entry', ->

  #describe 'Create', require './create'

  #describe 'Get', require './get'

  #describe 'Delete', require './delete'

  after (done) ->
    series [flush, projectSweeper.flush, userSweeper.flush], done
