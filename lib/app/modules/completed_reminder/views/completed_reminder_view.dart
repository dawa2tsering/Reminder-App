// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/app/modules/reminder_detail/views/reminder_detail_view.dart';
import 'package:reminder_app/app/widgets/custom_page.dart';

import '../controllers/completed_reminder_controller.dart';

class CompletedReminderView extends GetView<CompletedReminderController> {
  final _completedReminderController = Get.put(CompletedReminderController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomPage(
        title: 'Completed',
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          children: [
            const SizedBox(
              height: 20,
            ),
            _completedReminderController.loading.value == true
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : _completedReminderController.reminder.isEmpty
                    ? const Center(
                        child: Text("No data."),
                      )
                    : MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                            reverse: true,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                _completedReminderController.reminder.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  reminderBox(
                                    memo: _completedReminderController
                                        .reminder[index]!.memo,
                                    date: _completedReminderController
                                        .reminder[index]!.time,
                                    onPressed: () {
                                      _completedReminderController
                                          .updateReminderByStatus(
                                              _completedReminderController
                                                  .reminder[index]!.id);
                                    },
                                    onTap: () {
                                      Get.to(() => ReminderDetailView(),
                                          arguments: {
                                            "id": _completedReminderController
                                                .reminder[index]!.id,
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
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget reminderBox(
      {String? memo,
      String? date,
      VoidCallback? onPressed,
      VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width,
        padding:
            const EdgeInsets.only(top: 20, left: 30, right: 10, bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 1),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                  width: 200,
                  child: Text(
                    memo!,
                    overflow: TextOverflow.ellipsis,
                  )),
              if (date != "")
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(DateFormat('EEE, d MMM  hh:mm a')
                        .format(DateTime.parse(date!))),
                  ],
                ),
            ]),
            IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.check_box_outlined,
                  color: Colors.grey,
                ))
          ],
        ),
      ),
    );
  }
}
