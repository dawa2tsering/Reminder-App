// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
        body: _reminderCategoryController.loading.value == true
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : _reminderCategoryController.reminder.isEmpty &&
                    _reminderCategoryController.reminderCompleted.isEmpty
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
                      _reminderCategoryController.reminder.isEmpty
                          ? const SizedBox()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text('Incomplete'),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  child: ListView.builder(
                                      reverse: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: _reminderCategoryController
                                          .reminder.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            ReminderBox(
                                              memo: _reminderCategoryController
                                                  .reminder[index]!.memo,
                                              date: _reminderCategoryController
                                                  .reminder[index]!.time,
                                              onChecked: () {
                                                _reminderCategoryController
                                                    .updateReminderByStatus(
                                                        _reminderCategoryController
                                                            .reminder[index]!
                                                            .id);
                                              },
                                              onTap: () {
                                                Get.to(
                                                    () => ReminderDetailView(),
                                                    arguments: {
                                                      "id":
                                                          _reminderCategoryController
                                                              .reminder[index]!
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
                                  height: 40,
                                ),
                              ],
                            ),
                      _reminderCategoryController.reminderCompleted.isEmpty
                          ? const SizedBox()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text('Complete'),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  child: ListView.builder(
                                      reverse: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: _reminderCategoryController
                                          .reminderCompleted.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            reminderBox(
                                              memo: _reminderCategoryController
                                                  .reminderCompleted[index]!
                                                  .memo,
                                              date: _reminderCategoryController
                                                  .reminderCompleted[index]!
                                                  .time,
                                              onTap: () {
                                                Get.to(
                                                    () => ReminderDetailView(),
                                                    arguments: {
                                                      "id":
                                                          _reminderCategoryController
                                                              .reminderCompleted[
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
                    ],
                  ),
      ),
    );
  }

  Widget reminderBox({String? memo, String? date, VoidCallback? onTap}) {
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
                onPressed: () {},
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
