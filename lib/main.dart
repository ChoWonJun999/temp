import 'dart:async';

import 'package:app/src/presentation/layout/shell_layout.dart';
import 'package:app/src/providers/step_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'src/services/foreground_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final status = await Permission.activityRecognition.request();
  if (status.isGranted) {
    await ForegroundService.start();
  }
  final stepProvider = StepProvider();

  try {
    final current = await Permission.activityRecognition.status;
    if (!current.isGranted) {
      final result = await Permission.activityRecognition.request();
      print('startup activityRecognition request result: $result');
    }
  } catch (e) {
    print('permission check error: $e');
  }

  try {
    await stepProvider.loadTodaySteps();
    print('initial loadTodaySteps done, steps=${stepProvider.todaySteps}');
  } catch (e) {
    print('initial loadTodaySteps failed: $e');
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<StepProvider>.value(value: stepProvider),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShellLayout(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale('ko', 'KR'),
      supportedLocales: [Locale('en', 'US'), Locale('ko', 'KR')],
      theme: ThemeData(
        textTheme: TextTheme(
          // 기본 스타일 추후 추가
        ),
        useMaterial3: true,
      ),
    );
  }
}
