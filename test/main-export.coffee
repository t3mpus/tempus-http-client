should = require 'should'
index = require '../index'


describe 'index', ->

  it 'should be a function constructor', ->
    index.should.have.type 'function'
    should.equal undefined, index()
    (new index()).should.have.type 'object'

  it 'should have a function setCredentials', ->
    i = new index()
    i.should.have.property 'setCredentials'
    i.setCredentials.should.be.type 'function'

