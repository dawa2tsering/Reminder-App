import 'package:get/get.dart';

import '../controllers/search_reminder_controller.dart';

class SearchReminderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchReminderController>(
      () => SearchReminderController(),
    );
  }
}
