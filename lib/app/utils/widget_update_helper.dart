import 'package:get/get.dart';
import 'package:reminder_app/app/database/database_helper.dart';
import 'package:reminder_app/app/locator.dart/locator.dart';
import 'package:reminder_app/app/modules/category/controllers/category_controller.dart';

class WidgetUpdateHelper {
  final categoryController = Get.put(CategoryController());

  updateWidgets() {
    locator<AppDatabase>().queryCategory();
    categoryController.update();
  }
}
