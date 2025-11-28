import 'package:app/src/config/app_colors.dart';
import 'package:flutter/material.dart';

class TabItemText extends StatelessWidget {
  final int index;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  final double sizeFactor;
  final bool isUnderbar;
  final double underlineHeight;
  final Duration animationDuration;

  const TabItemText({
    super.key,
    required this.index,
    required this.title,
    required this.isSelected,
    required this.onTap,

    required this.sizeFactor,

    required this.isUnderbar,
    required this.underlineHeight,
    required this.animationDuration,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.0 * sizeFactor / 1.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16 * sizeFactor,
                color: isSelected ? kPrimaryColor : kDarkText,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),

            if (isUnderbar) SizedBox(height: 4 * sizeFactor / 2),

            if (isUnderbar)
              AnimatedContainer(
                duration: animationDuration,
                width: isSelected ? title.length * 13 * sizeFactor : 0,
                height: underlineHeight,
                decoration: BoxDecoration(
                  color: isSelected ? kPrimaryColor : kDarkText,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
