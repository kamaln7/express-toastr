entities = require 'entities'

_escape = (string) ->
  entities.encodeHTML(string).replace "'", "\\'"

_toasts =
  get: (req) -> req.flash '_toasts'
  set: (req) -> req.flash '_toasts', req._toasts

add = (req, type, message, title = '', options = {}) ->
  # If we don't clear the _toasts flash item beforehand, existing toasts will be duplicated for some reason
  if req.session.flash?._toasts? then req.session.flash._toasts = []

  req._toasts.push {type, message, title, options}
  _toasts.set req

clear = (req) ->
  req._toasts = []
  _toasts.set req

render = (req) ->
  toasts = _toasts.get req
  return unless toasts.length

  output = '<script type="text/javascript">'
  for toast in toasts
    output += "toastr.options=#{JSON.stringify toast.options};"
    args = []

    args.push _escape toast.message
    if toast.title then args.push _escape toast.title

    args = args.map (arg) -> "'#{arg}'"
    output += "toastr.#{toast.type}(#{args.join ','});"
  output += '</script>'

  output

module.exports = (req, res, next) ->
  # Initialize toasts as an empty array
  req._toasts = []

  req.toastr =
    add: add.bind null, req
    info: -> @add 'info', arguments...
    warning: -> @add 'warning', arguments...
    error: -> @add 'error', arguments...
    success: -> @add 'success', arguments...
    clear: clear.bind null, req
    render: render.bind null, req

  next()
