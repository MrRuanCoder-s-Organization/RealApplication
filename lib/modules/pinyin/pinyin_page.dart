import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_application/modules/pinyin/pinyin_controller.dart';

class PinyinPage extends GetView<PinyinController> {
  const PinyinPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        leadingWidth: 100,
        // 左侧添加“使用帮助”按钮，用圆角矩形包裹，汉字和边框颜色为白色，无背景色
        leading: Container(
          margin: const EdgeInsets.all(8),
          child: TextButton(
            onPressed: () {
              Get.defaultDialog(
                title: '使用帮助',
                content: const Text('使用帮助'),
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.white),
              ),
            ),
            child: const Text('使用帮助'),
          ),
        ),
        
        title: const Text('发音测试'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.red,
            height: 20,
          ),
          // 使用Stack和Positioned制造悬浮效果
          SizedBox( // 包裹Stack以给定高度
            height: 100, // 通常情况下你需要根据实际内容调整这个值
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -30,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        margin: const EdgeInsets.all(8),
                        child: Card(
                          color: Colors.white,
                          surfaceTintColor: Colors.white  ,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Get.defaultDialog(
                                title: '我的练习本',
                                content: const Text('我的练习本'),
                              );
                            },
                            child: const Text('我的练习本'),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        margin: const EdgeInsets.all(8),
                        child: Card(
                          color: Colors.white,
                          surfaceTintColor: Colors.white ,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextButton(
                            onPressed: () {
                              // Get.toNamed('/pinyin');
                            },
                            child: const Text('发音测试'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Wrap(
            spacing: 20,  // 水平间距
            runSpacing: 20,  // 垂直间距
            children: [
              // 下面的 Container 定义可以重复用以创建其他按钮
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),  // 添加圆角
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Text('我', style: TextStyle(fontSize: 24)),
                    Text('wǒ', style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Text('你'),
                    Text('nǐ'),
                  ],
                ),
              ),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Text('你'),
                    Text('nǐ'),
                  ],
                ),
              ),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Text('你'),
                    Text('nǐ'),
                  ],
                ),
              ),
              // 根据需要复制上面的 Container 以创建更多按钮
            ],
          ),
        ],
      ),
    );
  }
}