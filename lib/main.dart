import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:reminder_app/app/locator.dart/locator.dart';
import 'package:reminder_app/app/modules/home/views/home_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initLocator();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    ),
  );
}
