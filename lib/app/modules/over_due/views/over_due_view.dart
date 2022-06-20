import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:reminder_app/app/modules/home/controllers/home_controller.dart';
import 'package:reminder_app/app/modules/reminder_detail/views/reminder_detail_view.dart';
import 'package:reminder_app/app/widgets/custom_page.dart';
import 'package:reminder_app/app/widgets/reminder_box.dart';

import '../controllers/over_due_controller.dart';

class OverDueView extends GetView<OverDueController> {
  final HomeController _homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomPage(
        title: 'Overdue',
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
                : _homeController.reminderOverdue.isEmpty
                    ? const Center(
                        child: Text("No data."),
                      )
                    : MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _homeController.reminderOverdue.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ReminderBox(
                                    memo: _homeController
                                        .reminderOverdue[index]!.memo,
                                    date: _homeController
                                        .reminderOverdue[index]!.time,
                                    onChecked: () {
                                      _homeController.updateReminderByStatus(
                                          _homeController
                                              .reminderOverdue[index]!.id);
                                    },
                                    onTap: () {
                                      Get.to(() => ReminderDetailView(),
                                          arguments: {
                                            "id": _homeController
                                                .reminderOverdue[index]!.id,
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
