// Generated by CoffeeScript 1.10.0
(function() {
  var app, bodyParser, mongoose, routes;

  mongoose = require('mongoose');

  bodyParser = require('body-parser');

  global.db = mongoose.createConnection('mongodb://localhost/cruds');

  routes = require('./router');

  app = require('express')();

  app.use(bodyParser.json());

  app.use(bodyParser.urlencoded({
    extended: true
  }));

  routes(app);

  app.listen(3000, function() {
    return console.log('Servidor iniciado');
  });

  module.exports = app;

}).call(this);

//# sourceMappingURL=app.js.map