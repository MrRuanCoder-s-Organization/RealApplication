import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';


class SpeechEvaluationController extends GetxController {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  String? _recordedPath;

  @override
  void onInit() {
    super.onInit();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    await _recorder.openRecorder();
    await _player.openPlayer();
    await Permission.microphone.request();
  }

  Future<void> startRecording() async {
    // 还要保存录音文件的路径
    await _recorder.startRecorder(toFile: 'speech_evaluation.aac');
    _recordedPath = "speech_evaluation.aac";
  }

  Future<void> stopRecording() async {
    await _recorder.stopRecorder();
    // TODO: 调用评测接口,获取评测结果并更新UI
  }

  Future<void> playRecording() async {
    if (_recordedPath != null) {
      print('Playing recorded file: $_recordedPath');
      await _player.startPlayer(fromURI: _recordedPath!);
    }
    else {
      print('No recorded file to play');
    
    }
  }

  @override
  void onClose() {
    _recorder.closeRecorder();
    _player.closePlayer();
    super.onClose();
  }
}
