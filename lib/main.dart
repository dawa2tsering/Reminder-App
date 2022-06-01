import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:reminder_app/app/modules/home/views/home_view.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    ),
  );
}
