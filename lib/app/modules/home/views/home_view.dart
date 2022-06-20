// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder_app/app/locator.dart/locator.dart';
import 'package:reminder_app/app/modules/reminder_detail/views/reminder_detail_view.dart';
import 'package:reminder_app/app/utils/widget_update_helper.dart';
import 'package:reminder_app/app/widgets/custome_home_page.dart';
import 'package:reminder_app/app/widgets/reminder_box.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final _homeController = Get.put(HomeController());
  final widgetUpdateHelper = locator<WidgetUpdateHelper>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomeHomePage(
        title: "My Reminder",
        body: ListView(
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          children: [
            _homeController.loading.value == true
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : _homeController.reminderOverdue.isEmpty
                    ? const SizedBox()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text('Past'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    _homeController.reminderOverdue.length <= 4
                                        ? _homeController.reminderOverdue.length
                                        : 4,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      ReminderBox(
                                        memo: _homeController
                                            .reminderOverdue[index]!.memo,
                                        date: _homeController
                                            .reminderOverdue[index]!.time,
                                        onChecked: () {
                                          _homeController
                                              .updateReminderByStatus(
                                                  _homeController
                                                      .reminderOverdue[index]!
                                                      .id);
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
                        ],
                      ),
            _homeController.loading.value == true
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : _homeController.reminderDueSoon.isEmpty
                    ? const SizedBox()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text('Soon'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    _homeController.reminderDueSoon.length <= 4
                                        ? _homeController.reminderDueSoon.length
                                        : 4,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      ReminderBox(
                                        memo: _homeController
                                            .reminderDueSoon[index]!.memo,
                                        date: _homeController
                                            .reminderDueSoon[index]!.time,
                                        onChecked: () {
                                          _homeController
                                              .updateReminderByStatus(
                                                  _homeController
                                                      .reminderDueSoon[index]!
                                                      .id);
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
                        ],
                      ),
            _homeController.loading.value == true
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : _homeController.reminderNoAlert.isEmpty
                    ? const SizedBox()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text('No alert'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    _homeController.reminderNoAlert.length <= 4
                                        ? _homeController.reminderNoAlert.length
                                        : 4,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      ReminderBox(
                                        memo: _homeController
                                            .reminderNoAlert[index]!.memo,
                                        date: _homeController
                                            .reminderNoAlert[index]!.time,
                                        onChecked: () {
                                          _homeController
                                              .updateReminderByStatus(
                                                  _homeController
                                                      .reminderNoAlert[index]!
                                                      .id);
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
                        ],
                      ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
