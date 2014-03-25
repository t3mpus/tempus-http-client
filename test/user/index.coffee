{flush} = require './sweeper'

describe 'User', ->

  describe 'Create', require './create'

  describe 'Get', require './get'

  describe 'Delete', require './delete'

  after flush
