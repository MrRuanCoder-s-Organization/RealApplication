import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';
import 'package:real_application/modules/whiteboard/conform_dialog.dart';

class WhiteBoardController extends GetxController {
  List<Line> lines = []; // 线列表
  // RxList<Line> lines = RxList<Line>([]);

  int activeColorIndex = 0; // 颜色激活索引
  int activeStorkWidthIndex = 0; // 线宽激活索引
  // int selectedColorIndex = 0; // 当前选择的颜色索引

  // 支持的颜色
  final List<Color> supportColors = [
    Colors.black,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.pink,
    Colors.grey,
    Colors.redAccent,
    Colors.orangeAccent,
    Colors.yellowAccent,
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.indigoAccent,
    Colors.purpleAccent,
    Colors.pinkAccent,
  ];

  // 支持的线粗
  final List<double> supportStorkWidths = [1, 2, 4, 6, 8, 10];

  List<Line> historyLines = [];

  void showClearDialog() {
    String msg = "您的当前操作会清空绘制内容，是否确定删除!";
    showDialog(
        context: Get.context!,
        builder: (ctx) => ConformDialog(
              title: '清空提示',
              conformText: '确定',
              msg: msg,
              onConform: _clear,
      )
     );
  }


  void _clear() {
    historyLines = List.from(lines);
    // print('historyLines: $historyLines');
    lines.clear();

    // update();
    update(['customPaint', 'appBar']);
  }

  void back() {
    // Line line = lines.removeLast();
    if (lines.isEmpty) return;
    Line line = lines.removeLast();
    
    historyLines.add(line);
    // update
    update(['customPaint', 'appBar']);
  }

  void revocation() {
    if (historyLines.isEmpty) return;
    Line line = historyLines.removeLast();
    lines.add(line);
    // update();

    update(['customPaint', 'appBar']);
  }

  void onPanStart(DragStartDetails details) {
    lines.add(Line(
      points: [details.localPosition],
      strokeWidth: supportStorkWidths[activeStorkWidthIndex],
      color: supportColors[activeColorIndex],
    ));
    // update(); 
    update(['customPaint', 'appBar']);
  }

  void onPanUpdate(DragUpdateDetails details) {
    Offset point = details.localPosition;
    double distance = (lines.last.points.last - point).distance;
    if (distance > 5) {
      lines.last.points.add(details.localPosition);
      // update();
      update(['customPaint', 'appBar']);
    }
  }

  void onSelectStorkWidth(int index) {
    if (index != activeStorkWidthIndex) {
      activeStorkWidthIndex = index;
      // update();
      update(['storkWidthSelector']);
    }
  }

  void onSelectColor(int index) {
    if (index != activeColorIndex) {
      activeColorIndex = index;
      // update();
      update(['colorSelector']);

    }
  }
}

class Line {
  List<Offset> points;
  Color color;
  double strokeWidth;

  Line({
    required this.points,
    this.color = Colors.black,
    this.strokeWidth = 1,
  });
}