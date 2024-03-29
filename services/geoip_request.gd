extends Node
class_name GeoIPRequest


signal request_completed(geo_data)
signal request_failed


const API_URL = "http://ip-api.com/json?fields=49360"


func request():
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", self, "_on_request_completed")

	if http_request.request(API_URL) != OK:
		push_error("Cannot get IP address")
		emit_signal("request_failed")


func _on_request_completed(result, response_code, _headers, body):
	if result != HTTPRequest.RESULT_SUCCESS || response_code != 200:
		push_error("Cannot get IP address")
		emit_signal("request_failed")
		return

	var json_result = JSON.parse(body.get_string_from_utf8())
	if json_result.error != OK:
		push_error("Cannot parse json: %s" % json_result.error_string)
		emit_signal("request_failed")
		return

	var data = json_result.result
	if data.status != "success":
		push_error("Cannot get IP address: %s" % data.message)
		emit_signal("request_failed")
		return
	
	print(data.city, ", ", data.lat, ", ", data.lon)
	emit_signal("request_completed", {
		city = data.city,
		latitude = data.lat,
		longitude = data.lon
	})
