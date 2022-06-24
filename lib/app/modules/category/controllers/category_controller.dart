// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder_app/app/database/database_helper.dart';
import 'package:reminder_app/app/locator.dart/locator.dart';
import 'package:reminder_app/app/model/category.dart';

class CategoryController extends GetxController {

  var editOnpressed = false.obs;
  TextEditingController categoryController = TextEditingController();
  List<Category?> category = RxList();
  RxBool loading = false.obs;
  List selectedCategory = RxList();
  
  @override
  void onInit() {
    getCategory();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  addCategory({String? category}) async {
    await locator<AppDatabase>().insertCategory({
      "category_name": category,
    });
    getCategory();
  }

  Future<void> getCategory() async {
    loading.value = true;
    category = await locator<AppDatabase>().queryCategory();
    loading.value = false;
  }

  deleteAllCategory() async {
    await locator<AppDatabase>().deleteAllCategory();
    getCategory();
  }

  deleteCategoryById({id}) async {
    await locator<AppDatabase>().deleteCategory(id);
    getCategory();
  }

  @override
  void onClose() {}
}
