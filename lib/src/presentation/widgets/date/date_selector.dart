import 'package:app/src/presentation/utils/date/date_utils.dart';
import 'package:app/src/presentation/utils/date/picker_type.dart';
import 'package:app/src/presentation/utils/date/show_date_picker_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final PickerType pickerType;
  final Color? color;
  final bool useWeekNumberFormat;
  final bool isGoToButton;
  final double? sizeFactor;
  final ValueChanged<DateTime>? onDateChanged;

  const DatePicker({
    super.key,
    required this.pickerType,
    this.color = Colors.black,
    this.useWeekNumberFormat = false,
    this.isGoToButton = true,
    this.sizeFactor,
    this.onDateChanged,
  });

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late DateTimeRange _selectedRange;

  static const double _defaultSizeFactor = 1.0;
  double get _currentSizeFactor => widget.sizeFactor ?? _defaultSizeFactor;
  double get _iconSize => 20.0 * _currentSizeFactor;
  double get _arrowIconSize => 15.0 * _currentSizeFactor;
  double get _fontSize => 15.0 * _currentSizeFactor;
  double get _paddingHorizontal => 0 * _currentSizeFactor;
  double get _paddingVertical => 0 * _currentSizeFactor;
  double get _spacing => 0.1 * _currentSizeFactor;

  @override
  void initState() {
    super.initState();
    _selectedRange = _getInitialRange(widget.pickerType, DateTime.now());
  }

  DateTimeRange _getInitialRange(PickerType type, DateTime now) {
    final today = DateTime(now.year, now.month, now.day);

    switch (type) {
      case PickerType.day:
        return DateTimeRange(start: today, end: today);
      case PickerType.week:
        final start = MyDateUtils.getStartOfWeek(today);
        final end = MyDateUtils.getEndOfWeek(today);
        return DateTimeRange(start: start, end: end);
      case PickerType.month:
        final firstDayOfMonth = DateTime(today.year, today.month, 1);
        return DateTimeRange(start: firstDayOfMonth, end: firstDayOfMonth);
      case PickerType.year:
        final firstDayOfYear = DateTime(today.year, 1, 1);
        return DateTimeRange(start: firstDayOfYear, end: firstDayOfYear);
    }
  }

  Future<void> _pickDate() async {
    final DateTimeRange? picked = await showDatePickerUtil(
      widget.pickerType,
      context,
      initialDate: _selectedRange.start,
    );

    if (picked != null) {
      setState(() {
        _selectedRange = picked;
      });
    }
  }

  int _calculateWeekNumber(DateTime startOfWeek) {
    // 주의 시작일(월요일)이 속한 월
    final month = startOfWeek.month;
    // 해당 월의 1일
    final firstDayOfMonth = DateTime(startOfWeek.year, month, 1);

    // 월의 1일이 속한 주(월요일)
    final startOfFirstWeek = MyDateUtils.getStartOfWeek(firstDayOfMonth);

    // 주의 시작일과 월의 첫 주 시작일 사이의 일수 차이
    final daysDifference = startOfWeek.difference(startOfFirstWeek).inDays;

    // 주차 계산: (일수 차이 / 7) + 1
    // (예: 0일 차이 -> 1주차, 7일 차이 -> 2주차)
    return (daysDifference ~/ 7) + 1;
  }

  String _getDisplayText() {
    final start = _selectedRange.start;
    final end = _selectedRange.end;

    if (start.isAtSameMomentAs(end)) {
      switch (widget.pickerType) {
        case PickerType.day:
          return DateFormat('M월 d일').format(start);
        case PickerType.month:
          return DateFormat('yyyy년 M월').format(start);
        case PickerType.year:
          return DateFormat('yyyy년').format(start);
        case PickerType.week:
          break;
      }
    }

    if (widget.pickerType == PickerType.week) {
      if (widget.useWeekNumberFormat) {
        // 💡 형식 1: MM월 n주차
        final weekNumber = _calculateWeekNumber(start);
        return DateFormat('MM월').format(start) + ' $weekNumber주차';
      } else {
        // 💡 형식 2: MM.dd ~ MM.dd (기존 날짜 범위)
        return '${DateFormat('M월 d일').format(start)} ~ ${DateFormat('M월 d일').format(end)}';
      }
    }

    // 이외의 경우 (주차 로직에서 처리되지 않은 Week case 또는 오류 방지)
    return '';
  }

  void _goToPrevious() {
    setState(() {
      _selectedRange = MyDateUtils.getPreviousRange(
        widget.pickerType,
        _selectedRange,
      );
      widget.onDateChanged?.call(
        _selectedRange.start,
      ); // onDateChanged 호출은 시작 날짜를 전달
    });
  }

  void _goToNext() {
    setState(() {
      _selectedRange = MyDateUtils.getNextRange(
        widget.pickerType,
        _selectedRange,
      );
      widget.onDateChanged?.call(
        _selectedRange.start,
      ); // onDateChanged 호출은 시작 날짜를 전달
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickDate,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: widget.isGoToButton ? 0 : 12.0,
        ),
        child: Row(
          mainAxisAlignment: widget.isGoToButton
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.start,
          mainAxisSize: widget.isGoToButton
              ? MainAxisSize.max
              : MainAxisSize.min,
          children: [
            if (widget.isGoToButton)
              IconButton(
                icon: Icon(Icons.arrow_back_ios_sharp, size: _arrowIconSize),
                onPressed: _goToPrevious,
              ),
            Row(
              children: [
                Icon(Icons.calendar_month, color: widget.color, size: 24),
                const SizedBox(width: 8),
                Text(
                  _getDisplayText(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: widget.color,
                  ),
                ),
              ],
            ),
            if (widget.isGoToButton)
              IconButton(
                icon: Icon(Icons.arrow_forward_ios_sharp, size: _arrowIconSize),
                onPressed: _goToNext,
              ),
          ],
        ),
      ),
    );
  }
}
