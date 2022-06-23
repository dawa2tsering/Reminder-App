import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:reminder_app/app/modules/home/controllers/home_controller.dart';
import 'package:reminder_app/app/modules/reminder_detail/views/reminder_detail_view.dart';
import 'package:reminder_app/app/widgets/custom_page.dart';
import 'package:reminder_app/app/widgets/reminder_box.dart';

import '../controllers/no_alert_controller.dart';

// ignore: use_key_in_widget_constructors
class NoAlertView extends GetView<NoAlertController> {
  final HomeController _homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomPage(
        title: 'No Alert',
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          children: [
            const SizedBox(
              height: 20,
            ),
            _homeController.loading.value == true
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : _homeController.reminderNoAlert.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.only(top: 100),
                        child: Text(
                          "No data.",
                          textAlign: TextAlign.center,
                        ),
                      )
                    : MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _homeController.reminderNoAlert.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ReminderBox(
                                    memo: _homeController
                                        .reminderNoAlert[index]!.memo,
                                    date: _homeController
                                        .reminderNoAlert[index]!.time,
                                    onChecked: () {
                                      _homeController.updateReminderByStatus(
                                          _homeController
                                              .reminderNoAlert[index]!.id);
                                    },
                                    onTap: () {
                                      Get.to(() => ReminderDetailView(),
                                          arguments: {
                                            "id": _homeController
                                                .reminderNoAlert[index]!.id,
                                          },
                                          popGesture: true);
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              );
                            }),
                      ),
            const SizedBox(
              height: 20,
            ),
          ],
        )));
  }
}
