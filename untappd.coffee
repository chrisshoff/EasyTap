rest = require('restler')

untappd_api = {
	api_key : "c008aa60dba7fdfe30448007c90b40fe",

	generate_checkin_url : (id, callback) ->
		callback "/beer/#{id}"
}

module.exports.generate_checkin_url = untappd_api.generate_checkin_url