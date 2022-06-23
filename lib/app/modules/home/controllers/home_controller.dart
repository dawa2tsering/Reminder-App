// ignore_for_file: unnecessary_overrides

import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:reminder_app/app/database/database_helper.dart';
import 'package:reminder_app/app/locator.dart/locator.dart';
import 'package:reminder_app/app/model/reminder.dart';
import 'package:reminder_app/app/utils/notification_service.dart';
import 'package:timezone/timezone.dart' as tz;

class HomeController extends GetxController {
  // ignore: todo
  //TODO: Implement HomeController
  List<Reminder?> reminder = RxList();
  List<Reminder?> reminderOverdue = RxList();
  List<Reminder?> reminderDueSoon = RxList();
  List<Reminder?> reminderNoAlert = RxList();
  RxBool loading = false.obs;
  Timer? timer;
  var currentTime = DateTime.now();

  @override
  void onInit() {
    getReminder();
    super.onInit();
    // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {});
    reminderDueSoon.isNotEmpty ? startTimer() : null;
  }

  startTimer() {
    log("started timer");
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      currentTime = DateTime.now();
      refreshDB();
    });
  }

  refreshDB() {
    if (reminderDueSoon.isNotEmpty) {
      if (DateTime.parse(reminderDueSoon.first!.time!).isBefore(currentTime)) {
        getReminder();
      } else {
        null;
      }
    } else {
      timer!.cancel();
      log("canceled timer");
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  getReminder() async {
    loading.value = true;
    reminder = await locator<AppDatabase>().queryReminder(status: 'incomplete');
    reminderOverdue.clear();
    reminderDueSoon.clear();
    reminderNoAlert.clear();
    for (int i = 0; i < reminder.length; i++) {
      //reminder overdue data
      if (reminder[i]!.time != "" &&
          DateTime.now()
              .isAfter(DateTime.parse(reminder[i]!.time.toString()))) {
        reminderOverdue.add(reminder[i]);
      }
      //reminder duesoon data
      else if (reminder[i]!.time != "" &&
          DateTime.now()
              .isBefore(DateTime.parse(reminder[i]!.time.toString()))) {
        reminderDueSoon.add(reminder[i]);
        //utc time is 5 hr and 45 min behind nepal time
        DateTime dateTime = DateTime.parse(reminder[i]!.time!);
        log("datetime: $dateTime");
        log("needed: ${tz.TZDateTime.now(tz.getLocation('Asia/Kathmandu'))}");
        NotificationService.scheduleNotification(
            id: reminder[i]!.id!,
            title: 'Reminder',
            body: reminder[i]!.memo,
            dateTime: tz.TZDateTime(
                tz.getLocation('Asia/Kathmandu'),
                dateTime.year,
                dateTime.month,
                dateTime.day,
                dateTime.hour,
                dateTime.minute,
                dateTime.second),
            payload: reminder[i]!.id!.toString());
      }
      //reminder no alert data
      else if (reminder[i]!.time == "") {
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
    NotificationService.cancelScheduleNotification(id: id!);
    getReminder();
  }

  @override
  void onClose() {}
}
