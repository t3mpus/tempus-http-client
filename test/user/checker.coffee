should = require 'should'

check = (user, created = no) ->
  user.should.have.property 'id'
  user.should.have.property 'firstName', 'Test'
  user.should.have.property 'lastName', 'User'
  user.should.have.property 'email'
  if created
    user.should.have.property 'credentials'
    user.credentials.should.have.property 'secret'
    user.credentials.should.have.property 'userId'

module.exports = check
