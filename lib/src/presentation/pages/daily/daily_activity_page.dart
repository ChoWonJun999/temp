import 'package:app/src/presentation/widgets/circular_step_card.dart';
import 'package:app/src/presentation/widgets/common_card.dart';
import 'package:app/src/presentation/widgets/date_navigator_bar.dart';
import 'package:app/src/presentation/widgets/ranking_widget.dart';
import 'package:flutter/material.dart';

class DailyActivityPage extends StatelessWidget {
  const DailyActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CommonCard(
                children: [
                  DateNavigatorBar(
                    // 날짜가 변경될 때마다 실행되는 콜백 함수
                    onDateChanged: (newDate) {
                      print(
                        "선택된 새로운 날짜: ${newDate.year}-${newDate.month}-${newDate.day}",
                      );
                      // 이곳에 새로운 날짜에 맞는 데이터를 불러오는 로직을 작성합니다.
                    },
                  ),
                  SizedBox(height: 16),
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
        const SizedBox(height: 4),
        Text(value, textScaleFactor: 2),
        Text(unit),
      ],
    );
  }
}
