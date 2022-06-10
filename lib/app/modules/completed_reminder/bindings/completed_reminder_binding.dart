import 'package:get/get.dart';

import '../controllers/completed_reminder_controller.dart';

class CompletedReminderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompletedReminderController>(
      () => CompletedReminderController(),
    );
  }
}
