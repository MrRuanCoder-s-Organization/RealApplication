// ignore_for_file: prefer_inlined_adds

import 'package:get/get.dart';

import '../modules/indexed/indexed_controller.dart';
import '../modules/indexed/indexed_page.dart';
import '../modules/user/appstyle_setting_page.dart';
import '../modules/user/auto_exit_settings_page.dart';
import '../modules/user/indexed_settings/indexed_settings_controller.dart';
import '../modules/user/indexed_settings/indexed_settings_page.dart';
import 'route_path.dart';
import '../modules/pinyin/word_class_page.dart';

class AppPages {
  AppPages._();     //_为定义的一个私有的构造函数，故该实例不能从外部创建，提供了一个集中的地方来定义和管理应用程序的所有路由。
  static final routes = [
    // 首页
    GetPage(
      name: RoutePath.kIndex,
      page: () => const IndexedPage(),
      bindings: [
        BindingsBuilder.put(() => IndexedController()),   //实现依赖注入,IndexedController() 会被实例化并注入到 IndexedPage 中
        //BindingsBuilder.put(() => HomeController()),
      ],
    ),
    // 搜索
    // GetPage(
    //   name: RoutePath.kSearch,
    //   page: () => const SearchPage(),
    //   bindings: [
    //     BindingsBuilder.put(() => AppSearchController()),
    //   ],
    // ),
    //外观设置
    GetPage(
        name: RoutePath.kAppstyleSetting,
        page: () => const AppstyleSettingPage()
    ),
    //播放设置
    GetPage(
      name: RoutePath.kSettingsAutoExit,
      page: () => const AutoExitSettingsPage(),
    ),
    //主页设置
    GetPage(
      name: RoutePath.kSettingsIndexed,
      page: () => const IndexedSettingsPage(),
      bindings: [
        BindingsBuilder.put(() => IndexedSettingsController()),
      ],
    ),
    // 语训页面
    GetPage(
      name: RoutePath.kLanguage,
      page: () => const WordClassPage(),

    ),
    // //账号设置
    // GetPage(
    //   name: RoutePath.kSettingsAccount,
    //   page: () => const AccountPage(),
    //   bindings: [
    //     BindingsBuilder.put(() => AccountController()),
    //   ],
    // ),
  ];
}
