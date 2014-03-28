should = require 'should'
sweeper = require './sweeper'
uuid = require 'uuid'
checker = require './checker'

session = require('../session-store')()

testUser = null

tests = ()->

  it 'can create a project'

  it 'will fail bad info'

module.exports = (providedUser) ->
  testUser = providedUser
  return tests
