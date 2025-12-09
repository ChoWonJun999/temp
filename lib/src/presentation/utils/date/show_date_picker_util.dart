import 'package:app/src/presentation/utils/date/day_picker_dialog.dart';
import 'package:app/src/presentation/utils/date/month_picker_dialog.dart';
import 'package:app/src/presentation/utils/date/picker_type.dart';
import 'package:app/src/presentation/utils/date/week_picker_dialog.dart';
import 'package:app/src/presentation/utils/date/year_picker_dialog.dart';
import 'package:flutter/material.dart';

Future<DateTimeRange?> showDatePickerUtil(
  PickerType pickerType,
  BuildContext context, {
  required DateTime initialDate,
}) {
  switch (pickerType) {
    case PickerType.day:
      return showDayPicker(context: context, initialDate: initialDate);
    case PickerType.week:
      return showWeekPicker(context: context, initialDate: initialDate);
    case PickerType.month:
      return showMonthPicker(context: context, initialDate: initialDate);
    case PickerType.year:
      return showYearPicker(context: context, initialDate: initialDate);
  }
}
