// ignore_for_file: use_key_in_widget_constructors, unnecessary_new, prefer_final_fields, must_be_immutable, prefer_is_empty

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/app/modules/category/controllers/category_controller.dart';
import 'package:reminder_app/app/modules/category/views/category_view.dart';

import '../controllers/add_reminder_controller.dart';

class AddReminderView extends GetView<AddReminderController> {
  AddReminderController _addReminderController =
      Get.put(AddReminderController());
  CategoryController _categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          padding: const EdgeInsets.only(top: 60, left: 10, right: 10),
          children: [
            box(
              customWidget: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: TextFormField(
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      _addReminderController.buttonEnable.value = true;
                    } else {
                      _addReminderController.buttonEnable.value = false;
                    }
                  },
                  controller: _addReminderController.memoController,
                  maxLines: 7,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Memo...",
                      hintStyle: TextStyle(fontSize: 20)),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {},
              child: box(
                  customWidget: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Time",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () {
                              DatePicker.showDateTimePicker(
                                context,
                                onConfirm: (value) {
                                  _addReminderController.time.value =
                                      value.toString();
                                  _addReminderController.dateSelected.value =
                                      true;
                                },
                                showTitleActions: true,
                                minTime: DateTime.now(),
                              );
                            },
                            icon: const Icon(Icons.calendar_month)),
                      ],
                    ),
                    if (_addReminderController.dateSelected.value == true)
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Row(children: [
                          const Icon(
                            CupertinoIcons.bell_fill,
                            size: 15,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(DateFormat('EEE, d MMM  hh:mm a').format(
                              DateTime.parse(
                                  _addReminderController.time.value))),
                        ]),
                      ),
                  ],
                ),
              )),
            ),
            const SizedBox(
              height: 10,
            ),
            
            box(
                customWidget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                controller: _addReminderController.placeController,
                decoration: const InputDecoration(
                    hintText: "Add place....", border: InputBorder.none),
              ),
            )),
            const SizedBox(
              height: 10,
            ),
            box(
                customWidget: ExpansionTile(
                    key: UniqueKey(), //used to collapse the expansion tile
                    leading: const Icon(CupertinoIcons.bell_fill),
                    title: Text(_addReminderController.category.value == ""
                        ? "Reminder's Category"
                        : _addReminderController.category.value),
                    children: [
                  _categoryController.loading.value == true
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _categoryController.category.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    left: 40,
                                  ),
                                  child: ListTile(
                                    title: Text(
                                        "${_categoryController.category[index]!.categoryName}"),
                                    onTap: () {
                                      _addReminderController.category.value =
                                          "${_categoryController.category[index]!.categoryName}";
                                      _addReminderController.categoryId.value =
                                          _categoryController
                                              .category[index]!.id!;
                                    },
                                  ),
                                );
                              }),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: ListTile(
                        leading: const Icon(
                          Icons.add,
                        ),
                        title: const Text(
                          'Add Category',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap: () => Get.to(() => CategoryView())),
                  ),
                ])),
            const SizedBox(
              height: 80,
            ),
          ],
        ),
        floatingActionButton: Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                onPressed: () => Get.back(),
                child: const Text(
                  "Cancel",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              MaterialButton(
                onPressed: _addReminderController.buttonEnable.value == false
                    ? null //it makes button unpressable
                    : () async {
                        await _addReminderController.addReminder();
                        Get.back();
                      },
                child: const Text(
                  "Save",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget box({required Widget customWidget}) {
    return Container(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.grey, blurRadius: 1),
        ],
      ),
      child: customWidget,
    );
  }
}
