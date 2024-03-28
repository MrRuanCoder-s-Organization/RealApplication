import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:real_application/services/iflyspeechevaluation/ise_service.dart';

void main() {
  late IseService iseService;

  setUp(() {
    iseService = IseService();
  });

  test('IseService initializes successfully', () async {
    await iseService.init();
    expect(iseService.onResult, isNotNull);
  });

  test('IseService sends audio data and receives result', () async {
    await iseService.init();

    // 模拟音频数据
    final List<int> audioData = List.generate(1280, (index) => index % 256);
    final Uint8List audio = Uint8List.fromList(audioData);

    // 发送音频数据
    await iseService.send(audio, text: '测试文本');
    await iseService.send(Uint8List(0), isEnd: true);

    // 验证返回结果
    await expectLater(
      iseService.onResult,
      emitsInOrder([
        emitsAnyOf([
          containsPair('code', equals(0)),
          containsPair('message', equals('success')),
          containsPair('sid', isNotNull),
          containsPair('data', isNotNull),
        ]),
        emitsAnyOf([
          containsPair('code', equals(0)),
          containsPair('message', equals('success')),
          containsPair('sid', isNotNull),
          containsPair('data', isNotNull),
        ]),
      ]),
    );
  });
}
