# Dependencies
require "coffee-script"
express = require "express"
jade = require "jade"

# Libraries
untappd = require "./untappd"
qr = require "./qr"
db = require "./db"

# Setup server
app = express.createServer()
app.use express.static "#{__dirname}/public"
app.use express.bodyParser()
app.listen 3000

app.get '/', (req, res) ->
	db.get_all (beers) ->
		console.log beers
		res.render "index.jade", existing_beers : beers

app.get '/choose/:id', (req, res) ->
	id = req.param "id"
	qr.url "http://192.168.1.6:3000/checkin/#{id}", '300x300', (url) ->
		res.render "qr_code.jade", url : url 

app.get '/create/:id', (req, res) ->
	id = req.param "id"
	untappd.fetch_beer id, (beer) ->
		db.create beer, (id) ->
			res.redirect "/choose/#{id}"

app.get '/checkin/:id', (req, res) ->
	id = req.param "id"
	db.get id, (beer) ->
		untappd.checkin beer, (beer) ->
			res.render "checkin.jade", beer : beer

app.post '/search', (req, res) ->
	beer_name = req.param "beer_name"
	untappd.find_matching_beers beer_name, (beers) ->
		res.render "choose.jade", beers : beers