import 'package:flutter/material.dart';

class CircularStepSummary extends StatelessWidget {
  final int steps;
  final int goal;

  const CircularStepSummary({
    super.key,
    this.steps = 7425, // 임시 값 (확실한 값 없으므로 기본값 제공)
    this.goal = 10000,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = (steps / goal).clamp(
      0.0,
      1.0,
    ); // 0~1 사이로 제한 (안전한 계산)

    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 배경 원형
          CustomPaint(
            size: const Size(200, 200),
            painter: _CircularBackgroundPainter(),
          ),

          // 진행률 원형
          CustomPaint(
            size: const Size(200, 200),
            painter: _CircularProgressPainter(progress),
          ),

          // 중앙 텍스트
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$steps",
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "걸음수",
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 8),
              Text(
                "목표: $goal",
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//////////////////////////////
// Painter - 배경 원 (회색)
//////////////////////////////
class _CircularBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint bgPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Offset center = size.center(Offset.zero);
    final double radius = size.width / 2 - 12;

    canvas.drawCircle(center, radius, bgPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

//////////////////////////////
// Painter - 진행률 원
//////////////////////////////
class _CircularProgressPainter extends CustomPainter {
  final double progress; // 0 ~ 1

  _CircularProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint fgPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Offset center = size.center(Offset.zero);
    final double radius = size.width / 2 - 12;

    final double sweepAngle = 2 * 3.141592 * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.141592 / 2,
      sweepAngle,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
