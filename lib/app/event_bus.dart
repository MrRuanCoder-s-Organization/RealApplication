import 'dart:async';

import 'log.dart';


/// 全局事件
class EventBus {
  /// 点击了底部导航
  static const String kBottomNavigationBarClicked =
      "BottomNavigationBarClicked";
  static EventBus? _instance;

  static EventBus get instance {
    _instance ??= EventBus();     //??=实现单例模式,一个空合并赋值操作符,首先检查 _instance 变量是否为 null,若为null则创建一个新实例
    return _instance!;
  }

  final Map<String, StreamController> _streams = {};    //StreamController 用于控制事件流，允许事件的发送和监听

  /// 触发事件
  void emit<T>(String name, T data) {
    if (!_streams.containsKey(name)) {
      _streams.addAll({name: StreamController.broadcast()});    //broadcast 类型的 StreamController 允许多个监听器监听事件流。
    }
    Log.d("Emit Event：$name\r\n$data");

    _streams[name]!.add(data);
  }

  /// 监听事件
  StreamSubscription<dynamic> listen(String name, Function(dynamic)? onData) {
    if (!_streams.containsKey(name)) {
      _streams.addAll({name: StreamController.broadcast()});
    }
    return _streams[name]!.stream.listen(onData);     //该流上注册 onData 函数作为监听器
  }
}