import 'package:app/src/presentation/utils/date/picker_type.dart';
import 'package:app/src/presentation/widgets/date/date_selector.dart';
import 'package:flutter/material.dart';

class WeeklyActivityPage extends StatelessWidget {
  const WeeklyActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DatePicker(pickerType: PickerType.day),
            const SizedBox(height: 20),
            DatePicker(pickerType: PickerType.week),
            const SizedBox(height: 20),
            DatePicker(pickerType: PickerType.month),
            const SizedBox(height: 20),
            DatePicker(pickerType: PickerType.year),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
