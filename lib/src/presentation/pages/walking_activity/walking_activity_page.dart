import 'package:app/src/config/app_colors.dart';
import 'package:app/src/presentation/pages/walking_activity/daily/daily_activity_page.dart';
import 'package:app/src/presentation/pages/walking_activity/monthly/monthly_activity_page.dart';
import 'package:app/src/presentation/pages/walking_activity/weekly/weekly_activity_page.dart';
import 'package:app/src/presentation/pages/walking_activity/yearly/yearly_activity_page.dart';
import 'package:app/src/presentation/widgets/tabs/tab.dart';
import 'package:app/src/presentation/widgets/tabs/tab_config.dart';
import 'package:flutter/material.dart';

class WalkingActivityPage extends StatefulWidget {
  const WalkingActivityPage({super.key});

  @override
  State<WalkingActivityPage> createState() => _WalkingActivityPageState();
}

class _WalkingActivityPageState extends State<WalkingActivityPage>
    with TickerProviderStateMixin {
  int currentTab = 0;

  final List<AppTab> _tabs = const [
    AppTab(title: "일간 활동", child: DailyActivityPage()),
    AppTab(title: "주간 활동", child: WeeklyActivityPage()),
    AppTab(title: "월간 활동", child: MonthlyActivityPage()),
    AppTab(title: "연간 활동", child: YearlyActivityPage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackground,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: CommonTabs(
                // tabItemType: TabItemType.button,
                tabs: _tabs,
                selectedIndex: currentTab,
                onChanged: (i) {
                  setState(() {
                    currentTab = i;
                  });
                },
              ),
            ),
            Expanded(child: _tabs[currentTab].child),
          ],
        ),
      ),
    );
  }
}
