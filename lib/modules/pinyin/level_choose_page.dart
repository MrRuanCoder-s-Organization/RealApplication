import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_application/modules/pinyin/level_choose_controller.dart';

class LevelChoosePage extends GetView<LevelChooseController> {
  LevelChoosePage({Key? key}) : super(key: key);
  // 拿到选择的图标标签的数据
  var args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '选关页面',
      home: Scaffold(
        appBar: AppBar(
          title: Text(args),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                color: Colors.grey,
              ),
              SizedBox(height: 16),
              Text('平淡的日子里, 有风也有诗'),
              SizedBox(height: 32),
              Text('第一关'),
              SizedBox(height: 8),
              Text('第二关'),
              SizedBox(height: 8),
              Text('第三关'),
              SizedBox(height: 8),
              Text('第四关'),
              SizedBox(height: 8),
              Text('第五关'),
              SizedBox(height: 8),
              Text('第六关'),
              SizedBox(height: 8),
              Text('第七关'),
              SizedBox(height: 8),
              Text('第八关'),
            ],
          ),
        ),
      ),
    );
  }
}