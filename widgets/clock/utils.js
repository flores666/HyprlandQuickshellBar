function formatDateTime(rawText) {
	var raw = rawText.trim()
	var parts = raw.split(" ")

	if (parts.length < 5)
		return rawText // если что-то не так, вернём как есть

	var time = parts[4].slice(0, 5)
	var day = parts[1]
	var monthStr = parts[2]
	var weekdayShort = parts[0]

	var monthMap = {
		"янв": "01", "фев": "02", "мар": "03", "апр": "04",
		"май": "05", "июн": "06", "июл": "07", "авг": "08",
		"сен": "09", "окт": "10", "ноя": "11", "дек": "12"
	}

	var weekdayMap = {
		"Пн": "Понедельник", "Вт": "Вторник", "Ср": "Среда",
		"Чт": "Четверг", "Пт": "Пятница", "Сб": "Суббота", "Вс": "Воскресенье"
	}

	var month = monthMap[monthStr] || monthStr
	var weekday = weekdayMap[weekdayShort] || weekdayShort

	return time + " " + weekday + " " + day + "." + month
}
