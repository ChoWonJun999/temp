import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepProvider extends ChangeNotifier {
  int todaySteps = 0;
  Timer? _pollTimer;
  static const MethodChannel _ch = MethodChannel(
    'com.example.pedometer/foreground',
  );

  StepProvider() {
    _startPolling();
  }

  void _startPolling() {
    _pollTimer?.cancel();
    // 3초마다 네이티브 서비스가 쓴 SharedPreferences 읽기
    _pollTimer = Timer.periodic(const Duration(seconds: 3), (_) async {
      int v = 0;
      try {
        final res = await _ch.invokeMethod<dynamic>('getSteps');
        // print('res=$res');
        if (res is int) {
          v = res;
        } else if (res is String)
          v = int.tryParse(res) ?? 0;
      } catch (e) {
        if (kDebugMode) print('StepProvider native getSteps error: $e');
        // 폴백: shared_preferences에서 읽어보긴 함(선택)
        try {
          final prefs = await SharedPreferences.getInstance();
          v = prefs.getInt('steps') ?? 0;
        } catch (_) {}
      }
      // DEBUG: 콘솔에 값 출력
      if (v != todaySteps) {
        todaySteps = v;
        notifyListeners();
      }
    });
  }

  /// 앱 시작 시 또는 수동으로 호출 가능한 초기 로드/구동 진입점
  Future<void> loadTodaySteps() async {
    // 이미 폴링을 시작했을 수 있으므로 안전하게 다시 시작
    _startPolling();
    return;
  }

  Future<void> disposeProvider() async {
    _pollTimer?.cancel();
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    super.dispose();
  }
}
