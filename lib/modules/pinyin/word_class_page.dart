import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_application/modules/pinyin/word_class_controller.dart';

import '../../routes/route_path.dart';

class WordClassPage extends GetView<WordClassController> {
  const WordClassPage({Key? key}) : super(key: key);
  // var classChoose = "生活".obs;

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
            // 为每个Card添加InkWell来监听点击事件
            return InkWell(
              onTap: () {
                // 用 obs 变量来传递数据，这里传递选择的图标标签
                // classChoose.value = iconLabels[index];
                Get.toNamed(
                  RoutePath.kLevelChoose,
                  arguments: iconLabels[index],
                );
              },
              child: Card(
                child: Container(
                  color: Colors.grey[300], // 替换为实际的图像
                  child: Center(
                    child: Text(
                      iconLabels[index],
                      style: TextStyle(fontSize: 18),
                    ),
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