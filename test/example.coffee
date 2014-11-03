should = require 'should'
assert = require 'assert'
request = require 'supertest'

app = require '../example/index.js'
server =
port = 4000
url = "http://localhost:#{port}"
Cookies =

describe 'express-toastr', ->

  before (done) ->
    server = app.listen port, (err) ->
      if err
        done err
      else
        done()

  after (done) ->
    server.close()
    done()

  it 'should exist', (done) ->
    should.exist app
    done()

  it 'should be listening on localhost:4000', (done) ->
    request url
    .get '/ping'
    .expect 200
    .end (err, res) ->
      if err then throw err
      should(res.text).equal 'pong'
      done()

  it 'should set toasts properly (1/2)', (done) ->
    request url
    .get '/set'
    .expect 200
    .end (err, res) ->
      if err then throw err
      should(res.text).equal ''
      Cookies = res.headers['set-cookie'].pop().split(';')[0];
      done()

  it 'should set toasts properly (2/2)', (done) ->
    req = request url
    .get '/'
    req.cookies = Cookies
    req.expect 200
    .end (err, res) ->
      if err then throw err
      should(res.text).equal "<script type=\"text/javascript\">toastr.options={\"closeButton\":true};toastr.info('Are you the 6 fingered man&quest;');toastr.options={\"closeButton\":false};toastr.warning('My name is Inigo Montoya&period; You killed my father&comma; prepare to die&excl;');toastr.options={\"closeButton\":true};toastr.success('Have fun storming the castle&excl;','Miracle Max Says');toastr.error('I do not think that word means what you think it means&period;','Inconceivable&excl;');</script>"
      done()

  it 'should clear toasts that were viewed', (done) ->
    req = request url
    .get '/'
    req.cookies = Cookies
    req.expect 200
    .end (err, res) ->
      if err then throw err
      should(res.text).equal ''
      done()

  it 'should clear toasts when .clear() is called (1/2)', (done) ->
    req = request url
    .get '/clear'
    req.cookies = Cookies
    req.expect 200
    .end (err, res) ->
      if err then throw err
      should(res.text).equal ''
      done()

  it 'should clear toasts when .clear() is called (2/2)', (done) ->
    req = request url
    .get '/'
    req.cookies = Cookies
    req.expect 200
    .end (err, res) ->
      if err then throw err
      should(res.text).equal "<script type=\"text/javascript\">toastr.options={\"closeButton\":true};toastr.info('The previous toasts were cleared&period;');</script>"
      done()