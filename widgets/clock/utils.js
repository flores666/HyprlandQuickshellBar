function formatDateTime(input) {
	const monthNames = {
		'янв': 0, 'фев': 1, 'мар': 2, 'апр': 3, 'май': 4, 'июн': 5,
		'июл': 6, 'авг': 7, 'сен': 8, 'окт': 9, 'ноя': 10, 'дек': 11,
		'Jan': 0, 'Feb': 1, 'Mar': 2, 'Apr': 3, 'May': 4, 'Jun': 5,
		'Jul': 6, 'Aug': 7, 'Sep': 8, 'Oct': 9, 'Nov': 10, 'Dec': 11
	};

	const dayNames = {
		'ru': ['Воскресенье', 'Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота'],
		'en': ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
	};

	const parts = input.split(' ');
	const [shortDay, dayStr, monthStr, yearStr, timeStr] = parts;

	const day = parseInt(dayStr, 10);
	const year = parseInt(yearStr, 10);
	const [hours, minutes] = timeStr.split(':').map(Number);
	const month = monthNames[monthStr];

	if (month === undefined) throw new Error('Неизвестный месяц: ' + monthStr);

	const date = new Date(Date.UTC(year, month, day, hours, minutes));

	// Определяем язык
	const isRu = /^[а-яё]+$/i.test(monthStr);
	const locale = isRu ? 'ru' : 'en';

	const dayOfWeek = date.getUTCDay(); // 0-6
	const dayName = dayNames[locale][dayOfWeek];

	const dayPadded = String(day).padStart(2, '0');
	const monthPadded = String(month + 1).padStart(2, '0');

	return `${String(hours).padStart(2, '0')}:${String(minutes).padStart(2, '0')} ${dayName} ${dayPadded}.${monthPadded}`;
}
