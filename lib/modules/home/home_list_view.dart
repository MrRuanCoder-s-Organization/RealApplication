import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'home_list_controller.dart';

class HomeListView extends StatelessWidget {
  final String tag;
  const HomeListView(this.tag, {Key? key}) : super(key: key);
  HomeListController get controller => Get.find<HomeListController>(tag: tag);
  @override
  Widget build(BuildContext context) {
    var c = MediaQuery.of(context).size.width ~/ 180;
    if (c < 2) {
      c = 2;
    }
    return KeepAliveWrapper(
      child: PageGridView(
        pageController: controller,
        padding: AppStyle.edgeInsetsA12,
        firstRefresh: true,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        crossAxisCount: c,
        itemBuilder: (_, i) {
          var item = controller.list[i];
          return LiveRoomCard(controller.site, item);
        },
      ),
    );
  }
}