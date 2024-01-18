import 'package:dio/dio.dart';

import '../app/log.dart';

class CustomLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {     //onRequest 方法在请求发送到服务器之前被调用
    options.extra["ts"] = DateTime.now().millisecondsSinceEpoch;        //记录请求发送的时间戳

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    var time =
        DateTime.now().millisecondsSinceEpoch - err.requestOptions.extra["ts"];
    Log.e('''【HTTP请求错误-${err.type}】 耗时:${time}ms
${err.message}

Request Method：${err.requestOptions.method}
Response Code：${err.response?.statusCode}
Request URL：${err.requestOptions.uri}
Request Query：${err.requestOptions.queryParameters}
Request Data：${err.requestOptions.data}
Request Headers：${err.requestOptions.headers}
Response Headers：${err.response?.headers.map}
Response Data：${err.response?.data}''', err.stackTrace);
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    var time = DateTime.now().millisecondsSinceEpoch -
        response.requestOptions.extra["ts"];
    Log.i(
      '''【HTTP请求响应】 耗时:${time}ms
Request Method：${response.requestOptions.method}
Request Code：${response.statusCode}
Request URL：${response.requestOptions.uri}
Request Query：${response.requestOptions.queryParameters}
Request Data：${response.requestOptions.data}
Request Headers：${response.requestOptions.headers}
Response Headers：${response.headers.map}
Response Data：${response.data}''',
    );
    super.onResponse(response, handler);
  }
}
