// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';
import 'package:reminder_app/app/database/database_helper.dart';
import 'package:reminder_app/app/locator.dart/locator.dart';
import 'package:reminder_app/app/model/reminder.dart';

class SearchReminderController extends GetxController {
  //TODO: Implement SearchReminderController
  List<Reminder?> reminder = RxList();
  RxBool textListener = false.obs;
  RxBool searchListener = false.obs;
  List reminderList = RxList();
  RxBool loading = false.obs;

  List<Reminder?> foundReminder = RxList();
  List<Reminder?> result = RxList();
  @override
  void onInit() {
    getReminderList();
    foundReminder = reminder;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmail) {
      result = reminder;
    } else {
      result = reminder
          .where((element) => element!.memo!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    foundReminder = result;
  }

  getReminderList() async {
    loading.value = true;
    reminder = await locator<AppDatabase>().queryAllReminder();
    for (var element in reminder) {
      reminderList.add(element!.memo);
    }
    loading.value = false;
  }

  @override
  void onClose() {}
}
