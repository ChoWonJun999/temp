import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeekPickerExample extends StatefulWidget {
  const WeekPickerExample({super.key});

  @override
  State<WeekPickerExample> createState() => _WeekPickerExampleState();
}

class _WeekPickerExampleState extends State<WeekPickerExample> {
  DateTime? selectedDay;
  List<DateTime>? selectedWeek;

  /// 선택한 날짜가 속한 주의 월요일
  DateTime _getMonday(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  /// 선택한 날짜 기준 월~일까지 7일 생성
  List<DateTime> _getWeekRange(DateTime date) {
    final monday = _getMonday(date);
    return List.generate(7, (i) => monday.add(Duration(days: i)));
  }

  Future<void> pickWeek() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDay ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        selectedDay = picked;
        selectedWeek = _getWeekRange(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('MM.dd');

    return Scaffold(
      appBar: AppBar(title: const Text("Week Picker Sample")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: pickWeek, child: const Text("주 선택")),

            const SizedBox(height: 20),

            if (selectedWeek != null)
              Text(
                "${fmt.format(selectedWeek!.first)} ~ ${fmt.format(selectedWeek!.last)}",
                style: const TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }
}
