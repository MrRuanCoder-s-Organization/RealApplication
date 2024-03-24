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
      // body: Center(
      //   child: ElevatedButton(
      //     onPressed: () {
      //       Get.toNamed(RoutePath.kWhiteBoard);
      //     },
      //     child: const Text('跳转到白板'),
      //   ),
      // ),
      // 再做一个按钮，点击get入kSpeechEvaluation, 两个按钮都要在
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.toNamed(RoutePath.kWhiteBoard);
              },
              child: const Text('跳转到白板'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(RoutePath.kRecordEvaluation);
              },
              child: const Text('跳转到语音评测'),
            ),
          ],
        ),
      ),
    );
  }
}