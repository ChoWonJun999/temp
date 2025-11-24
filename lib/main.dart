import 'dart:async';

import 'package:app/src/presentation/layout/shell_layout.dart';
import 'package:app/src/providers/step_provider.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'src/services/foreground_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final status = await Permission.activityRecognition.request();
  if (status.isGranted) {
    await ForegroundService.start();
  }
  // 앱 시작 시 사용할 Provider 인스턴스 생성
  final stepProvider = StepProvider();

  // 런타임 권한 요청(시작 시)
  try {
    final current = await Permission.activityRecognition.status;
    if (!current.isGranted) {
      final result = await Permission.activityRecognition.request();
      print('startup activityRecognition request result: $result');
    }
  } catch (e) {
    print('permission check error: $e');
  }

  // 권한 여부와 상관없이 초기 데이터 로드 시도 (플러그인에서 권한 없으면 예외 처리될 수 있음)
  try {
    await stepProvider.loadTodaySteps();
    print('initial loadTodaySteps done, steps=${stepProvider.todaySteps}');
  } catch (e) {
    print('initial loadTodaySteps failed: $e');
  }

  runApp(
    MultiProvider(
      providers: [
        // 미리 생성한 인스턴스를 사용 -> 초기 로드된 상태가 바로 반영됨
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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShellLayout(),
    );
  }
}
