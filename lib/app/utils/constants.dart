import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder_app/app/modules/home/controllers/home_controller.dart';

final _homeController = Get.put(HomeController());
mixin AppColors {
  static Color pk = _homeController.loading.value ? Colors.red.shade300 : Colors.black;
  static Color yellow = Colors.yellow.shade800;
}
