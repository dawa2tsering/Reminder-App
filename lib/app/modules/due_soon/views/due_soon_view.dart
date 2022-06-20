// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:reminder_app/app/modules/home/controllers/home_controller.dart';
import 'package:reminder_app/app/modules/reminder_detail/views/reminder_detail_view.dart';
import 'package:reminder_app/app/widgets/custom_page.dart';
import 'package:reminder_app/app/widgets/reminder_box.dart';

import '../controllers/due_soon_controller.dart';

class DueSoonView extends GetView<DueSoonController> {
  DueSoonView({Key? key}) : super(key: key);

  final HomeController _homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomPage(
        title: 'Due Soon',
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
                : _homeController.reminderDueSoon.isEmpty
                    ? const Center(
                        child: Text("No data."),
                      )
                    : MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _homeController.reminderDueSoon.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ReminderBox(
                                    memo: _homeController
                                        .reminderDueSoon[index]!.memo,
                                    date: _homeController
                                        .reminderDueSoon[index]!.time,
                                    onChecked: () {
                                      _homeController.updateReminderByStatus(
                                          _homeController
                                              .reminderDueSoon[index]!.id);
                                    },
                                    onTap: () {
                                      Get.to(() => ReminderDetailView(),
                                          arguments: {
                                            "id": _homeController
                                                .reminderDueSoon[index]!.id,
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
