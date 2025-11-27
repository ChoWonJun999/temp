import 'package:flutter/material.dart';

class DateNavigatorBar extends StatefulWidget {
  final ValueChanged<DateTime>? onDateChanged;

  const DateNavigatorBar({super.key, this.onDateChanged});

  @override
  State<DateNavigatorBar> createState() => _DateNavigatorBarState();
}

class _DateNavigatorBarState extends State<DateNavigatorBar> {
  DateTime _selectedDate = DateTime.now();

  String get _formattedDate {
    return "${_selectedDate.month}월 ${_selectedDate.day}일";
  }

  void _goToPrevious() {
    setState(() {
      _selectedDate = _selectedDate.subtract(const Duration(days: 1));
      widget.onDateChanged?.call(_selectedDate);
    });
  }

  void _goToNext() {
    setState(() {
      _selectedDate = _selectedDate.add(const Duration(days: 1));
      widget.onDateChanged?.call(_selectedDate);
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(_selectedDate.year - 10),
      lastDate: DateTime(_selectedDate.year + 10),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDatePickerMode: DatePickerMode.year,

      // helpText: "",
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blueGrey, // 헤더와 선택된 날짜 배경색
              onPrimary: Colors.white, // 헤더 텍스트 색상
              onSurface: Colors.black, // 달력 내부 텍스트 색상
            ),
            // 버튼 텍스트 색상 (취소/확인)
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.teal, // 버튼 텍스트 색상
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.onDateChanged?.call(_selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final centerContent = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.calendar_month, size: 24),
        const SizedBox(width: 8),
        Text(
          _formattedDate,
          textScaleFactor: 1.5,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_sharp, size: 20),
            onPressed: _goToPrevious,
          ),

          InkWell(
            onTap: () => _selectDate(context),
            borderRadius: BorderRadius.circular(4.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4.0,
                vertical: 4.0,
              ),
              child: centerContent,
            ),
          ),

          IconButton(
            icon: const Icon(Icons.arrow_forward_ios_sharp, size: 20),
            onPressed: _goToNext,
          ),
        ],
      ),
    );
  }
}
