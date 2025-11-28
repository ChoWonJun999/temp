import 'package:app/src/config/app_colors.dart';
import 'package:app/src/presentation/widgets/tabs/tab_config.dart';
import 'package:app/src/presentation/widgets/tabs/tab_item_text.dart';
import 'package:flutter/material.dart';

enum TabItemType { text, button }

enum Calendar { day, week, month, year }

class CommonTabs extends StatelessWidget {
  final List<AppTab> tabs;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  final TabItemType tabItemType;
  final bool isUnderbar;
  final double height;
  final double underlineHeight;
  final Duration animationDuration;
  final double sizeFactor;

  const CommonTabs({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onChanged,

    this.tabItemType = TabItemType.text,

    this.sizeFactor = 1,

    this.isUnderbar = true,
    this.height = 50,
    this.underlineHeight = 4,
    this.animationDuration = const Duration(milliseconds: 180),
  });

  @override
  Widget build(BuildContext context) {
    Widget tabItems;

    switch (tabItemType) {
      case TabItemType.text:
        tabItems = Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...tabs.asMap().entries.map((entry) {
              final index = entry.key;
              final tab = entry.value;

              return TabItemText(
                index: index,
                title: tab.title,
                isSelected: index == selectedIndex,
                onTap: () => onChanged(index),

                sizeFactor: sizeFactor,
                isUnderbar: isUnderbar,
                underlineHeight: underlineHeight,
                animationDuration: animationDuration,
              );
            }),
          ],
        );
        break;
      case TabItemType.button:
        final Set<int> selectedIndices = {selectedIndex};
        final double buttonFontSize = 16 * sizeFactor;

        // 1. Segments (버튼 목록) 생성
        final List<ButtonSegment<int>> segments = tabs.asMap().entries.map((
          entry,
        ) {
          final index = entry.key;
          final tab = entry.value;

          return ButtonSegment<int>(
            value: index,
            // [수정] 충돌 방지를 위해 TabItemText 대신 단순 Text 위젯 사용
            label: Text(
              tab.title,
              // SegmentedButton Style이 최종적으로 적용되지만,
              // 폰트 크기와 굵기는 여기서 설정하여 SegmentedButton의 ForegroundColor와 결합되도록 합니다.
              style: TextStyle(
                fontSize: buttonFontSize,
                fontWeight: index == selectedIndex
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          );
        }).toList();

        tabItems = SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: SegmentedButton<int>(
            segments: segments,
            selected: selectedIndices,
            showSelectedIcon: false,
            onSelectionChanged: (Set<int> newSelection) {
              if (newSelection.isNotEmpty) {
                onChanged(newSelection.first);
              }
            },
            style: ButtonStyle(
              // 내부 패딩 0 설정
              padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.zero,
              ),
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
              // 버튼 크기 최소화에 도움
              visualDensity: VisualDensity.compact,

              // 텍스트 색상 설정 (선택/비선택)
              foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.selected)) {
                  return kPrimaryColor;
                }
                return kDarkText;
              }),

              // 배경색 설정 (선택된 버튼만 배경색 가짐)
              backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.selected)) {
                  return kPrimaryColor.withOpacity(0.05);
                }
                return Colors.transparent;
              }),
            ),
          ),
        );
        break;
    }

    return Container(
      height: height,
      color: kScaffoldBackground,
      child: tabItems,
    );
  }
}
