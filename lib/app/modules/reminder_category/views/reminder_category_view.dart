// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:reminder_app/app/modules/reminder_detail/views/reminder_detail_view.dart';
import 'package:reminder_app/app/widgets/custom_page.dart';
import 'package:reminder_app/app/widgets/reminder_box.dart';

import '../controllers/reminder_category_controller.dart';

class ReminderCategoryView extends GetView<ReminderCategoryController> {
  String title;

  ReminderCategoryView({Key? key, required this.title}) : super(key: key);

  final _reminderCategoryController = Get.put(ReminderCategoryController());

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return Obx(
      () => CustomPage(
        title: title,
        body: _reminderCategoryController.reminderOverdue.isEmpty &&
                _reminderCategoryController.reminderDueSoon.isEmpty &&
                _reminderCategoryController.reminderNoAlert.isEmpty
            ? Center(
                child: Text("No Reminder"),
              )
            : ListView(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  _reminderCategoryController.loading.value == true
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : _reminderCategoryController.reminderOverdue.isEmpty
                          ? const SizedBox()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: _reminderCategoryController
                                          .reminderOverdue.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            ReminderBox(
                                              memo: _reminderCategoryController
                                                  .reminderOverdue[index]!.memo,
                                              date: _reminderCategoryController
                                                  .reminderOverdue[index]!.time,
                                              onChecked: () {
                                                _reminderCategoryController
                                                    .updateReminderByStatus(
                                                        _reminderCategoryController
                                                            .reminderOverdue[
                                                                index]!
                                                            .id);
                                              },
                                              onTap: () {
                                                Get.to(
                                                    () => ReminderDetailView(),
                                                    arguments: {
                                                      "id":
                                                          _reminderCategoryController
                                                              .reminderOverdue[
                                                                  index]!
                                                              .id,
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
                            ),
                  _reminderCategoryController.loading.value == true
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : _reminderCategoryController.reminderDueSoon.isEmpty
                          ? const SizedBox()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: _reminderCategoryController
                                          .reminderDueSoon.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            ReminderBox(
                                              memo: _reminderCategoryController
                                                  .reminderDueSoon[index]!.memo,
                                              date: _reminderCategoryController
                                                  .reminderDueSoon[index]!.time,
                                              onChecked: () {
                                                _reminderCategoryController
                                                    .updateReminderByStatus(
                                                        _reminderCategoryController
                                                            .reminderDueSoon[
                                                                index]!
                                                            .id);
                                              },
                                              onTap: () {
                                                Get.to(
                                                    () => ReminderDetailView(),
                                                    arguments: {
                                                      "id":
                                                          _reminderCategoryController
                                                              .reminderDueSoon[
                                                                  index]!
                                                              .id,
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
                            ),
                  _reminderCategoryController.loading.value == true
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : _reminderCategoryController.reminderNoAlert.isEmpty
                          ? const SizedBox()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: _reminderCategoryController
                                          .reminderNoAlert.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            ReminderBox(
                                              memo: _reminderCategoryController
                                                  .reminderNoAlert[index]!.memo,
                                              date: _reminderCategoryController
                                                  .reminderNoAlert[index]!.time,
                                              onChecked: () {
                                                _reminderCategoryController
                                                    .updateReminderByStatus(
                                                        _reminderCategoryController
                                                            .reminderNoAlert[
                                                                index]!
                                                            .id);
                                              },
                                              onTap: () {
                                                Get.to(
                                                    () => ReminderDetailView(),
                                                    arguments: {
                                                      "id":
                                                          _reminderCategoryController
                                                              .reminderNoAlert[
                                                                  index]!
                                                              .id,
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
