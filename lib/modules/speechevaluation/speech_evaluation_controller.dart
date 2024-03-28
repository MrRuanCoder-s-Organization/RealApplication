import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:real_application/services/iflyspeechevaluation/ise_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;


class SpeechEvaluationController extends GetxController {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  final IseService _iseService = IseService();
  String? _recordedPath;
  String? _text;
  RxDouble _score = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    try {
      _initRecorder();
      _iseService.init();
    } catch (e) {
      print('Error initializing controller: $e');
    }
  }


  Future<void> _initRecorder() async {
    try {
      await _recorder.openRecorder();
      await _player.openPlayer();
      final status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw Exception('Microphone permission not granted');
      }
    } catch (e) {
      print('Error initializing recorder: $e');
      rethrow;
    }
  }

  Future<void> startRecording() async {
    print('startRecording');
    final directory = await getApplicationDocumentsDirectory();
    final filePath = path.join(directory.path, 'speech_evaluation.pcm');
    await _recorder.startRecorder(toFile: filePath, codec: Codec.pcm16);
    _recordedPath = filePath;
  }

  Future<void> stopRecording() async {
    print('stopRecording');
    await _recorder.stopRecorder();
    _iseService.send(await _getAudioData(), text: _text, isEnd: true);
  }

  Future<void> playRecording() async {
    if (_recordedPath != null) {
      await _player.startPlayer(fromURI: _recordedPath!, codec: Codec.pcm16);
    }
    else {
      print('No recorded audio');
    }
  }

  Future<Uint8List> _getAudioData() async {
    final file = File(_recordedPath!);
    return await file.readAsBytes();
  }

  void setText(String text) {
    _text = text;
  }

  void _listenResults() {
    _iseService.onResult.listen((result) {
      if (result['data']['status'] == 2) {
        final xml = utf8.decode(base64.decode(result['data']['data']));
        final score = RegExp(r'total_score="(\d+(\.\d+)?)"').firstMatch(xml)?.group(1);
        if (score != null) {
          _score.value = double.parse(score);
        }
      }
    });
  }

  double get score => _score.value;

  @override
  void onClose() {
    _recorder.closeRecorder();
    _player.closePlayer();
    super.onClose();
  }
}
