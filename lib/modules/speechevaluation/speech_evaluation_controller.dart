import 'package:get/get.dart';

class SpeechEvaluationController extends GetxController {
  void startRecording() {
    // 开始录音的逻辑
    print('开始录音');
  }

  void stopRecording() {
    // 停止录音并进行评测的逻辑
    print('停止录音并评测'); 
    // TODO: 调用评测接口,获取评测结果并更新UI
  }
}
