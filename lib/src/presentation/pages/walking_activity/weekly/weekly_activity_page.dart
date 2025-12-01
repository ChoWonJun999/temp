import 'package:app/src/presentation/widgets/date/week_selector.dart';
import 'package:flutter/material.dart';

class WeeklyActivityPage extends StatelessWidget {
  const WeeklyActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: WeekPickerExample()));
    ;
  }
}
