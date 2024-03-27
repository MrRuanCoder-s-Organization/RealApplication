import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class Log {
  static RxList<DebugLogModel> debugLogs = <DebugLogModel>[].obs;   //getx所提供的可观察状态管理列表，.obs将普通的List转换为RxList，.value来获取RxList背后的普通List

  static void addDebugLog(String content, Color? color) {
    if (kReleaseMode) { //发布模式（生产环境）
      return;
    }
    if (content.contains("请求响应")) {
      content = content.split("\n").join('\n💡 ');
    }
    try {
      debugLogs.insert(0, DebugLogModel(DateTime.now(), content, color: color));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: false,
    ),
  );

  static void d(String message) {   //debug
    addDebugLog(message, Colors.orange);
    logger.d("${DateTime.now().toString()}\n$message");
  }

  static void i(String message) {   //info
    addDebugLog(message, Colors.blue);
    logger.i("${DateTime.now().toString()}\n$message");
  }

  static void e(String message, StackTrace stackTrace) {
    addDebugLog('$message\r\n\r\n$stackTrace', Colors.red);
    logger.e("${DateTime.now().toString()}\n$message",  stackTrace);
  }

  static void w(String message) {
    addDebugLog(message, Colors.pink);
    logger.w("${DateTime.now().toString()}\n$message");
  }

  static void logPrint(dynamic obj) {
    addDebugLog(obj.toString(), Colors.red);
    //logger.e(obj.toString(), obj, obj?.stackTrace);
    if (kDebugMode) {
      print(obj);
    }
  }
}

class DebugLogModel {
  final String content;
  final DateTime datetime;
  final Color? color;
  DebugLogModel(this.datetime, this.content, {this.color});
}
