import 'package:app/src/config/app_colors.dart';
import 'package:app/src/presentation/widgets/tabs/tab_config.dart';
import 'package:app/src/presentation/widgets/tabs/tab_item_button.dart';
import 'package:app/src/presentation/widgets/tabs/tab_item_text.dart';
import 'package:flutter/material.dart';

enum TabItemType { text, button }

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
        tabItems = TabItemButton(
          tabs: tabs,
          selectedIndex: selectedIndex,
          onSelectionChanged: (Set<int> newSelection) {
            if (newSelection.isNotEmpty) {
              onChanged(newSelection.first);
            }
          },
          sizeFactor: sizeFactor,
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
