import 'package:get/get.dart';

import '../controllers/over_due_controller.dart';

class OverDueBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OverDueController>(
      () => OverDueController(),
    );
  }
}
