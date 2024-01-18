import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../app/controller/base_controller.dart';
import '../../app/event_bus.dart';
import '../../routes/route_path.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  HomeController() {
    tabController =
        TabController(length: Sites.supportSites.length, vsync: this);
  }

  StreamSubscription<dynamic>? streamSubscription;

  @override
  void onInit() {
    streamSubscription = EventBus.instance.listen(
      EventBus.kBottomNavigationBarClicked,
          (index) {
        if (index == 0) {
          refreshOrScrollTop();
        }
      },
    );
    for (var site in Sites.supportSites) {
      Get.put(HomeListController(site), tag: site.id);
    }

    super.onInit();
  }

  void refreshOrScrollTop() {
    var tabIndex = tabController.index;
    BasePageController controller;
    controller =
        Get.find<HomeListController>(tag: Sites.supportSites[tabIndex].id);
    controller.scrollToTopOrRefresh();
  }

  void toSearch() {
    Get.toNamed(RoutePath.kSearch);     //基于名称进行导航(使用 GetX 进行导航管理不需要 BuildContext)
  }

  @override
  void onClose() {
    streamSubscription?.cancel();
    super.onClose();
  }
}