extends Label

const TIME_FORMAT = "{hour}:{minute}:{second}"

func _physics_process(_delta):
	var time = Time.get_time_dict_from_system()
	text = TIME_FORMAT.format({
		hour = "%02d" % time.hour,
		minute = "%02d" % time.minute,
		second = "%02d" % time.second
	})
