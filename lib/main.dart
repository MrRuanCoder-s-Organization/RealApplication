import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:real_application/routes/app_pages.dart';
import 'package:real_application/routes/route_path.dart';
import 'package:real_application/services/local_storage_service.dart';
import 'package:real_application/widgets/app_loading_widget.dart';

import 'app/app_style.dart';
import 'app/controller/app_settings_controller.dart';
import 'app/core_log.dart';
import 'app/log.dart';
import 'app/utils.dart';
import 'modules/other/debug_log_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // MediaKit.ensureInitialized();
  await Hive.initFlutter();   //本地存储库

  //初始化服务
  await initServices();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  //设置状态栏为透明
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
  );
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

  runApp(const MyApp());
}

Future initServices() async {
  //日志信息
  CoreLog.enableLog = !kReleaseMode;
  CoreLog.onPrintLog = (level, msg) {
    switch (level) {
      case Level.debug:
        Log.d(msg);
        break;
      case Level.error:
        Log.e(msg, StackTrace.current);
        break;
      case Level.info:
        Log.i(msg);
        break;
      case Level.warning:
        Log.w(msg);
        break;
      default:
        Log.logPrint(msg);
    }
  };


  //包信息
  Utils.packageInfo = await PackageInfo.fromPlatform();
  //本地存储
  Log.d("Init LocalStorage Service");
  await Get.put(LocalStorageService()).init();
  //初始化设置控制器
  Get.put(AppSettingsController());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isDynamicColor = Get
        .find<AppSettingsController>()
        .isDynamic
        .value;
    Color styleColor =
    Color(Get
        .find<AppSettingsController>()
        .styleColor
        .value);
    return DynamicColorBuilder(     //ColorScheme: Material Design的一个概念,它封装了用于UI设计的一系列颜色。
        builder: ((ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
          ColorScheme? lightColorScheme;
          ColorScheme? darkColorScheme;
          if (lightDynamic != null && darkDynamic != null && isDynamicColor) {
            lightColorScheme = lightDynamic;
            darkColorScheme = darkDynamic;
          } else {
            lightColorScheme = ColorScheme.fromSeed(      //fromSeed根据一个“种子”颜色生成一整套配色方案。
              seedColor: styleColor,
              brightness: Brightness.light,
            );
            darkColorScheme = ColorScheme.fromSeed(
                seedColor: styleColor, brightness: Brightness.dark);
          }
          return GetMaterialApp(
            title: "The Sound Of Silence",
            theme: AppStyle.lightTheme.copyWith(colorScheme: lightColorScheme),
            darkTheme: AppStyle.darkTheme.copyWith(
                colorScheme: darkColorScheme),
            themeMode:
            ThemeMode.values[Get
                .find<AppSettingsController>()
                .themeMode
                .value],
            initialRoute: RoutePath.kIndex,
            getPages: AppPages.routes,
            //国际化
            locale: const Locale("zh", "CN"),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,     //提供Material组件库的本地化字符串和其他值
              GlobalWidgetsLocalizations.delegate,      //提供默认的文本方向（从左到右或从右到左）
              GlobalCupertinoLocalizations.delegate,    //提供Cupertino组件库（iOS风格的组件）的本地化字符串和其他值
            ],
            supportedLocales: const [Locale("zh", "CN")],
            logWriterCallback: (text, {bool? isError}) {
              Log.addDebugLog(
                  text, (isError ?? false) ? Colors.red : Colors.grey);
            },
            //debugShowCheckedModeBanner: false,
            navigatorObservers: [FlutterSmartDialog.observer],
            builder: FlutterSmartDialog.init(
              loadingBuilder: ((msg) => const AppLoaddingWidget()),
              //字体大小不跟随系统变化
              builder: (context, child) =>
                  MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      // textScaler: const TextScaler.linear(1.0),
                      textScaleFactor: 1.0,       //文本的缩放比例为正常大小，不受用户的设备设置影响
                    ),
                    child: Stack(
                      children: [
                        child!,
                        //查看DEBUG日志按钮
                        //只在Debug、Profile模式显示
                        Visibility(
                          visible: !kReleaseMode,
                          child: Positioned(
                            right: 12,
                            bottom: 100 + context.mediaQueryViewPadding.bottom,
                            child: Opacity(
                              opacity: 0.4,
                              child: ElevatedButton(
                                child: const Text("DEBUG LOG"),
                                onPressed: () {
                                  Get.bottomSheet(
                                    const DebugLogPage(),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            ),
          );
        }));
  }
}
