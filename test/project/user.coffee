{v1} = require 'uuid'
session = require('../session-store')()
userSweeper = require('../user/sweeper')

user = null

module.exports = (cb) ->
  return cb(user) if user
  email = v1() + "-test-user@email.com"
  session.user.create {
    firstName: 'Test'
    lastName: 'User'
    email: email
    password: "password"
  }, (err, ruser) ->
    throw err if err
    userSweeper.add ruser
    user = ruser
    cb user


