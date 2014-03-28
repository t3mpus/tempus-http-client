should = require 'should'

check = (project) ->
  project.should.have.property 'id'
  project.should.have.property 'name'

module.exports = check
