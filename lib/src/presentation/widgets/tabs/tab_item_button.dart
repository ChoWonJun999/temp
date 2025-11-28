import 'package:flutter/material.dart';

class TabItemButton extends StatelessWidget {
  final int index;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  final double sizeFactor;

  const TabItemButton({
    super.key,
    required this.index,
    required this.title,
    required this.isSelected,
    required this.onTap,

    required this.sizeFactor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.0 * sizeFactor / 1.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: 0 * sizeFactor,
                  vertical: 0 * sizeFactor,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: Text(title),
            ),
            // TextButton(
            //   onPressed: onTap,
            //   child: Text(
            //     title,
            //     style: TextStyle(
            //       fontSize: 16 * sizeFactor,
            //       color: isSelected ? kPrimaryColor : kDarkText,
            //       fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
