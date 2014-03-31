should = require 'should'

check = (entry) ->
  entry.should.have.property 'id'
  entry.should.have.property 'name'

module.exports = check
