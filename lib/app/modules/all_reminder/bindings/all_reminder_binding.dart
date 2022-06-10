import 'package:get/get.dart';

import '../controllers/all_reminder_controller.dart';

class AllReminderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllReminderController>(
      () => AllReminderController(),
    );
  }
}
