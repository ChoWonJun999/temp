import 'package:app/src/presentation/utils/date/picker_type.dart';
import 'package:app/src/presentation/widgets/date/date_selector.dart';
import 'package:flutter/material.dart';

class DateNavigatorBar extends StatefulWidget {
  final ValueChanged<DateTime>? onDateChanged;
  final bool isGoToButton;
  final DateTime? initialDate;
  final double? sizeFactor;
  final PickerType pickerType;

  const DateNavigatorBar({
    super.key,
    this.onDateChanged,
    this.isGoToButton = true,
    this.initialDate,
    this.sizeFactor,
    required this.pickerType,
  });

  @override
  State<DateNavigatorBar> createState() => _DateNavigatorBarState();
}

class _DateNavigatorBarState extends State<DateNavigatorBar> {
  late DateTime _selectedDate;

  // 기본 크기 계수 설정
  static const double _defaultSizeFactor = 1.0;

  // 현재 적용할 크기 계수를 가져옵니다. (기본값은 1.0)
  double get _currentSizeFactor => widget.sizeFactor ?? _defaultSizeFactor;

  // 크기 계수를 사용하여 동적으로 값을 계산하는 Getter들
  double get _iconSize => 20.0 * _currentSizeFactor;
  double get _arrowIconSize => 15.0 * _currentSizeFactor;
  double get _fontSize => 15.0 * _currentSizeFactor;
  double get _paddingHorizontal => 0 * _currentSizeFactor;
  double get _paddingVertical => 0 * _currentSizeFactor;
  double get _spacing => 0.1 * _currentSizeFactor;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
  }

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
      locale: Locale('ko', ''),
      helpText: "",

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
        Icon(Icons.calendar_month, size: _iconSize),
        SizedBox(width: _spacing),
        Text(
          _formattedDate,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: _fontSize),
        ),
      ],
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: _paddingHorizontal,
        vertical: _paddingVertical,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (widget.isGoToButton)
            IconButton(
              icon: Icon(Icons.arrow_back_ios_sharp, size: _arrowIconSize),
              onPressed: _goToPrevious,
            ),

          // 버튼 기능 연동 필요
          DatePicker(pickerType: widget.pickerType),

          // InkWell(
          //   onTap: () => _selectDate(context),
          //   borderRadius: BorderRadius.circular(4.0 * _currentSizeFactor),
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(
          //       horizontal: _paddingHorizontal,
          //       vertical: _paddingVertical,
          //     ),
          //     child: centerContent,
          //   ),
          // ),
          if (widget.isGoToButton)
            IconButton(
              icon: Icon(Icons.arrow_forward_ios_sharp, size: _arrowIconSize),
              onPressed: _goToNext,
            ),
        ],
      ),
    );
  }
}
