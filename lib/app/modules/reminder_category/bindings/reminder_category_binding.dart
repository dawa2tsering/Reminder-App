import 'package:get/get.dart';

import '../controllers/reminder_category_controller.dart';

class ReminderCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReminderCategoryController>(
      () => ReminderCategoryController(),
    );
  }
}
