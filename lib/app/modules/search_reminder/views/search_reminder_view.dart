// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:reminder_app/app/modules/reminder_detail/views/reminder_detail_view.dart';
import 'package:reminder_app/app/widgets/reminder_detail.dart';

import '../controllers/search_reminder_controller.dart';

class SearchReminderView extends GetView<SearchReminderController> {
  final _searchReminderController = Get.put(SearchReminderController());
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: TextFormField(
            autofocus: true,
            controller: searchController,
            onChanged: (value) {
              if (value.isNotEmpty) {
                _searchReminderController.textListener.value = true;

                _searchReminderController.runFilter(value);
              } else {
                _searchReminderController.textListener.value = false;
              }
            },
            style: const TextStyle(color: Colors.white, fontSize: 18),
            cursorColor: Colors.white,
            decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: ' Search...',
                hintStyle: TextStyle(color: Colors.white)),
          ),
          actions: [
            _searchReminderController.textListener.value
                ? IconButton(
                    onPressed: () {
                      _searchReminderController.textListener.value = false;
                      _searchReminderController
                          .runFilter(searchController.text);
                      _searchReminderController.searchListener.value = true;
                    },
                    icon: const Icon(CupertinoIcons.search))
                : _searchReminderController.searchListener.value == false
                    ? const SizedBox()
                    : IconButton(
                        onPressed: () {
                          _searchReminderController.searchListener.value =
                              false;
                          searchController.clear();
                        },
                        icon: const Icon(CupertinoIcons.multiply)),
          ],
        ),
        body: _searchReminderController.foundReminder.isNotEmpty
            ? ListView.builder(
                itemCount: _searchReminderController.foundReminder.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListTile(
                      title: Text(_searchReminderController
                          .foundReminder[index]!.memo
                          .toString()),
                      onTap: () {
                        Get.to(() => ReminderDetailView(),
                            arguments: {
                              "id": _searchReminderController
                                  .foundReminder[index]!.id,
                            },
                            popGesture: true);
                      },
                    ),
                  );
                })
            : const Center(child: Text('No results found')),
      ),
    );
  }
}
