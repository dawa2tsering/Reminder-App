import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder_app/app/database/database_helper.dart';
import 'package:reminder_app/app/locator.dart/locator.dart';
import 'package:reminder_app/app/modules/home/controllers/home_controller.dart';

class ReminderDetailController extends GetxController {
  // ignore: todo
  //TODO: Implement ReminderDetailController

  var buttonEnable = false.obs;
  final memoController = TextEditingController();
  var time = "".obs;
  RxBool dateSelected = false.obs;
  final placeController = TextEditingController();
  var category = "".obs;
  var categoryId = 0.obs;
  final _homeController = Get.put(HomeController());

  addReminder() async {
    await locator<AppDatabase>().insertReminder({
      "memo": memoController.text,
      "time": time.toString(),
      "place": placeController.text,
      "status": "incomplete",
      "category": categoryId.toString(),
    });
    _homeController.getReminder();
  }

  @override
  void onClose() {}
}
