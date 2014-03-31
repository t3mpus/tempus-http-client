should = require 'should'
{each} = require 'underscore'

check = (entry) ->
  props = [
    'id'
    'message'
    'start'
    'end'
    'projectId'
    'userId'
  ]
  each props, (p) -> entry.should.have.property p
module.exports = check
