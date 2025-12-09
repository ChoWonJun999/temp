DateTime getStartOfWeek(DateTime date) {
  final normalizedDate = DateTime(date.year, date.month, date.day);

  int weekday = normalizedDate.weekday;

  return normalizedDate.subtract(Duration(days: weekday - 1));
}

DateTime getEndOfWeek(DateTime date) {
  DateTime startOfWeek = getStartOfWeek(date);
  return startOfWeek.add(const Duration(days: 6));
}
