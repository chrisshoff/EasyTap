require "coffee-script"
express = require "express"
untappd = require "./untappd"

app = express.createServer()
app.use express.static "#{__dirname}/public"
app.use express.bodyParser()
app.listen 3000
console.log "Server started at localhost:3000"

app.get '/', (req, res) ->
	res.sendfile "#{__dirname}/index.html"

app.get '/beer/:id', (req, res) ->
	console.log req.param 'id'

app.post '/create', (req, res) ->
	beer_id = req.param "beer_id"
	untappd.generate_checkin_url beer_id, (url) ->
		console.log url
		res.sendfile "#{__dirname}/index.html"