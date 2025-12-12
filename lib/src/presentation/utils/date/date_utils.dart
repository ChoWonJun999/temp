import 'package:app/src/presentation/utils/date/picker_type.dart';
import 'package:flutter/material.dart';

class MyDateUtils {
  static DateTime getStartOfWeek(DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);

    int weekday = normalizedDate.weekday;

    return normalizedDate.subtract(Duration(days: weekday - 1));
  }

  static DateTime getEndOfWeek(DateTime date) {
    DateTime startOfWeek = getStartOfWeek(date);
    return startOfWeek.add(const Duration(days: 6));
  }

  static DateTimeRange getPreviousRange(
    PickerType type,
    DateTimeRange currentRange,
  ) {
    final start = currentRange.start;
    switch (type) {
      case PickerType.day:
        final prevDay = start.subtract(const Duration(days: 1));
        return DateTimeRange(start: prevDay, end: prevDay);
      case PickerType.week:
        final prevWeekStart = start.subtract(const Duration(days: 7));
        return DateTimeRange(
          start: prevWeekStart,
          end: getEndOfWeek(prevWeekStart),
        );
      case PickerType.month:
        final prevMonth = DateTime(start.year, start.month - 1, 1);
        // 월 단위 이동 시 end 날짜는 start와 동일하게 유지
        return DateTimeRange(start: prevMonth, end: prevMonth);
      case PickerType.year:
        final prevYear = DateTime(start.year - 1, 1, 1);
        return DateTimeRange(start: prevYear, end: prevYear);
    }
  }

  static DateTimeRange getNextRange(
    PickerType type,
    DateTimeRange currentRange,
  ) {
    final start = currentRange.start;
    switch (type) {
      case PickerType.day:
        final nextDay = start.add(const Duration(days: 1));
        return DateTimeRange(start: nextDay, end: nextDay);
      case PickerType.week:
        final nextWeekStart = start.add(const Duration(days: 7));
        return DateTimeRange(
          start: nextWeekStart,
          end: getEndOfWeek(nextWeekStart),
        );
      case PickerType.month:
        final nextMonth = DateTime(start.year, start.month + 1, 1);
        return DateTimeRange(start: nextMonth, end: nextMonth);
      case PickerType.year:
        final nextYear = DateTime(start.year + 1, 1, 1);
        return DateTimeRange(start: nextYear, end: nextYear);
    }
  }
}
