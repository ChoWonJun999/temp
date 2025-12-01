import 'package:app/src/config/app_colors.dart';
import 'package:app/src/presentation/widgets/tabs/tab_config.dart';
import 'package:flutter/material.dart';

class TabItemButton extends StatelessWidget {
  final List<AppTab> tabs;
  final int selectedIndex;

  final void Function(Set<int>) onSelectionChanged;

  final double sizeFactor;

  const TabItemButton({
    super.key,
    required this.tabs,
    required this.selectedIndex,

    required this.onSelectionChanged,

    required this.sizeFactor,
  });

  @override
  Widget build(BuildContext context) {
    final double buttonFontSize = 16 * sizeFactor;

    final List<ButtonSegment<int>> segments = tabs.asMap().entries.map((entry) {
      final index = entry.key;
      final tab = entry.value;

      return ButtonSegment<int>(
        value: index,
        label: Text(tab.title, style: TextStyle(fontSize: buttonFontSize)),
      );
    }).toList();

    return SegmentedButton<int>(
      segments: segments,
      selected: {selectedIndex},
      showSelectedIcon: false,
      onSelectionChanged: onSelectionChanged,
      style: ButtonStyle(
        // 내부 패딩 0 설정
        padding: WidgetStateProperty.all(EdgeInsets.zero),

        // 네모 테두리 (모서리 0) 설정
        shape: WidgetStateProperty.all<OutlinedBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
        // 테두리 색상 및 두께 설정
        side: WidgetStateProperty.all<BorderSide>(
          BorderSide(color: kPrimaryColor, width: 1.0),
        ),

        visualDensity: const VisualDensity(horizontal: -4, vertical: 0),

        // 텍스트 색상 설정 (선택/비선택)
        foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return kLightText;
          }
          return kDarkText;
        }),

        // 배경색 설정 (선택된 버튼만 배경색 가짐)
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return kPrimaryColor;
          }
          return kTransparent;
        }),
      ),
    );
  }
}
