// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder_app/app/database/database_helper.dart';
import 'package:reminder_app/app/locator.dart/locator.dart';
import 'package:reminder_app/app/model/reminder.dart';
import 'package:reminder_app/app/modules/category/controllers/category_controller.dart';
import 'package:reminder_app/app/modules/completed_reminder/controllers/completed_reminder_controller.dart';
import 'package:reminder_app/app/modules/home/controllers/home_controller.dart';
import 'package:reminder_app/app/modules/reminder_category/controllers/reminder_category_controller.dart';

class ReminderDetailController extends GetxController {
  // ignore: todo
  //TODO: Implement ReminderDetailController
  final _categoryController = Get.put(CategoryController());
  final _reminderCategoryController = Get.put(ReminderCategoryController());
  final _completedReminderController = Get.put(CompletedReminderController());
  RxBool loading = false.obs;
  var buttonEnable = false.obs;
  TextEditingController memoController = TextEditingController();
  var time = "".obs;
  RxBool dateSelected = false.obs;
  TextEditingController placeController = TextEditingController();
  var category = "".obs;
  var categoryId = 0.obs;
  final _homeController = Get.put(HomeController());
  List<Reminder?> reminderById = RxList();

  @override
  void onInit() async {
    await getReminderById();

    //initializing the values
    memoController = TextEditingController(text: reminderById[0]!.memo);
    time.value = reminderById[0]!.time!;
    if (reminderById[0]!.time != "") {
      dateSelected.value = true;
    }
    placeController = TextEditingController(text: reminderById[0]!.place);
    //category index 0 is equal to category id 1
    if (reminderById[0]!.category != 0) {
      category.value = _categoryController
          .category[reminderById[0]!.category! - 1]!.categoryName!;
    }

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  getReminderById() async {
    loading.value = true;
    reminderById =
        await locator<AppDatabase>().queryReminderById(id: Get.arguments["id"]);
    loading.value = false;
  }

  updateReminder() async {
    await locator<AppDatabase>().updateReminder(reminder: {
      "memo": memoController.text,
      "time": time.toString(),
      "place": placeController.text,
      "status": "incomplete",
      "category": categoryId.toString(),
    }, id: Get.arguments["id"]);
    _homeController.getReminder();
    _reminderCategoryController.getReminder();
    _completedReminderController.getReminder();
  }

  updateReminderStatus({String? status}) async {
    await locator<AppDatabase>()
        .updateReminderStatus(status: status, id: Get.arguments["id"]);
    _homeController.getReminder();
    _reminderCategoryController.getReminder();
    _completedReminderController.getReminder();
  }

  deleteReminder() async {
    await locator<AppDatabase>().deleteReminder(id: reminderById[0]!.id);
    _homeController.getReminder();
    _reminderCategoryController.getReminder();
    _completedReminderController.getReminder();
  }

  @override
  void onClose() {}
}
