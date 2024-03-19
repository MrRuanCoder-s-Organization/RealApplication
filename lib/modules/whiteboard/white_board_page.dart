import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_application/modules/whiteboard/white_board_controller.dart';
import 'package:real_application/modules/whiteboard/white_board_appbar.dart';
import 'package:real_application/modules/whiteboard/color_selector.dart';
import 'package:real_application/modules/whiteboard/stork_with_selector.dart';

import '../../routes/route_path.dart';


class WhiteBoardPage extends GetView<WhiteBoardController> {
  WhiteBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PaperAppBar(
        onClear: controller.showClearDialog,
        // onBack: controller.lines.isEmpty ? null : controller.back,
        // onRevocation: controller.historyLines.isEmpty ? null : controller.revocation,
      ),
      body: Stack(
        children: [
          GestureDetector(
            onPanStart: controller.onPanStart,
            onPanUpdate: controller.onPanUpdate,
            child: GetBuilder<WhiteBoardController>(
              id: 'customPaint',
              builder: (_) => CustomPaint(
                painter: PaperPainter(lines: controller.lines),
                child: ConstrainedBox(constraints: const BoxConstraints.expand()),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Expanded(
                  child: GetBuilder<WhiteBoardController>(
                    id: 'colorSelector',
                    builder: (_) => ColorSelector(
                      supportColors: controller.supportColors,
                      activeIndex: controller.activeColorIndex,
                      onSelect: controller.onSelectColor,
                    ),
                  ),
                ),
                StorkWidthSelector(
                  supportStorkWidths: controller.supportStorkWidths,
                  color: controller.supportColors[controller.activeColorIndex],
                  activeIndex: controller.activeStorkWidthIndex,
                  onSelect: controller.onSelectStorkWidth,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class PaperPainter extends CustomPainter {
  PaperPainter({
    required this.lines,
  }) {
    _paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
  }

  late Paint _paint;
  final List<Line> lines;

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < lines.length; i++) {
      drawLine(canvas, lines[i]);
    }
  }

  ///根据点位绘制线
  void drawLine(Canvas canvas, Line line) {
    _paint.color = line.color;
    _paint.strokeWidth = line.strokeWidth;

    Path path = Path();
    path.moveTo(line.points.first.dx, line.points.first.dy);
    for (int i = 1; i < line.points.length; i++) {
      path.lineTo(line.points[i].dx, line.points[i].dy);
    }

    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}