// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';
import 'package:reminder_app/app/database/database_helper.dart';
import 'package:reminder_app/app/locator.dart/locator.dart';
import 'package:reminder_app/app/model/reminder.dart';

class ReminderCategoryController extends GetxController{
  // ignore: todo
  //TODO: Implement ReminderCategoryController

  List<Reminder?> reminder = RxList();
  List<Reminder?> reminderOverdue = RxList();
  List<Reminder?> reminderDueSoon = RxList();
  List<Reminder?> reminderNoAlert = RxList();
  RxBool loading = false.obs;

  @override
  void onInit() {
    getReminder();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  getReminder() async {
    loading.value = true;
    reminder = await locator<AppDatabase>()
        .queryReminderByCategory(categoryId: Get.arguments["id"]);     //get argument used  to pass data from view accessible to both controller and view
    reminderOverdue.clear();
    reminderDueSoon.clear();
    reminderNoAlert.clear();
    for (int i = 0; i < reminder.length; i++) {
      if (reminder[i]!.time != "" &&
          DateTime.now()
              .isAfter(DateTime.parse(reminder[i]!.time.toString()))) {
        reminderOverdue.add(reminder[i]);
      } else if (reminder[i]!.time != "" &&
          DateTime.now()
              .isBefore(DateTime.parse(reminder[i]!.time.toString()))) {
        reminderDueSoon.add(reminder[i]);
      } else if (reminder[i]!.time == "") {
        reminderNoAlert.add(reminder[i]);
      }
    }
    reminderOverdue.sort(
        (b, a) => DateTime.parse(a!.time!).compareTo(DateTime.parse(b!.time!)));
    reminderDueSoon.sort(
        (a, b) => DateTime.parse(a!.time!).compareTo(DateTime.parse(b!.time!)));
    reminderNoAlert.sort((b, a) => a!.id!.compareTo(b!.id!));
    loading.value = false;
  }

  updateReminderByStatus(int? id) async {
    await locator<AppDatabase>()
        .updateReminderStatus(status: 'complete', id: id);
    getReminder();
  }

  @override
  void onClose() {}
}
