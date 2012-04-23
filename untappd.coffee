rest = require 'restler'
config = require './config'
md5 = require('crypto').createHash 'md5'

class Untappd
	api_key : config.untappd.api_key
	http : "http://"
	end_point : "api.untappd.com/v3/"
	api_search : "beer_search"
	api_fetch : "beer_info"
	api_checkin : "checkin_test"

	find_matching_beers : (name, callback) ->
		url = "#{@http}#{@end_point}#{@api_search}?key=#{@api_key}&q=#{name}".replace " ", "%20"
		rest.get(url).on "complete", (data) ->
			callback data.results

	fetch_beer : (id, callback) ->
		url = "#{@http}#{@end_point}#{@api_fetch}?key=#{@api_key}&bid=#{id}"
		rest.get(url).on "complete", (data) ->
			callback data.results

	checkin : (beer, callback) ->
		username = config.untappd.username
		md5.update config.untappd.password
		hash_pass = md5.digest('hex')
		url = "#{@http}#{username}:#{hash_pass}@#{@end_point}#{@api_checkin}?key=#{@api_key}"
		rest.post(url, data : {
				bid : beer.beer_id,
				gmt_offset : -5
			}).on "complete", (data) ->
				console.log data
				callback beer

module.exports = new Untappd