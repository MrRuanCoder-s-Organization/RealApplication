import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_application/modules/pinyin/word_class_controller.dart';

import '../pinyin/pinyin_page.dart';

class WordClassPage extends GetView<WordClassController> {
  const WordClassPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          // 返回
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text('图标列表'),
        ),
        body: GridView.count(
          crossAxisCount: 3, // 每行显示3个网格
          children: List.generate(12, (index) {
            return Card(
              child: Container(
                color: Colors.grey[300], // 替换为实际的图像
                child: Center(
                  child: Text(
                    iconLabels[index],
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

// 图标标签列表
List<String> iconLabels = [
  '生活',
  '工作',
  '地理',
  '科技',
  '旅游',
  '植物',
  '动物',
  '音乐',
  '人物',
  '果蔬',
  '体育',
  '其他',
];