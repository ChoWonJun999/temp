import 'package:flutter/material.dart';

class HourlyBarChart extends StatelessWidget {
  const HourlyBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      alignment: Alignment.center,
      child: const Text("시간대별 Bar Chart 자리"),
    );
  }
}
