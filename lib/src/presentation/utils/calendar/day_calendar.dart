import 'package:app/src/presentation/utils/date/date_utils.dart';
import 'package:flutter/material.dart';

class DayCalendar extends StatelessWidget {
  final DateTime _selectedStart = DateTime.now();
  final DateTime _selectedEnd = DateTime.now();
  final DateTime _currentMonth = DateTime.now();

  DayCalendar({super.key});

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

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
      ],
    );
  }

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
          // onTap: () => _selectWeek(dayToDisplay),
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
