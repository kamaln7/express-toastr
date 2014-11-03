entities = require 'entities'

_escape = (string) ->
  entities.encodeHTML(string).replace "'", "\\'"

add = (req, type, message, title = '', options = {}) ->
  # If we don't clear the _toasts flash item beforehand, existing toasts will be duplicated
  if req.session.flash?._toasts? then req.session.flash._toasts = undefined

  req._t.push {type, message, title, options}
  req.flash '_toasts', req._t

render = (req) ->
  output = '<script type="text/javascript">'
  for toast in req.flash '_toasts'
    output += "toastr.options=#{JSON.stringify toast.options};"
    args = []

    args.push _escape toast.message
    if toast.title then args.push _escape toast.title

    args = args.map (arg) -> "'#{arg}'"
    output += "toastr.#{toast.type}(#{args.join ','});"
  output += '</script>'

  output

module.exports = (req, res, next) ->
  req._t = []
  req.toastr =
    add: add.bind null, req
    render: render.bind null, req
    info: -> @add 'info', arguments...
    warning: -> @add 'warning', arguments...
    error: -> @add 'error', arguments...
    success: -> @add 'success', arguments...

  next()
