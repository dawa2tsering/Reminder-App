import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:reminder_app/app/locator.dart/locator.dart';
import 'package:reminder_app/app/modules/home/views/home_view.dart';
import 'package:reminder_app/app/utils/notification_service.dart';
import 'package:reminder_app/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initLocator();
  await NotificationService().init();
  runApp(
    const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ),
  );
}
