extends Label

const DATE_FORMAT = "{weekday}{weekday_sep}{0}{0_sep}{1}{1_sep}{year}"

func _physics_process(_delta):
	var date = Time.get_date_dict_from_system()
	var values = {
		weekday = tr(Globals.WEEKDAY_NAMES[date.weekday]).capitalize(),
		weekday_sep = tr("WeekdaySeparator"),
		year = date.year
	}
	
	var month = tr(Globals.MONTH_NAMES[date.month])
	
	if tr("FirstMonth") == "true":
		values["0"] = month
		values["0_sep"] = tr("MonthSeparator")
		values["1"] = date.day
		values["1_sep"] = tr("DaySeparator")
	else:
		values["0"] = date.day
		values["0_sep"] = tr("DaySeparator")
		values["1"] = month
		values["1_sep"] = tr("MonthSeparator")

	text = DATE_FORMAT.format(values)
