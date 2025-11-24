import 'package:flutter/services.dart';

class ForegroundService {
  static const _ch = MethodChannel('com.example.pedometer/foreground');

  static Future<void> start() async {
    try {
      await _ch.invokeMethod('startService');
    } catch (e) {
      // ignore or log
    }
  }

  static Future<void> stop() async {
    try {
      await _ch.invokeMethod('stopService');
    } catch (e) {
      // ignore or log
    }
  }
}
