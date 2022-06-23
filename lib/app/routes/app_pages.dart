import 'package:get/get.dart';

import '../modules/add_reminder/bindings/add_reminder_binding.dart';
import '../modules/add_reminder/views/add_reminder_view.dart';
import '../modules/category/bindings/category_binding.dart';
import '../modules/category/views/category_view.dart';
import '../modules/completed_reminder/bindings/completed_reminder_binding.dart';
import '../modules/completed_reminder/views/completed_reminder_view.dart';
import '../modules/due_soon/bindings/due_soon_binding.dart';
import '../modules/due_soon/views/due_soon_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/no_alert/bindings/no_alert_binding.dart';
import '../modules/no_alert/views/no_alert_view.dart';
import '../modules/over_due/bindings/over_due_binding.dart';
import '../modules/over_due/views/over_due_view.dart';
import '../modules/reminder_category/bindings/reminder_category_binding.dart';
import '../modules/reminder_category/views/reminder_category_view.dart';
import '../modules/reminder_detail/bindings/reminder_detail_binding.dart';
import '../modules/reminder_detail/views/reminder_detail_view.dart';
import '../modules/search_reminder/bindings/search_reminder_binding.dart';
import '../modules/search_reminder/views/search_reminder_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ADD_REMINDER,
      page: () => AddReminderView(),
      binding: AddReminderBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_REMINDER,
      page: () => SearchReminderView(),
      binding: SearchReminderBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY,
      page: () => CategoryView(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: _Paths.DUE_SOON,
      page: () => DueSoonView(),
      binding: DueSoonBinding(),
    ),
    GetPage(
      name: _Paths.COMPLETED_REMINDER,
      page: () => CompletedReminderView(),
      binding: CompletedReminderBinding(),
    ),
    GetPage(
      name: _Paths.REMINDER_CATEGORY,
      page: () => ReminderCategoryView(
        title: '',
      ),
      binding: ReminderCategoryBinding(),
    ),
    GetPage(
      name: _Paths.OVER_DUE,
      page: () => OverDueView(),
      binding: OverDueBinding(),
    ),
    GetPage(
      name: _Paths.REMINDER_DETAIL,
      page: () => ReminderDetailView(),
      binding: ReminderDetailBinding(),
    ),
    GetPage(
      name: _Paths.NO_ALERT,
      page: () => NoAlertView(),
      binding: NoAlertBinding(),
    ),
  ];
}
