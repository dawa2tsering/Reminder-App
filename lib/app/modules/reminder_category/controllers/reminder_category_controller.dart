// ignore_for_file: unnecessary_overrides
import 'package:get/get.dart';
import 'package:reminder_app/app/database/database_helper.dart';
import 'package:reminder_app/app/locator.dart/locator.dart';
import 'package:reminder_app/app/model/reminder.dart';
import 'package:reminder_app/app/modules/home/controllers/home_controller.dart';
import 'package:reminder_app/app/utils/notification_service.dart';

class ReminderCategoryController extends GetxController {

  List<Reminder?> reminder = RxList();
  List<Reminder?> reminderCompleted = RxList();
  RxBool loading = false.obs;
  final _homeController = Get.put(HomeController());

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
    reminder = await locator<AppDatabase>().queryReminderByCategory(
        categoryId: Get.arguments[
            "id"]); //get argument used  to pass data from view accessible to both controller and view
    reminderCompleted = await locator<AppDatabase>()
        .queryCompletedReminderByCategory(categoryId: Get.arguments["id"]);
    //get argument used  to pass data from view accessible to both controller and view
    loading.value = false;
  }

  updateReminderByStatus(int? id) async {
    await locator<AppDatabase>()
        .updateReminderStatus(status: "complete", id: id);
    NotificationService.cancelScheduleNotification(id: id!);
    getReminder();
    _homeController.getReminder();
    _homeController.reminderDueSoon.isEmpty
        ? _homeController.startTimer()
        : null;
  }

  @override
  void onClose() {}
}
