# Dependencies
cluster = require 'cluster'
numCpus = 4
mongoose = require 'mongoose'
bodyParser = require 'body-parser'

if cluster.isMaster
	cluster.fork() for i in [0 .. 4]
else
	# init mongo
	global.db = mongoose.createConnection 'mongodb://localhost/cruds'

	# modules
	routes = require './router'

	# Express
	app = require('express')()
	app.use bodyParser.json()
	app.use bodyParser.urlencoded extended: true

	# init
	routes app

	app.listen 3000, -> console.log 'Servidor iniciado'

	module.exports = app