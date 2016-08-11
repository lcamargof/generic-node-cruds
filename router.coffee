models = require './database/models'
Promise = require 'bluebird'
fs = Promise.promisifyAll(require 'fs')
Concept = models.getConceptModel
Receiver = models.getReceiverModel
Unit = models.getUnitModel
InvoiceTransactions = models.getInvoiceTransactionModel

module.exports = (app) ->
	app.use (req, res, next) ->
		res.header "Access-Control-Allow-Origin", "*"
		res.header "Access-Control-Allow-Methods", 'GET,PUT,POST,DELETE,OPTIONS'
		res.header "Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept"
		next()

	################
	### CONCEPTS ###
    ################
	app.get '/concepts', (req, res) ->
		Concept.findAsync().then (data) -> res.json data

	app.post '/concepts', (req, res) ->
		concept = new Concept
			name: req.body.name
			description: req.body.description
			unit_price: req.body.unit_price
			metric_unit: req.body.metric_unit
			discount: req.body.discount
			vat: req.body.vat
			stps: req.body.stps
			imp: req.body.imp
			retention_vat: req.body.retention_vat
			retention_isr: req.body.retention_isr
			id_rfc: req.body.id_rfc

		concept.saveAsync()
		.then((data) -> res.json data)
		.catch (data) -> res.status(500).json {result: data}

	app.get '/concepts/:id', (req, res) ->
		Concept.findOneAsync({_id: req.params.id})
		.then (data) -> res.json data

	app.put '/concepts/:id', (req, res) ->
		Concept.findOneAsync({_id: req.params.id})
		.then((concept) ->
			concept.name = req.body.name
			concept.description = req.body.description
			concept.unit_price = req.body.unit_price
			concept.metric_unit = req.body.metric_unit
			concept.discount = req.body.discount
			concept.vat = req.body.vat
			concept.stps = req.body.stps
			concept.imp = req.body.imp
			concept.retention_vat = req.body.retention_vat
			concept.retention_isr = req.body.retention_isr
			concept.id_rfc = req.body.id_rfc
			concept.saveAsync()
		).then((data) -> res.json data)
		.catch (data) -> res.status(500).json {result: data}

	app.delete '/concepts/:id', (req, res) ->
		Concept.removeAsync({_id: req.params.id})
		.then((data) -> res.json {result: 'success'})
		.catch (data) -> res.status(500).json {result: data}


	#################
	### RECEIVERS ###
	#################

	app.get '/receivers', (req, res) ->
		Receiver.findAsync().then (data) -> res.json data

	app.post '/receivers', (req, res) ->
		receiver = new Receiver
			name: req.body.name
			email: req.body.email
			rfc: req.body.rfc
			type: req.body.type
			phone: req.body.phone
			street: req.body.street
			ext_number: req.body.ext_number
			int_number: req.body.int_number
			colony: req.body.colony
			zip_code: req.body.zip_code
			municipality: req.body.municipality
			state: req.body.state
			country: req.body.country
			website: req.body.website
			id_rfc: req.body.id_rfc

		receiver.saveAsync()
		.then((data) -> res.json data)
		.catch (data) -> res.status(500).json {result: data}

	app.get '/receivers/:id', (req, res) ->
		Receiver.findOneAsync({_id: req.params.id})
		.then (data) -> res.json data

	app.put '/receivers/:id', (req, res) ->
		Receiver.findOneAsync({_id: req.params.id})
		.then((receiver) ->
			receiver.name = req.body.name
			receiver.email = req.body.email
			receiver.rfc = req.body.rfc
			receiver.type = req.body.type
			receiver.phone = req.body.phone
			receiver.street = req.body.street
			receiver.ext_number = req.body.ext_number
			receiver.int_number = req.body.int_number
			receiver.colony = req.body.colony
			receiver.zip_code = req.body.zip_code
			receiver.municipality = req.body.municipality
			receiver.state = req.body.state
			receiver.country = req.body.country
			receiver.website = req.body.website
			receiver.id_rfc = req.body.id_rfc
			receiver.saveAsync()
		).then((data) -> res.json data)
		.catch (data) -> res.status(500).json {result: data}

	app.delete '/receivers/:id', (req, res) ->
		Receiver.removeAsync({_id: req.params.id})
		.then((data) -> res.json {result: 'success'})
		.catch (data) -> res.status(500).json {result: data}

	#################
	### UNITS     ###
	#################

	app.get '/units', (req, res) ->
		Unit.findAsync().then (data) -> res.json data

	app.post '/units', (req, res) ->
		receiver = new Unit name: req.body.name
		receiver.saveAsync()
		.then((data) -> res.json data)
		.catch (data) -> res.status(500).json {result: data}

	app.get '/units/:id', (req, res) ->
		Unit.findOneAsync({_id: req.params.id})
		.then (data) -> res.json data

	app.put '/units/:id', (req, res) ->
		Unit.findOneAsync({_id: req.params.id})
		.then((receiver) ->
			receiver.name = req.body.name
			receiver.saveAsync()
		).then((data) -> res.json data)
		.catch (data) -> res.status(500).json {result: data}

	app.delete '/units/:id', (req, res) ->
		Unit.removeAsync({_id: req.params.id})
		.then((data) -> res.json {result: 'success'})
		.catch (data) -> res.status(500).json {result: data}

	### INVOICE EMULATED ###
	app.get '/invoice', (req, res) ->
		fs.readFileAsync("#{__dirname}/invoices.json")
		.then((data) -> res.json JSON.parse(data.toString('utf8')) )
		.catch (err) -> res.status(500).json result: err

	# Invoice transactions
	app.get '/invoicetransactions/:id', (req, res) ->
		InvoiceTransactions.findAsync(_invoiceId: req.params.id)
		.then((data) -> res.json data )
		.catch (err) -> res.status(500).json result: err

	app.post '/invoicetransactions', (req, res) ->
		transaction = new InvoiceTransactions
			amount: req.body.amount
			reference: req.body.reference
			_invoiceId: req.body.id
		transaction.saveAsync()
		.then((data) -> res.json data)
		.catch (err) -> res.status().json data

	app.post '/mock', (req, res) ->
		wait = ->
			percent = Math.random()

			if percent < 0.1
				Math.floor(Math.random() * 30000) + 10000;
			else if percent < 0.3
				Math.floor(Math.random() * 1000) + 500;
			else
				Math.floor(Math.random() * 500) + 1;

		howLong = wait()

		setTimeout ->
			console.log 'recibi', howLong
			res.send 'OKAY!!!'
		, howLong