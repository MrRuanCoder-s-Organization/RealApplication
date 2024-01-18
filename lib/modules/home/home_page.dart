import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/app_style.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 8,
        title: TabBar(
          controller: controller.tabController,
          labelPadding: AppStyle.edgeInsetsH20,
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.label,
          tabAlignment: TabAlignment.center,
          tabs: Sites.supportSites
              .map(
                (e) => Tab(
              //text: e.name,

              child: Row(
                children: [
                  Image.asset(
                    e.logo,
                    width: 24,
                  ),
                  AppStyle.hGap8,
                  Text(e.name),
                ],
              ),
            ),
          )
              .toList(),
        ),
        actions: [
          IconButton(
            onPressed: controller.toSearch,
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: Sites.supportSites
            .map(
              (e) => HomeListView(
            e.id,
          ),
        )
            .toList(),      //将可迭代的元素（如 Set、Map 的输出或任何 Iterable 类型）转换成一个列表
      ),
    );
  }
}