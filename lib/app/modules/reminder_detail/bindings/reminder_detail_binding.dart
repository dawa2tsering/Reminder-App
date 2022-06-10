import 'package:get/get.dart';

import '../controllers/reminder_detail_controller.dart';

class ReminderDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReminderDetailController>(
      () => ReminderDetailController(),
    );
  }
}
