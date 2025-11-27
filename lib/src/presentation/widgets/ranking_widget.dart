import 'package:flutter/material.dart';

class RankingWidget extends StatelessWidget {
  const RankingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        CircleAvatar(radius: 20),
        SizedBox(width: 10),
        Expanded(child: Text("오늘 내 순위(클럽내)")),
        Text("2위 / 39명"),
      ],
    );
  }
}
