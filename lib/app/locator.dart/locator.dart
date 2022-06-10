import 'package:get_it/get_it.dart';
import 'package:reminder_app/app/database/database_helper.dart';
import 'package:reminder_app/app/utils/widget_update_helper.dart';

GetIt locator = GetIt.instance;

void initLocator() {
  locator.registerLazySingleton<AppDatabase>(() => AppDatabase.appDatabase);
  locator.registerLazySingleton<WidgetUpdateHelper>(() => WidgetUpdateHelper());
}
