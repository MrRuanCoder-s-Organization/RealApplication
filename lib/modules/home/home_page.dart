import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/app_style.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('首页'),);
  }
}