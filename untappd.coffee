rest = require('restler')

class Untappd
	api_key : "c008aa60dba7fdfe30448007c90b40fe"
	end_point : "http://api.untappd.com/v3/"
	api_search : "beer_search"
	api_fetch : "beer_info"

	find_matching_beers : (name, callback) ->
		url = "#{@end_point}#{@api_search}?key=#{@api_key}&q=#{name}".replace " ", "%20"
		rest.get(url).on "complete", (data) ->
			callback data.results

	fetch_beer : (id, callback) ->
		url = "#{@end_point}#{@api_fetch}?key=#{@api_key}&bid=#{id}"
		rest.get(url).on "complete", (data) ->
			console.log data.results
			callback data.results

module.exports = new Untappd