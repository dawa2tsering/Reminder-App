// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:reminder_app/app/widgets/custom_dialogue.dart';

import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  final _categoryController = Get.put(CategoryController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: _categoryController.editOnpressed.value == true
              ? const Icon(Icons.delete)
              : IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Get.back(),
                ),
          title: Text(
            _categoryController.editOnpressed.value == true
                ? "Delete"
                : 'Category',
          ),
          actions: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      _categoryController.editOnpressed.value == false
                          ? _categoryController.editOnpressed.value = true
                          : _categoryController.editOnpressed.value = false;
                    },
                    icon: _categoryController.editOnpressed.value == true
                        ? const Icon(CupertinoIcons.multiply)
                        : const Text(
                            'Edit',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
              ],
            )
          ],
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                          return Column(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.circle),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "${_categoryController.category[index]!.categoryName}"),
                                  ],
                                ),
                                trailing: _categoryController
                                            .editOnpressed.value ==
                                        false
                                    ? const SizedBox()
                                    : IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return CustomDialogue(
                                                  title: "Delete",
                                                  content:
                                                      "Do you want to Delete Category?",
                                                  btnText1: "Yes",
                                                  onPressed1: () async {
                                                    await _categoryController
                                                        .deleteCategoryById(
                                                            id: _categoryController
                                                                .category[
                                                                    index]!
                                                                .id);
                                                    Navigator.of(context).pop();
                                                  },
                                                  btnText2: "No",
                                                  onPressed2: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                );
                                                //return confirmAllDelete(context);
                                              });
                                        },
                                      ),
                              ),
                              const Divider(
                                thickness: 1,
                              ),
                            ],
                          );
                        }),
                  ),
            ListTile(
              onTap: () {
                showDialog(
                  // ignore: prefer_equal_for_default_values
                  context: context,
                  builder: (BuildContext context) {
                    return addReminder(context);
                  },
                );
                _categoryController.editOnpressed.value = false;
              },
              leading: const Icon(Icons.add),
              title: const Text(
                'Add Category',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
        floatingActionButton: _categoryController.editOnpressed.value == false
            ? const SizedBox()
            : Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: SizedBox(
                    height: 70,
                    child: Column(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialogue(
                                    title: "Delete",
                                    content:
                                        "Do you want to Delete All the Categories?",
                                    btnText1: "Yes",
                                    onPressed1: () async {
                                      await _categoryController
                                          .deleteAllCategory();
                                      Navigator.of(context).pop();
                                      _categoryController.editOnpressed.value =
                                          false;
                                    },
                                    btnText2: "No",
                                    onPressed2: () {
                                      Navigator.of(context).pop();
                                      _categoryController.editOnpressed.value =
                                          false;
                                    },
                                  );
                                  //return confirmAllDelete(context);
                                });
                          },
                        ),
                        const Text(
                          'Delete All',
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget addReminder(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Category"),
      content: TextFormField(
        autofocus: true,
        controller: _categoryController.categoryController,
        decoration: const InputDecoration(
            border: InputBorder.none, hintText: " Category..."),
      ),
      actions: [
        Center(
          child: TextButton(
              onPressed: () async {
                await _categoryController.addCategory(
                    category: _categoryController.categoryController.text);
                Navigator.of(context).pop();
                _categoryController.categoryController.clear();
              },
              child: const Text("Add")),
        ),
      ],
    );
  }
}
