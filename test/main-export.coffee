should = require 'should'
index = require '../index'


describe 'index', ->

  it 'should be a function constructor', ->
    index.should.have.type 'function'
    should.equal undefined, index()
    (new index()).should.have.type 'object'


