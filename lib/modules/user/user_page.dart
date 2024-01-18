import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../app/app_style.dart';
import '../../app/utils.dart';
import '../../routes/route_path.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(   //AnnotatedRegion<SystemUiOverlayStyle>用于修改系统UI的样式
      value: Get.isDarkMode
          ? SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor: Colors.transparent,
      )
          : SystemUiOverlayStyle.dark.copyWith(
        systemNavigationBarColor: Colors.transparent,
      ),
      child: SafeArea(          //SafeArea widget 确保页面的内容不会被设备的刘海、角落或其他系统UI遮挡
        child: ListView(
          padding: AppStyle.edgeInsetsA4,
          children: [
            AppStyle.vGap12,
            ListTile(
              // leading: Image.asset(
              //   'assets/images/音乐.png',
              //   width: 56,
              //   height: 56,
              // ),
              title: const Text(
                "The Sound Of Silence",
                style: TextStyle(height: 1.0),
              ),
              subtitle: const Text("一款专为听障人士设计的APP"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Get.dialog(
                  AboutDialog(
                  applicationIcon: Image.asset(
                    'assets/images/音乐.png',
                    width: 48,
                    height: 48,
                  ),
                  applicationName: "The Sound Of Silence",
                  applicationVersion: "一款专为听障人士设计的APP",
                  applicationLegalese: "Ver ${Utils.packageInfo.version}",
                ));
              },
            ),
            Divider(
              indent: 12,
              endIndent: 12,
              color: Colors.grey.withOpacity(.1),
            ),
            ListTile(
              leading: const Icon(Remix.account_circle_line),
              title: const Text("账号管理"),
              trailing: const Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
              onTap: () {
                // Get.toNamed(RoutePath.kSettingsAccount);
              },
            ),
            Divider(
              indent: 12,
              endIndent: 12,
              color: Colors.grey.withOpacity(.1),
            ),
            _buildCard(
              context,
              children: [
                ListTile(
                  leading: const Icon(Remix.moon_line),
                  title: const Text("外观设置"),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    Get.toNamed(RoutePath.kAppstyleSetting);
                  },
                ),
                ListTile(
                  leading: const Icon(Remix.home_2_line),
                  title: const Text("主页设置"),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    Get.toNamed(RoutePath.kSettingsIndexed);
                  },
                ),
                ListTile(
                  leading: const Icon(Remix.timer_2_line),
                  title: const Text("定时关闭"),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    Get.toNamed(RoutePath.kSettingsAutoExit);
                  },
                ),
              ],
            ),
            Divider(
              indent: 12,
              endIndent: 12,
              color: Colors.grey.withOpacity(.1),
            ),
            _buildCard(
              context,
              children: [
                const ListTile(
                  leading: Icon(Remix.error_warning_line),
                  title: Text("免责声明"),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                  ),
                  onTap: Utils.showStatement,
                ),
                ListTile(
                  leading: const Icon(Remix.github_line),
                  title: const Text("开源主页"),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    launchUrlString(
                      "https://github.com/MrRuanCoder-s-Organization/RealApplication",
                      mode: LaunchMode.externalApplication,
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Remix.upload_2_line),
                  title: const Text("检查更新"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Ver ${Utils.packageInfo.version}"),
                      AppStyle.hGap4,
                      const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  onTap: () {
                    // Utils.checkUpdate(showMsg: true);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, {required List<Widget> children}) {
    return Theme(
      data: Theme.of(context).copyWith(
        listTileTheme: ListTileThemeData(
          shape: RoundedRectangleBorder(borderRadius: AppStyle.radius8),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}