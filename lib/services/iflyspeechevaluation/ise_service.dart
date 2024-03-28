import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class IseService {
  static const String _hostUrl = 'wss://ise-api.xfyun.cn/v2/open-ise';
  static const String _apiKey = 'c55054b06c4f1753117debf4b31168dd';
  static const String _apiSecret = 'NWRhNDM1NTJlMmJiYmU0YWI5OGY1YmNm';
  static const String _appId = '27ce1c02';

  IOWebSocketChannel? _channel;
  String? _sid;

  Future<void> init() async {
    final url = Uri.parse(await _getAuthUrl());
    _channel = IOWebSocketChannel.connect(url);
  }

  Future<void> send(Uint8List audio, {String? text, bool isEnd = false}) async {
    if (_channel == null) {
      throw Exception('WebSocket connection not initialized');
    }

    final Map<String, dynamic> businessParams = {
      'category': 'read_sentence',
      'ent': 'cn_vip',
      'cmd': 'auw',
      'auf': 'audio/L16;rate=16000',
      'aue': 'raw',
      'text': text ?? '',
      'ttp_skip': true,
      'aus': isEnd ? 4 : audio.isEmpty ? 1 : 2,
    };

    final Map<String, dynamic> data = {
      'status': isEnd ? 2 : 1,
      'data': base64.encode(audio),
    };

    final Map<String, dynamic> request = {
      'business': businessParams,
      'data': data,
    };

    if (_sid != null) {
      request['sid'] = _sid;
    } else {
      request['common'] = {'app_id': _appId};
    }

    _channel!.sink.add(jsonEncode(request));

    if (isEnd) {
      _channel!.sink.close(status.goingAway);
    }
  }

  Stream<Map<String, dynamic>> get onResult {
    if (_channel == null) {
      throw Exception('WebSocket connection not initialized');
    }

    return _channel!.stream.map((message) {
      final Map<String, dynamic> response = jsonDecode(message);
      _sid = response['sid'];
      return response;
    });
  }

  Future<String> _getAuthUrl() async {
    final date = DateFormat('EEE, dd MMM yyyy HH:mm:ss z', 'en_US').format(DateTime.now().toUtc());
    final signatureOrigin = 'host: ${Uri.parse(_hostUrl).host}\ndate: $date\nGET ${Uri.parse(_hostUrl).path} HTTP/1.1';
    final signature = base64.encode(Hmac(sha256, utf8.encode(_apiSecret)).convert(utf8.encode(signatureOrigin)).bytes);
    final authorization = 'api_key="$_apiKey", algorithm="hmac-sha256", headers="host date request-line", signature="$signature"';
    return '$_hostUrl?authorization=${Uri.encodeComponent(authorization)}&date=${Uri.encodeComponent(date)}&host=${Uri.parse(_hostUrl).host}';
  }
}
