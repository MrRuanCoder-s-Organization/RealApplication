import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/app_style.dart';
import '../../../app/constant.dart';
import '../../../widgets/settings/settings_card.dart';
import 'indexed_settings_controller.dart';

class IndexedSettingsPage extends GetView<IndexedSettingsController> {
  const IndexedSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("主页设置"),
      ),
      body: ListView(
        padding: AppStyle.edgeInsetsA12,
        children: [
          Padding(
            padding: AppStyle.edgeInsetsA12.copyWith(top: 0),
            child: Text(
              "主页排序 (长按拖动排序，重启后生效)",
              style: Get.textTheme.titleSmall,
            ),
          ),
          SettingsCard(
            child: Obx(
                  () => ReorderableListView(      //ReorderableListView 允许用户通过长按并拖动来重新排序列表项
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),        //physics 属性用于确定如何处理用户的滚动输入，以及如何在滚动结束时显示内容
                onReorder: controller.updateHomeSort,       //用户重新排序列表项时，这个方法会被调用
                children: controller.homeSort.map(
                      (key) {
                    var e = Constant.allHomePages[key]!;
                    return ListTile(
                      key: ValueKey(e.title),
                      title: Text(e.title),
                      visualDensity: VisualDensity.compact,
                      leading: Icon(e.iconData),
                      trailing: const Icon(Icons.drag_handle),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
