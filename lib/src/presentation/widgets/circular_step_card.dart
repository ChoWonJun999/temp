import 'package:app/src/presentation/widgets/circulat_step_summary.dart';
import 'package:app/src/providers/step_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CircularStepCard extends StatelessWidget {
  const CircularStepCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StepProvider>(
      builder: (context, stepProv, _) {
        final steps = stepProv.todaySteps;
        return SizedBox(
          height: 200,
          child: Center(
            child: CircularStepSummary(steps: steps, goal: 10000),
            // child: steps == 0
            //     ? const Text(
            //         '걸음 데이터가 없습니다.\n기기에서 센서가 활성화되어 있는지 확인하세요.',
            //         textAlign: TextAlign.center,
            //       )
            //     : CircularStepSummary(steps: steps, goal: 10000),
          ),
        );
      },
    );
  }
}
