import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:reminder_app/app/widgets/custom_page.dart';

import '../controllers/all_reminder_controller.dart';

class AllReminderView extends GetView<AllReminderController> {
  @override
  Widget build(BuildContext context) {
    return CustomPage(title: 'All', body: Center(child:Text('ssdf')));
  }
}
