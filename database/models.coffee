#################
# MONGODB SCHEMAS
#################

Promise = require 'bluebird'
mongoose = Promise.promisifyAll require('mongoose')
Schema = mongoose.Schema

# concepts collection
conceptSchema = Schema
	name: 'String'
	description: 'String'
	unit_price: 'Number'
	metric_unit: 'String'
	discount: 'Number'
	vat: 'Number'
	stps: 'Number'
	imp: 'Number'
	retention_vat: 'Number'
	retention_isr: 'Number'
	id_rfc: 'String'

# receivers collection
receiverSchema = Schema
	name: 'String'
	email: 'String'
	rfc: 'String'
	type: 'String'
	phone: 'String'
	street: 'String'
	ext_number: 'String'
	int_number: 'String'
	colony: 'String'
	zip_code: 'String'
	municipality: 'String'
	state: 'String'
	country: 'String'
	website: 'String'
	id_rfc: 'String'

# units collection
unitSchema = Schema name: 'String'

# Invoice Transaction collection
invoiceTransactionSchema = Schema
	date: type: Date, default: Date.now
	amount: 'Number'
	reference: type: String, default: 'n/a'
	_invoiceId: 'Number'

module.exports.getConceptModel = db.model 'Concept', conceptSchema
module.exports.getReceiverModel = db.model 'Receiver', receiverSchema
module.exports.getUnitModel = db.model 'Unit', unitSchema
module.exports.getInvoiceTransactionModel = db.model 'InvoiceTransaction', invoiceTransactionSchema