{v1} = require 'uuid'
session = require('../session-store')()
userSweeper = require('../user/sweeper')
projectSweeper = require('../project/sweeper')

user = null
project = null

module.exports = (cb) ->
  if user and project
    project.user = user
    return cb project
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
    session.setCredentials user.credentials
    session.project.create {
      name: "Test project #{v1()}"
      createdDate: new Date().toJSON()
    }, (err, rproject) ->
      throw err if err
      project = rproject
      project.user = user
      projectSweeper.add project
      cb project


