extends Node
class_name ForecastRequest


signal request_completed(forecast_data)
signal request_failed


const API_URL = "https://api.open-meteo.com/v1/forecast"
const QUERY_PARAMS = "current=temperature_2m,relative_humidity_2m,apparent_temperature,is_day,weather_code&timeformat=unixtime"


func request(latitude, longitude):
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", self, "_on_request_completed")

	var url = "{0}?latitude={1}&longitude={2}&{3}".format([ API_URL, "%.4f" % latitude, "%.4f" % longitude, QUERY_PARAMS ])
	if http_request.request(url) != OK:
		push_error("Cannot get forecast")
		emit_signal("request_failed")


func _on_request_completed(result, response_code, _headers, body):
	if result != HTTPRequest.RESULT_SUCCESS || response_code != 200:
		push_error("Cannot get forecast")
		emit_signal("request_failed")
		return

	var json_result = JSON.parse(body.get_string_from_utf8())
	if json_result.error != OK:
		push_error("Cannot parse json: %s" % json_result.error_string)
		emit_signal("request_failed")
		return

	if "error" in json_result.result:
		push_error("Cannot get forecast: %s" % json_result.result.reason)
		emit_signal("request_failed")
		return
	
	var data = _create_response(json_result.result)
	print(data)
	emit_signal("request_completed", data)


func _create_response(result):
	return {
		updated = result.current.time,
		temperature = result.current.temperature_2m,
		temperature_unit = result.current_units.temperature_2m,
		relative_temperature = result.current.apparent_temperature,
		relative_temperature_unit = result.current_units.apparent_temperature,
		humidity = result.current.relative_humidity_2m,
		humidity_unit = result.current_units.relative_humidity_2m,
		is_day = int(result.current.is_day) == 1,
		weather = _get_weather_type(int(result.current.weather_code))
	}


# From https://open-meteo.com/en/docs
func _get_weather_type(weather_code):
	match weather_code:
		0:
			return Globals.Weather.CLEAR
		1:
			return Globals.Weather.FEW_CLOUDS
		2: 
			return Globals.Weather.CLOUDS
		3:
			return Globals.Weather.MANY_CLOUDS
		45, 48: 
			return Globals.Weather.FOG
		51, 53, 55, 61, 80: 
			return Globals.Weather.DRIZZLE
		56, 57:
			return Globals.Weather.FREEZING_DRIZZLE
		63, 65, 81, 82: 
			return Globals.Weather.RAIN
		66, 67: 
			return Globals.Weather.FREEZING_RAIN
		71, 77, 85: 
			return Globals.Weather.SNOW_LIGHT
		73, 75, 86:
			return Globals.Weather.SNOW
		95: 
			return Globals.Weather.THUNDERSTORM_LIGHT
		96, 99:
			return Globals.Weather.THUNDERSTORM
		_:
			return Globals.Weather.UNKNOWN
