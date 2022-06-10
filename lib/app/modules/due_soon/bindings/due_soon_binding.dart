import 'package:get/get.dart';

import '../controllers/due_soon_controller.dart';

class DueSoonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DueSoonController>(
      () => DueSoonController(),
    );
  }
}
