// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';
import 'package:reminder_app/app/database/database_helper.dart';
import 'package:reminder_app/app/locator.dart/locator.dart';
import 'package:reminder_app/app/model/reminder.dart';
import 'package:reminder_app/app/modules/home/controllers/home_controller.dart';

class CompletedReminderController extends GetxController {
  // ignore: todo
  //TODO: Implement CompletedReminderController
  RxBool loading = false.obs;
  List<Reminder?> reminderCompleted = RxList();
  final _homeController = Get.put(HomeController());
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getReminder();
    super.onReady();
  }

  getReminder() async {
    loading.value = true;
    reminderCompleted =
        await locator<AppDatabase>().queryReminder(status: 'complete');
    loading.value = false;
  }

  updateReminderByStatus(int? id) async {
    await locator<AppDatabase>()
        .updateReminderStatus(status: 'incomplete', id: id);
    getReminder();
    _homeController.getReminder();
  }

  deleteReminder() async {
    await locator<AppDatabase>().deleteReminder(status: 'complete');
    getReminder();
    _homeController.getReminder();
  }

  @override
  void onClose() {}
}
