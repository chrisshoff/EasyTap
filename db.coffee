mongo = require "mongodb"
untappd = require "./untappd"

class EasyTapDb
	
	create : (id, callback) ->
		db = new mongo.Db 'easy-tap-db', (new mongo.Server 'localhost', 27017, {}), native_parser : false
		db.open (err, db) ->
			db.collection 'beers', (err, collection) ->
				collection.insert 'beer_id' : id, (err, docs) ->
					callback docs[0]._id

	get : (id, callback) ->
		db = new mongo.Db 'easy-tap-db', (new mongo.Server 'localhost', 27017, {}), native_parser : false
		db.open (err, db) ->
			db.collection 'beers', (err, collection) ->
				collection.findOne { _id : new mongo.ObjectID(id) }, (err, result) ->
					untappd.fetch_beer result.beer_id, (beer) ->
						callback beer

module.exports = new EasyTapDb