import 'package:flutter/material.dart';

Future<DateTimeRange?> showYearPicker({
  required BuildContext context,
  required DateTime initialDate,
}) async {
  final DateTime? selectedDate = await showDialog<DateTime>(
    context: context,
    builder: (context) => YearPickerDialog(initialDate: initialDate),
  );

  if (selectedDate != null) {
    return DateTimeRange(start: selectedDate, end: selectedDate);
  }

  return null;
}

class YearPickerDialog extends StatefulWidget {
  final DateTime initialDate;
  const YearPickerDialog({super.key, required this.initialDate});

  @override
  State<YearPickerDialog> createState() => _YearPickerDialogState();
}

class _YearPickerDialogState extends State<YearPickerDialog> {
  late int _selectedYear;
  final ScrollController _scrollController = ScrollController();
  // 표시할 연도 범위 설정
  static const int _startYear = 1950;
  static const int _endYear = 2100;
  static const double _itemHeight = 50.0;

  @override
  void initState() {
    super.initState();
    _selectedYear = widget.initialDate.year;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final index = _selectedYear - _startYear;
      _scrollController.jumpTo(
        (index * _itemHeight) -
            (MediaQuery.of(context).size.height * 0.3 / 2) +
            (_itemHeight / 2),
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
            // 1. 헤더 (선택된 연도 표시)
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '$_selectedYear년',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            const Divider(height: 1),

            // 2. 년도 리스트 (스크롤)
            SizedBox(
              height: 300, // 스크롤 가능한 영역 높이 지정
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _endYear - _startYear + 1,
                itemExtent: _itemHeight, // 아이템 높이 고정
                itemBuilder: (context, index) {
                  final year = _startYear + index;
                  final isSelected = year == _selectedYear;

                  return Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedYear = year;
                          // 선택된 연도로 스크롤 이동
                          _scrollController.animateTo(
                            (index * _itemHeight) -
                                (300 / 2) +
                                (_itemHeight / 2),
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        });
                      },
                      child: Text(
                        '$year년',
                        style: TextStyle(
                          fontSize: isSelected ? 22 : 18,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isSelected
                              ? Colors.blue.shade800
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // 3. 버튼 영역 (취소/확인)
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
                  // 확인 버튼: 선택된 연도의 1월 1일 DateTime을 반환합니다.
                  ElevatedButton(
                    onPressed: () => Navigator.of(
                      context,
                    ).pop(DateTime(_selectedYear, 1, 1)),
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
