import 'package:get/get.dart';

import '../controllers/no_alert_controller.dart';

class NoAlertBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoAlertController>(
      () => NoAlertController(),
    );
  }
}
