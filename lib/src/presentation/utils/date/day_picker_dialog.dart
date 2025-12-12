import 'package:app/src/presentation/utils/date/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<DateTimeRange?> showDayPicker({
  required BuildContext context,
  required DateTime initialDate,
}) async {
  // 💡 showDialog가 DayPickerDialog가 반환하는 타입인 DateTime을 받도록 수정
  final DateTime? selectedDate = await showDialog<DateTime>(
    context: context,
    builder: (context) => DayPickerDialog(initialDate: initialDate),
  );

  // 💡 반환된 단일 DateTime을 DateTimeRange로 변환하여 상위 함수에 전달
  if (selectedDate != null) {
    // 시작일과 종료일이 같은 범위로 통일
    return DateTimeRange(start: selectedDate, end: selectedDate);
  }

  return null;
}

class DayPickerDialog extends StatefulWidget {
  final DateTime initialDate;
  const DayPickerDialog({super.key, required this.initialDate});

  @override
  State<DayPickerDialog> createState() => _DayPickerDialogState();
}

class _DayPickerDialogState extends State<DayPickerDialog> {
  // 단일 선택 날짜
  late DateTime _selectedDate;
  // 현재 달력에 표시되는 월
  late DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    // 초기 날짜를 선택된 날짜와 현재 월로 설정
    _selectedDate = widget.initialDate;
    _currentMonth = DateTime(_selectedDate.year, _selectedDate.month, 1);
  }

  // 날짜를 선택했을 때 단일 날짜를 업데이트하는 함수
  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
      // 선택된 날짜가 포함된 월로 이동
      _currentMonth = DateTime(date.year, date.month, 1);
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
    final firstDayOfMonth = _currentMonth;
    final lastDayOfMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month + 1,
      0,
    );

    final startCalendarDay = MyDateUtils.getStartOfWeek(firstDayOfMonth);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 2. 월 이동 및 현재 월 표시 (WeekPickerDialog와 동일)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              // ... (이전/다음 버튼 및 월 표시 로직)
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

            // 3. 요일 헤더 (WeekPickerDialog와 동일)
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
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('취소'),
                  ),
                  const SizedBox(width: 8),
                  // 확인 버튼: 선택된 단일 DateTime을 반환합니다.
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(_selectedDate),
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

  // 캘린더 날짜 그리드를 생성하는 함수
  Widget _buildCalendarGrid(DateTime startDay, DateTime lastDayOfMonth) {
    final List<Widget> dayWidgets = [];
    DateTime currentDay = startDay;

    for (int i = 0; i < 42; i++) {
      if (currentDay.isAfter(lastDayOfMonth) && currentDay.weekday == 1) break;

      final dayToDisplay = currentDay;

      // 💡 단일 날짜 선택 로직: 년, 월, 일이 모두 같을 때만 선택됨
      final bool isSelected =
          dayToDisplay.year == _selectedDate.year &&
          dayToDisplay.month == _selectedDate.month &&
          dayToDisplay.day == _selectedDate.day;

      final bool isCurrentMonth = dayToDisplay.month == _currentMonth.month;

      dayWidgets.add(
        GestureDetector(
          onTap: () => _selectDate(dayToDisplay),
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(1.0),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue.shade100 : Colors.transparent,
              // 선택된 날짜는 파란색 테두리로 강조
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
