import 'package:flutter/material.dart';

class SelectedDate extends StatelessWidget {
  const SelectedDate({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(Icons.calendar_month),
        SizedBox(width: 6),
        Text("10월 23일"),
      ],
    );
  }
}
