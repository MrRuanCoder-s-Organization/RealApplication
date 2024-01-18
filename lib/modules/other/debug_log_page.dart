import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../app/app_style.dart';
import '../../app/log.dart';

class DebugLogPage extends StatelessWidget {
  const DebugLogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log"),
        actions: [
          IconButton(     //读取所有的日志,格式化为字符串，并保存到应用的文档目录
            onPressed: () async {
              var msg = Log.debugLogs
                  .map((x) => "${x.datetime}\r\n${x.content}")
                  .join('\r\n\r\n');
              var dir = await getApplicationDocumentsDirectory();
              var logFile = File(
                  '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.log');
              await logFile.writeAsString(msg);
              Share.shareXFiles([XFile(logFile.path)]);     //触发设备的分享功能
            },
            icon: const Icon(Icons.save),
          ),
          IconButton(
            onPressed: () {
              Log.debugLogs.clear();
            },
            icon: const Icon(Icons.clear_all),
          ),
        ],
      ),
      body: Obx(      //bx监听 Log.debugLogs 的变化。一旦日志列表发生变化，ListView 就会自动更新
            () => ListView.separated(
          itemCount: Log.debugLogs.length,
          separatorBuilder: (_, i) => const Divider(),
          padding: AppStyle.edgeInsetsA12,
          itemBuilder: (_, i) {
            var item = Log.debugLogs[i];
            return SelectableText(
              "${item.datetime.toString()}\r\n${item.content}",
              style: TextStyle(
                color: item.color,
                fontSize: 12,
              ),
            );
          },
        ),
      ),
    );
  }
}
