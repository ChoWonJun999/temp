import 'package:app/src/presentation/pages/daily/daily_activity_page.dart';
import 'package:app/src/presentation/pages/monthly/monthly_activity_page.dart';
import 'package:app/src/presentation/pages/weekly/weekly_activity_page.dart';
import 'package:app/src/presentation/widgets/activity_tabbar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool isMenuOpen = false;
  final Duration menuDuration = const Duration(milliseconds: 260);
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ActivityTabBar(
              selectedIndex: currentTab,
              onChanged: (i) {
                setState(() => currentTab = i);
              },
            ),
            Expanded(
              child: _buildTabContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (currentTab) {
      case 0:
        return const DailyActivityPage();
      case 1:
        return const WeeklyActivityPage();
      case 2:
        return const MonthlyActivityPage();
      default:
        return const SizedBox();
    }
  }
}
