import 'package:flutter/material.dart';

class SummaryStatRow extends StatelessWidget {
  const SummaryStatRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: _SummaryCard(title: "활동거리", value: "36.3km")),
        SizedBox(width: 8),
        Expanded(child: _SummaryCard(title: "활동시간", value: "1h 27m")),
        SizedBox(width: 8),
        Expanded(child: _SummaryCard(title: "소모열량", value: "1677kcal")),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;

  const _SummaryCard({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        const SizedBox(height: 4),
        Text(value),
      ],
    );
  }
}
