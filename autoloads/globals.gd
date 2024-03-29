extends Node


enum Weather {
	UNKNOWN = -1,
	CLEAR = 0,
	FEW_CLOUDS,
	CLOUDS,
	MANY_CLOUDS,
	FOG,
	DRIZZLE,
	RAIN,
	FREEZING_DRIZZLE,
	FREEZING_RAIN,
	SNOW_LIGHT,
	SNOW,
	THUNDERSTORM_LIGHT,
	THUNDERSTORM
}


const MONTH_NAMES = {
	Time.MONTH_JANUARY: "January",
	Time.MONTH_FEBRUARY: "February",
	Time.MONTH_MARCH: "March",
	Time.MONTH_APRIL: "April",
	Time.MONTH_MAY: "May",
	Time.MONTH_JUNE: "June",
	Time.MONTH_JULY: "July",
	Time.MONTH_AUGUST: "August",
	Time.MONTH_SEPTEMBER: "September",
	Time.MONTH_OCTOBER: "October",
	Time.MONTH_NOVEMBER: "November",
	Time.MONTH_DECEMBER: "December"
}

const WEEKDAY_NAMES = {
	Time.WEEKDAY_SUNDAY: "Sunday",
	Time.WEEKDAY_MONDAY: "Monday",
	Time.WEEKDAY_TUESDAY: "Tuesday",
	Time.WEEKDAY_WEDNESDAY: "Wednesday",
	Time.WEEKDAY_THURSDAY: "Thursday",
	Time.WEEKDAY_FRIDAY: "Friday",
	Time.WEEKDAY_SATURDAY: "Saturday"
}

const WEATHER_ICONS = {
	Weather.CLEAR: "weather-clear",
	Weather.FEW_CLOUDS: "weather-few-clouds",
	Weather.CLOUDS: "weather-clouds",
	Weather.MANY_CLOUDS: "weather-many-clouds",
	Weather.FOG: "weather-fog",
	Weather.DRIZZLE: "weather-showers-scattered",
	Weather.RAIN: "weather-showers",
	Weather.FREEZING_DRIZZLE: "weather-freezing-scattered-rain",
	Weather.FREEZING_RAIN: "weather-hail",
	Weather.SNOW_LIGHT: "weather-snow-scattered",
	Weather.SNOW: "weather-snow",
	Weather.THUNDERSTORM_LIGHT: "weather-showers-scattered-storm",
	Weather.THUNDERSTORM: "weather-storm"
}


func get_weather_icon(weather, day):
	var icon = WEATHER_ICONS[weather]
	
	if (not day) and (
		weather == Weather.CLEAR or
		weather == Weather.FEW_CLOUDS or
		weather == Weather.CLOUDS
	):
		icon = "%s-night" % icon

	return icon
