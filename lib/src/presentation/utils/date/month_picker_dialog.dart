import 'package:flutter/material.dart';

Future<DateTimeRange?> showMonthPicker({
  required BuildContext context,
  required DateTime initialDate,
}) async {
  final DateTime? selectedDate = await showDialog<DateTime>(
    context: context,
    builder: (context) => MonthPickerDialog(initialDate: initialDate),
  );

  if (selectedDate != null) {
    return DateTimeRange(start: selectedDate, end: selectedDate);
  }

  return null;
}

class MonthPickerDialog extends StatefulWidget {
  final DateTime initialDate;
  const MonthPickerDialog({super.key, required this.initialDate});

  @override
  State<MonthPickerDialog> createState() => _MonthPickerDialogState();
}

class _MonthPickerDialogState extends State<MonthPickerDialog> {
  late int _selectedMonth; // 1~12
  late int _currentYear;

  @override
  void initState() {
    super.initState();
    _selectedMonth = widget.initialDate.month;
    _currentYear = widget.initialDate.year;
  }

  void _changeYear(int offset) {
    setState(() {
      _currentYear += offset;
      // 연도가 변경되면, 기존 선택된 월을 새 연도로 옮겨줍니다.
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 1. 헤더 (선택된 연도 및 월 표시)
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '$_currentYear년 $_selectedMonth월',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // 2. 연도 이동 버튼
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () => _changeYear(-1),
                  ),
                  Text(
                    '$_currentYear년',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: () => _changeYear(1),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // 3. 월 선택 그리드
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3, // 한 줄에 3개씩
                childAspectRatio: 2.5,
                children: List.generate(12, (index) {
                  final month = index + 1;
                  final isSelected = month == _selectedMonth;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedMonth = month;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.blue.shade100
                            : Colors.transparent,
                        border: isSelected
                            ? Border.all(color: Colors.blue, width: 1.0)
                            : null,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        '$month월',
                        style: TextStyle(
                          color: isSelected
                              ? Colors.blue.shade800
                              : Colors.black,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            // 4. 버튼 영역 (취소/확인)
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
                  // 확인 버튼: 선택된 월의 1일 DateTime을 반환합니다.
                  ElevatedButton(
                    onPressed: () => Navigator.of(
                      context,
                    ).pop(DateTime(_currentYear, _selectedMonth, 1)),
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
}
