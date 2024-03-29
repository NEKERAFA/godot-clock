extends HBoxContainer


const ICON_PATH = "res://icons/breeze/%s.svg"
const TEMP_FORMAT = "%.1f %s /"
const FEEL_FORMAT = "%d %s"


onready var icon = $IconWeather
onready var temp_lbl = $HBoxContainer/Temperature
onready var feel_lbl = $HBoxContainer/Feel


func _ready():
	Weather.connect("weather_loaded", self, "_on_weather_loaded")
	
	if not Weather.loading:
		Weather.update_weather()


func _on_weather_loaded(data):
	var icon_tex = load(ICON_PATH % Globals.get_weather_icon(data.status, data.is_day))
	icon.texture = icon_tex
	icon.show()
	
	temp_lbl.text = TEMP_FORMAT % [data.temperature, data.temperature_unit]
	temp_lbl.show()
	
	feel_lbl.text = FEEL_FORMAT % [data.relative_temperature, data.relative_temperature_unit]
	feel_lbl.show()
	
	$Timer.start()


func _on_timeout():
	Weather.update_weather()
