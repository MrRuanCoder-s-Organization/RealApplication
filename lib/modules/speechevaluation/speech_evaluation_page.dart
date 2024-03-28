import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_application/modules/speechevaluation/speech_evaluation_controller.dart';

class SpeechEvaluationPage extends GetView<SpeechEvaluationController> {
  const SpeechEvaluationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SpeechEvaluationController());
    controller.setText("词语");

    return GetBuilder<SpeechEvaluationController>(
      init: SpeechEvaluationController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('语音评测'),
          ),
          body: Column(
            children: [
              Expanded(
                child: Center(
                  child: Text('预留位置,用于加载发音示意动图'),
                ),
              ),
              Text(
                'ci yu (拼音)',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                '词语',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Obx(() => Text('评测结果: ${controller.score}')),
              SizedBox(height: 40),
              GestureDetector(
                onLongPress: controller.startRecording,
                onLongPressEnd: (_) => controller.stopRecording(),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '按住 说话',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: controller.playRecording,
                child: Text('回放录音'),
              ),
              SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }
}
