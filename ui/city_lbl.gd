extends Label


var ticks = 1


func _ready():
	Weather.connect("weather_loaded", self, "_on_weather_loaded")

	if Weather.loading:
		text = tr("RetrievingInfo")
		$Timer.start()
	else:
		text = Weather.city


func _on_timeout():
	if Weather.loading:
		text = "{0}{1}".format([tr("RetrievingInfo"), ".".repeat(ticks)])
		ticks = (ticks + 1) % 4
		$Timer.start()
	else:
		text = tr("NotRetrieved")


func _on_weather_loaded(data):
	$Timer.stop()
	text = data.city
