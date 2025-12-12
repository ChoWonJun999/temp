import 'package:app/src/presentation/utils/date/picker_type.dart';
import 'package:app/src/presentation/widgets/circular_step_card.dart';
import 'package:app/src/presentation/widgets/common_card.dart';
import 'package:app/src/presentation/widgets/date/date_selector.dart';
import 'package:app/src/presentation/widgets/ranking_widget.dart';
import 'package:flutter/material.dart';

class MonthlyActivityPage extends StatelessWidget {
  const MonthlyActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CommonCard(
                children: [
                  DatePicker(pickerType: PickerType.month),
                  CircularStepCard(),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CommonCard(
                      children: [
                        _SummaryCard(title: "활동걸음", value: "6,412", unit: "걸음"),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CommonCard(
                      children: [
                        _SummaryCard(title: "활동거리", value: "36.3", unit: "Km"),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CommonCard(
                      children: [
                        _SummaryCard(
                          title: "소모열량",
                          value: "1,677",
                          unit: "칼로리",
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16),
              CommonCard(children: [RankingWidget()]),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        const SizedBox(height: 0),
        Text(value),
        Text(unit),
      ],
    );
  }
}
