{flush} = require './sweeper'
userSweeper = require('../user/sweeper')
{series} = require 'async'

describe 'Project', ->

  describe 'Create', require './create'

  #describe 'Get', require './get'

  #describe 'Delete', require './delete'

  after (done) ->
    series [flush, userSweeper.flush], done
