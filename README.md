express-toastr
==============

[![wercker status](https://app.wercker.com/status/784ad6f1bbeceac5ccc21784e855912d/s/master "wercker status")](https://app.wercker.com/project/bykey/784ad6f1bbeceac5ccc21784e855912d)

A toastr.js middleware for ExpressJS 4

## Installation

```
npm install express-toastr
```

## Requirements

`express-toastr` depends on `connect-flash`, `express-session`, and `cookie-parser` -- see the Usage section below.

## Usage

Require express-toastr as a middleware:

```javascript
// ExpressJS
var express = require('express')
// Dependencies
    ,flash = require('connect-flash')
    ,session = require('express-session')
    ,cookieParser = require('cookie-parser')
// express-toastr
    ,toastr = require('express-toastr');

// Initialize ExpressJS
var app = express();
// Dependencies
app.use(cookieParser('secret'));
app.use(session({
    secret: 'secret',
    saveUninitialized: true,
    resave: true
});
app.use(flash());

// Load express-toastr
// You can pass an object of default options to toastr(), see example/index.coffee
app.use(toastr());
```

In your controller:

```javascript
if (err)
{
    req.toastr.error('Invalid credentials.');
} else {
    req.toastr.success('Successfully logged in.', "You're in!");
}

//...

res.render('viewName', {req: req});
```

In your view:

```html
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/2.0.2/css/toastr.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/2.0.2/js/toastr.min.js"></script>
<%= req.toastr.render() %>
```

Alternatively, you can add a middleware as follows:

```javascript
app.use(function (req, res, next)
{
    res.locals.toasts = req.toastr.render()
    next()
});
```

and in your view:

```html
<!-- toastr.min.css, jquery.min.js, toastr.min.js -->
<%= toasts %>
```

Also see `example/index.coffee`.

### Available methods

```javascript
// Add an info toast
req.toastr.info(message, title = '', options = {})
// Add a warning toast
req.toastr.warning(message, title = '', options = {})
// Add an error toast
req.toastr.error(message, title = '', options = {})
// Add a success toast
req.toastr.success(message, title = '', options = {})
// Add a toast with a manually specified type
req.toastr.add(type, message, title = '', options = {})
// Clear existing toasts
req.toastr.clear()
```

## Testing

Run `npm test` to run the test suite or view the current test status [here](https://app.wercker.com/#applications/54590b5fec3d76d936000c19).

## License

The MIT License (MIT)

Copyright (c) 2014 Kamal Nasser

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
