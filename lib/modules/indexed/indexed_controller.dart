import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:real_application/modules/pinyin/pinyin_controller.dart';

import '../../app/constant.dart';
import '../../app/controller/app_settings_controller.dart';
import '../../app/event_bus.dart';
import '../home/home_controller.dart';
import '../home/home_page.dart';
import '../pinyin/pinyin_page.dart';
import '../user/user_page.dart';

class IndexedController extends GetxController {
  RxList<HomePageItem> items = RxList<HomePageItem>([]);

  var index = 0.obs;
  RxList<Widget> pages = RxList<Widget>([
    const SizedBox(),
    const SizedBox(),
    const SizedBox(),
    const SizedBox(),
  ]);

  void setIndex(int i) {
    if (pages[i] is SizedBox) {
      switch (items[i].index) {
        case 0:
          Get.put(HomeController());      //Getx的依赖注入系统中注册一个依赖项
          pages[i] = const HomePage();
          break;
        case 1:
          Get.put(PinyinController());
          pages[i] = const PinyinPage();
          break;
        case 2:
          Get.put(PinyinController());
          pages[i] = const PinyinPage();
          break;
        case 3:
          pages[i] = const UserPage();
          break;
        default:
      }
    } else {
      if (index.value == i) {
        EventBus.instance
            .emit<int>(EventBus.kBottomNavigationBarClicked, items[i].index);
      }
    }

    index.value = i;
  }

  @override
  void onInit() {
    Future.delayed(Duration.zero, showFirstRun);      //指定的延迟时间后执行
    items.value = AppSettingsController.instance.homeSort
        .map((key) => Constant.allHomePages[key]!)
        .toList();
    setIndex(0);
    super.onInit();
  }

  void showFirstRun() async {
    var settingsController = Get.find<AppSettingsController>();
    if (settingsController.firstRun) {
      settingsController.setNoFirstRun();
      // await Utils.showStatement();
      // Utils.checkUpdate();
    } else {
      // Utils.checkUpdate();
    }
  }
}