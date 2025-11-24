import 'package:app/src/presentation/pages/daily/widgets/circulat_step_summary.dart';
import 'package:app/src/presentation/pages/daily/widgets/day_selector_row.dart';
import 'package:app/src/presentation/pages/daily/widgets/ranking_widget.dart';
import 'package:app/src/presentation/pages/daily/widgets/summary_stat_row.dart';
import 'package:app/src/presentation/widgets/common_card.dart';
import 'package:app/src/providers/step_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              CommonCard(child: DaySelectorRow()),
              SizedBox(height: 16),
              _CircularStepCard(),
              SizedBox(height: 16),
              CommonCard(child: SummaryStatRow()),
              SizedBox(height: 16),
              CommonCard(child: RankingWidget()),
            ],
          ),
        ),
      ),
    );
  }
}

/// 🔥 CircularStepSummary 연결 카드 위젯
class _CircularStepCard extends StatefulWidget {
  const _CircularStepCard();

  @override
  State<_CircularStepCard> createState() => _CircularStepCardState();
}

class _CircularStepCardState extends State<_CircularStepCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Consumer<StepProvider>(
        builder: (context, stepProv, _) {
          final steps = stepProv.todaySteps;
          return CommonCard(
            child: SizedBox(
              height: 200,
              child: Center(
                child: steps == 0
                    ? const Text(
                        '걸음 데이터가 없습니다.\n기기에서 센서가 활성화되어 있는지 확인하세요.',
                        textAlign: TextAlign.center,
                      )
                    : CircularStepSummary(steps: steps, goal: 10000),
              ),
            ),
          );
        },
      ),
    );
  }
}
