express = require 'express'
flash = require 'connect-flash'
session = require 'express-session'
cookieParser = require 'cookie-parser'
# This is so the latest version is loaded when running the tests
# You should use: require 'express-toastr'
toastr = require '../'

app = express()
app.use cookieParser 'secret'
app.use session secret: 'secret', saveUninitialized: true, resave: true
app.use flash()
app.use toastr {
  closeButton: true
}

app.get '/set', (req, res) ->
  req.toastr.info 'Are you the 6 fingered man?'
  req.toastr.warning 'My name is Inigo Montoya. You killed my father, prepare to die!', null, {closeButton: false}
  req.toastr.success 'Have fun storming the castle!', 'Miracle Max Says', null, {newestOnTop: true}
  req.toastr.error 'I do not think that word means what you think it means.', 'Inconceivable!'

  # Return 200 OK
  res.end()

app.get '/clear', (req, res) ->
  req.toastr.error 'This is a toast!', 'Oh no!'
  req.toastr.clear()
  req.toastr.info 'The previous toasts were cleared.'

  # Return 200 OK
  res.end()

app.get '/', (req, res) ->
  res.send req.toastr.render()

# Used in test/example.coffee
app.get '/ping', (req, res) ->
  res.send 'pong'

module.exports = app

# if app is run as a script and not required as a module
if not module.parent
  app.listen port = process.env.PORT || 4000, ->
    console.log "Listening on #{port}"
