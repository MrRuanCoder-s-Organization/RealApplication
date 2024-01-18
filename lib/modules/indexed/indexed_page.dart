import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../app/app_style.dart';
import 'indexed_controller.dart';

class IndexedPage extends GetView<IndexedController> {
  const IndexedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(      //根据横屏或竖屏构建不同布局
      builder: (context, orientation) {
        return Scaffold(
          body: Row(
            children: [
              Visibility(
                visible: orientation == Orientation.landscape,
                child: Obx(
                      () => NavigationRail(   //在横屏模式下提供一个垂直导航栏
                    selectedIndex: controller.index.value,
                    onDestinationSelected: controller.setIndex,
                    labelType: NavigationRailLabelType.none,  //不显示标签
                    destinations: controller.items
                        .map(
                          (item) => NavigationRailDestination(
                        icon: Icon(item.iconData),
                        label: Text(item.title),
                        padding: AppStyle.edgeInsetsV8,
                      ),
                    )
                        .toList(),
                  ),
                ),
              ),
              Expanded(
                child: Obx(
                      () => Container(
                    decoration: BoxDecoration(
                      border: Border(
                        left: orientation == Orientation.landscape
                            ? BorderSide(
                          color: Colors.grey.withOpacity(.2),
                          width: 1,
                        )
                            : BorderSide.none,
                      ),
                    ),
                    child: IndexedStack(
                      index: controller.index.value,
                      children: controller.pages,
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Visibility(
            visible: orientation == Orientation.portrait,
            child: Obx(
                  () => NavigationBar(
                selectedIndex: controller.index.value,
                onDestinationSelected: controller.setIndex,
                height: 56,
                labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                destinations: controller.items
                    .map(
                      (item) => NavigationDestination(
                    icon: Icon(item.iconData),
                    label: item.title,
                  ),
                )
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}