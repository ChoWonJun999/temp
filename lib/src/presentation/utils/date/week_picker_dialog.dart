import 'package:app/src/presentation/utils/date/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<DateTimeRange?> showWeekPicker({
  required BuildContext context,
  required DateTime initialDate,
}) async {
  final DateTimeRange? selectedRange = await showDialog<DateTimeRange>(
    context: context,
    builder: (context) => WeekPickerDialog(initialDate: initialDate),
  );

  return selectedRange;
}

class WeekPickerDialog extends StatefulWidget {
  final DateTime initialDate;

  const WeekPickerDialog({super.key, required this.initialDate});

  @override
  State<WeekPickerDialog> createState() => _WeekPickerDialogState();
}

class _WeekPickerDialogState extends State<WeekPickerDialog> {
  DateTime _selectedStart = DateTime.now();
  DateTime _selectedEnd = DateTime.now();
  DateTime _currentMonth = DateTime.now();

  @override
  void initState() {
    super.initState();
    _selectedStart = MyDateUtils.getStartOfWeek(widget.initialDate);
    _selectedEnd = MyDateUtils.getEndOfWeek(widget.initialDate);
    _currentMonth = _selectedStart;
  }

  // 날짜를 선택했을 때 주 범위를 업데이트하는 함수
  void _selectWeek(DateTime date) {
    setState(() {
      _selectedStart = MyDateUtils.getStartOfWeek(date);
      _selectedEnd = MyDateUtils.getEndOfWeek(date);
      _currentMonth = date;
    });
  }

  // 다음/이전 달로 이동
  void _changeMonth(int offset) {
    setState(() {
      _currentMonth = DateTime(
        _currentMonth.year,
        _currentMonth.month + offset,
        1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // 캘린더 생성에 필요한 정보
    final firstDayOfMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month,
      1,
    );
    // 이번 달의 마지막 날짜 (다음 달 0일)
    final lastDayOfMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month + 1,
      0,
    );
    // 달력 시작일 (이번 달 1일이 포함된 주의 월요일)
    final startCalendarDay = MyDateUtils.getStartOfWeek(firstDayOfMonth);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 2. 월 이동 및 현재 월 표시
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () => _changeMonth(-1),
                  ),
                  Text(
                    DateFormat('yyyy년 M월').format(_currentMonth),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: () => _changeMonth(1),
                  ),
                ],
              ),
            ),

            // 3. 요일 헤더 (월, 화, 수, ...)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('월', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('화', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('수', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('목', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('금', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    '토',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '일',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // 4. 달력 그리드
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildCalendarGrid(startCalendarDay, lastDayOfMonth),
            ),

            // 5. 버튼 영역 (취소/확인)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(), // 취소
                    child: const Text('취소'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    // 확인 버튼: 선택된 DateTimeRange를 반환합니다.
                    onPressed: () => Navigator.of(context).pop(
                      DateTimeRange(start: _selectedStart, end: _selectedEnd),
                    ),
                    child: const Text('확인'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 캘린더 날짜 그리드를 생성하는 함수 (로직 변경 없음)
  Widget _buildCalendarGrid(DateTime startDay, DateTime lastDayOfMonth) {
    final List<Widget> dayWidgets = [];
    DateTime currentDay = startDay;

    for (int i = 0; i < 42; i++) {
      if (currentDay.isAfter(lastDayOfMonth) && currentDay.weekday == 1) break;

      final dayToDisplay = currentDay;
      final bool isSelected =
          dayToDisplay.isAfter(
            _selectedStart.subtract(const Duration(days: 1)),
          ) &&
          dayToDisplay.isBefore(_selectedEnd.add(const Duration(days: 1)));
      final bool isCurrentMonth = dayToDisplay.month == _currentMonth.month;

      dayWidgets.add(
        GestureDetector(
          onTap: () => _selectWeek(dayToDisplay),
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(1.0),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue.shade100 : Colors.transparent,
              border: isSelected
                  ? Border.all(color: Colors.blue, width: 1.0)
                  : null,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              '${dayToDisplay.day}',
              style: TextStyle(
                color: isCurrentMonth
                    ? isSelected
                          ? Colors.blue.shade800
                          : Colors.black
                    : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      );

      currentDay = currentDay.add(const Duration(days: 1));
    }

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 7,
      childAspectRatio: 1.2,
      children: dayWidgets,
    );
  }
}
