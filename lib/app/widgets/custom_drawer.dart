// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder_app/app/modules/add_reminder/views/add_reminder_view.dart';
import 'package:reminder_app/app/modules/category/controllers/category_controller.dart';
import 'package:reminder_app/app/modules/category/views/category_view.dart';
import 'package:reminder_app/app/modules/completed_reminder/views/completed_reminder_view.dart';
import 'package:reminder_app/app/modules/due_soon/views/due_soon_view.dart';
import 'package:reminder_app/app/modules/over_due/views/over_due_view.dart';
import 'package:reminder_app/app/modules/reminder_category/views/reminder_category_view.dart';
import 'package:reminder_app/app/utils/notification_service.dart';
import 'package:timezone/timezone.dart' as tz;

class CustomDrawer extends StatelessWidget {
  CustomDrawer({Key? key}) : super(key: key);
  final _categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.only(left: 20, right: 20, top: 40),
        children: [
          Align(alignment: Alignment.topRight, child: Icon(Icons.settings)),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            selectedColor: Colors.red,
            leading: Icon(Icons.library_add_check_rounded),
            title: const Text("All"),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            selectedColor: Colors.red,
            leading: Icon(Icons.access_time_filled_sharp),
            title: const Text("Overdue"),
            onTap: () {
              Get.to(() => OverDueView());
            },
          ),
          ListTile(
            selectedColor: Colors.red,
            leading: Icon(Icons.hourglass_bottom),
            title: const Text("Due soon"),
            onTap: () {
              Get.to(() => DueSoonView());
            },
          ),
          ListTile(
            selectedColor: Colors.red,
            leading: Icon(Icons.check),
            title: const Text("Completed"),
            onTap: () {
              Get.to(() => CompletedReminderView());
            },
          ),
          Divider(
            thickness: 2,
            color: Colors.grey,
          ),
          ListTile(
            selectedColor: Colors.red,
            leading: Icon(Icons.add_box),
            title: const Text("Add"),
            onTap: () {
              Get.to(() => AddReminderView());
            },
          ),
          ExpansionTile(
            leading: Icon(CupertinoIcons.bell_fill),
            title: const Text("Reminders Category"),
            children: [
              Obx(
                () => _categoryController.loading.value == true
                    ? Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _categoryController.category.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: ListTile(
                                  title: Text(_categoryController
                                      .category[index]!.categoryName
                                      .toString()),
                                  onTap: () {
                                    Get.to(
                                        () => ReminderCategoryView(
                                              // id: _categoryController
                                              //     .category[index]!.id!,
                                              title: _categoryController
                                                  .category[index]!.categoryName
                                                  .toString(),
                                            ),
                                        arguments: {
                                          "id": _categoryController
                                              .category[index]!.id!
                                        });
                                  },
                                ),
                              );
                            }),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: ListTile(
                  title: Text(
                    'No Category',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Get.to(() => ReminderCategoryView(title: 'No Category'),
                        arguments: {"id": 0});
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: ListTile(
              title: Text(
                'notification',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () async {
                NotificationService.showNotification(
                    title: 'dawa',
                    body: "dfjalsdjlkasjsddf",
                    payload: 'laksksdj');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: ListTile(
              title: Text(
                'notification 1',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () async {
                NotificationService.showNotification(
                    id: 1, title: 'tsering', body: "adf", payload: 'laksksdj');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: ListTile(
                title: Text(
                  'schedule notification',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () async {
                  await NotificationService.scheduleNotification(
                      id: 1,
                      title: 'hlw',
                      body: "prashanna sir",
                      scheduledDate: tz.TZDateTime.now(tz.local)
                          .add(const Duration(seconds: 10)),
                      payload: 'laksksdj');
                }),
          ),
          MaterialButton(
            onPressed: () => Get.to(() => CategoryView()),
            color: Colors.blue,
            child: const Text(
              "Manage Category",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
