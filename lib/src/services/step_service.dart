import 'package:home_widget/home_widget.dart';

Future<void> updateStepWidget(int steps) async {
  await HomeWidget.saveWidgetData<int>('todaySteps', steps);
  await HomeWidget.updateWidget(name: 'HomeWidgetProvider');
}
