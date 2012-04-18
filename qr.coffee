rest = require('restler')

class Qr
	end_point : "http://api.qrserver.com/v1/create-qr-code/"

	url : (data, size, callback) ->
		callback "#{@end_point}?data=#{data}&size=#{size}"

module.exports = new Qr