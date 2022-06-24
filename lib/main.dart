import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder_app/app/locator.dart/locator.dart';
import 'package:reminder_app/app/modules/reminder_detail/views/reminder_detail_view.dart';
import 'package:reminder_app/app/utils/notification_service.dart';
import 'package:reminder_app/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initLocator();
  //initializing local notification
  await NotificationService().init();
  //initializing listen notification
  listenNotification();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: ThemeData.light(),
    ),
  );
}

//method to listen tap (strem) on notification, if the notification is clicked then will execute onClickedNotification function
void listenNotification() {
  NotificationService.onNotification.stream.listen(onClickedNotification);
}

//method to direct to the page (also passes the payload)
void onClickedNotification(String? payload) {
  Get.to(() => ReminderDetailView(), arguments: {"id": int.parse(payload!)});
}
