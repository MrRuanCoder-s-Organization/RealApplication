import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../app/controller/base_controller.dart';
import '../../app/event_bus.dart';
import '../../routes/route_path.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
}