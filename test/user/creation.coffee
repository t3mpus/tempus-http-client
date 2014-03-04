should = require 'should'
index = require '../session-store'

describe 'User Creations', ->

  session = null

  before -> session = new index()

  it 'should allow user creation'
