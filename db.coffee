mongo = require "mongodb"
untappd = require "./untappd"

class EasyTapDb
	
	create : (beer, callback) ->
		db = new mongo.Db 'easy-tap-db', (new mongo.Server 'localhost', 27017, {}), native_parser : false
		db.open (err, db) ->
			db.collection 'beers', (err, collection) ->
				collection.insert 'beer' : beer, (err, docs) ->
					callback docs[0]._id

	get : (id, callback) ->
		db = new mongo.Db 'easy-tap-db', (new mongo.Server 'localhost', 27017, {}), native_parser : false
		db.open (err, db) ->
			db.collection 'beers', (err, collection) ->
				collection.findOne { _id : new mongo.ObjectID(id) }, (err, result) ->
					callback result.beer

	get_all : (callback) ->
		db = new mongo.Db 'easy-tap-db', (new mongo.Server 'localhost', 27017, {}), native_parser : false
		db.open (err, db) ->
			db.collection 'beers', (err, collection) ->
				collection.find {}, (err, cursor) ->
					cursor.toArray (err, result) ->
						callback result

module.exports = new EasyTapDb