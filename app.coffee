require "coffee-script"
express = require "express"
untappd = require "./untappd"
qr = require "./qr"
jade = require "jade"

app = express.createServer()
app.use express.static "#{__dirname}/public"
app.use express.bodyParser()
app.listen 3000
console.log "Server started at localhost:3000"

app.get '/', (req, res) ->
	res.render "index.jade", {}

app.get '/choose/:id', (req, res) ->
	id = req.param "id"
	qr.url "http://localhost:3000/checkin/#{id}", '300x300', (url) ->
		res.render "qr_code.jade", url : url 

app.post '/search', (req, res) ->
	beer_name = req.param "beer_name"
	untappd.find_matching_beers beer_name, (beers) ->
		res.render "choose.jade", beers : beers