import 'package:flutter/material.dart';

class DaySelectorRow extends StatelessWidget {
  const DaySelectorRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _DayItem(label: "19"),
        _DayItem(label: "20"),
        _DayItem(label: "21"),
        _DayItem(label: "22"),
        _DayItem(label: "23"),
        _DayItem(label: "24"),
        _DayItem(label: "25"),
      ],
    );
  }
}

class _DayItem extends StatelessWidget {
  final String label;
  const _DayItem({required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("일"),
        const SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}
