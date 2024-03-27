import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/app_style.dart';
import 'home_controller.dart';

import '../../routes/route_path.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 做一个按钮，点击get入kWhiteBoard
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.toNamed(RoutePath.kWhiteBoard);
              },
              child: const Text('跳转到白板'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(RoutePath.ttsPage);
              },
              child: const Text('文字转语音'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(RoutePath.kRecordEvaluation);
              },
              child: const Text('跳转到语音评测'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(RoutePath.kXfRecognition);
              },
              child: const Text('跳转到讯飞识别'),
            ),
          ],
        ),
      ),
    );
  }
}
