import 'package:flutter/material.dart';

class ActivityTabBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const ActivityTabBar({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: const Color(0xFFF3F3F3), // 연한 회색 배경
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _tabItem("일간활동", 0),
          _tabItem("주간활동", 1),
          _tabItem("월간활동", 2),
        ],
      ),
    );
  }

  Widget _tabItem(String text, int index) {
    final isSelected = index == selectedIndex;

    return GestureDetector(
      onTap: () => onChanged(index),
      behavior: HitTestBehavior.translucent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 텍스트
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: isSelected ? const Color(0xFF0077CC) : Colors.black87,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),

          const SizedBox(height: 4),

          // 밑줄
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: isSelected ? 22 : 0,
            height: 4,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF0077CC) : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}
