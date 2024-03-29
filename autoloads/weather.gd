extends Node


signal weather_loaded(data)


var loading = true
var city = ""
var latitude = 0
var longitude = 0
var updated = 0


func _ready():
	var geoip_request = GeoIPRequest.new()
	add_child(geoip_request)
	geoip_request.connect("request_completed", self, "_on_geoip_completed")
	geoip_request.connect("request_failed", self, "_on_geoip_failed")
	geoip_request.request()


func update_weather():
	loading = true
	
	var forecast_request = ForecastRequest.new()
	add_child(forecast_request)
	forecast_request.connect("request_completed", self, "_on_forecast_completed")
	forecast_request.connect("request_failed", self, "_on_forecast_failed")
	forecast_request.request(latitude, longitude)
	
	loading = false


func _on_geoip_completed(data):
	city = data.city
	latitude = data.latitude
	longitude = data.longitude
	
	update_weather()


func _on_geoip_failed():
	loading = false


func _on_forecast_completed(data):
	updated = data.updated
	
	emit_signal("weather_loaded", {
		city = city,
		updated = data.updated,
		temperature = data.temperature,
		temperature_unit = data.temperature_unit,
		relative_temperature = data.relative_temperature,
		relative_temperature_unit = data.relative_temperature_unit,
		humidity = data.humidity,
		humidity_unit = data.humidity_unit,
		is_day = data.is_day,
		status = data.weather
	})
	
	loading = false


func _on_forecast_failed():
	loading = false
