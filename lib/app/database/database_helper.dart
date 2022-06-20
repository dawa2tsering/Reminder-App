import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:reminder_app/app/model/category.dart';
import 'package:reminder_app/app/model/reminder.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  // final save = StreamController<BookmarkDatabase>();
  static AppDatabase appDatabase = AppDatabase._privateConstructor();
  AppDatabase._privateConstructor();

  Database? _database;
  static const String categoryTable = 'Category';
  static const String reminderTable = 'Reminder';

  static const String columnCategoryId = 'id';
  static const String columnCategoryName = 'category_name';

  static const String columnReminderId = 'id';
  static const String columnMemo = 'memo';
  static const String columnTime = 'time';
  static const String columnPlace = 'place';
  static const String columnStatus = 'status';
  static const String columnCategory = 'category';

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'reminder.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      log("============Creating Category table=========");
      await db.execute("CREATE TABLE $categoryTable("
          "$columnCategoryId INTEGER PRIMARY KEY ASC,"
          "$columnCategoryName TEXT NOT NULL)");

      log("============Creating Reminder table=========");
      await db.execute("CREATE TABLE $reminderTable("
          "$columnReminderId INTEGER PRIMARY KEY ASC,"
          "$columnMemo TEXT NOT NULL,"
          "$columnTime TEXT,"
          "$columnPlace TEXT,"
          "$columnStatus TEXT,"
          "$columnCategory INTEGER NOT NULL)");
    });
  }

  List<Category?> categoryList = [];
  List<Reminder?> allReminder = [];
  List<Reminder?> reminderList = [];
  List<Reminder?> reminderListById = [];
  List<Reminder?> completeReminderList = [];
  List<Reminder?> reminderCategoryList = [];

///////////////////Category////////////////////////////////////////////////////
  ///inserting map categories in catergoryTable
  Future<int?> insertCategory(Map<String, dynamic> categories) async {
    final db = await database;
    log("database ===== ${db.toString()}");
    return await db?.insert(
      categoryTable,
      categories,
    );
  }

  //get category data as Category model fromJson as reference
  Future<List<Category?>> queryCategory() async {
    final db = await database;
    var category = await db!.query(categoryTable, distinct: true);
    categoryList = category.isNotEmpty
        ? category.map((e) => Category?.fromJson(e)).toList()
        : [];
    log("queried");
    return [...categoryList];
  }

  //delete category table
  deleteAllCategory() async {
    final db = await database;
    db?.delete(categoryTable);
  }

  //delete category row based on id
  Future<int?> deleteCategory(int? id) async {
    final db = await database;
    return await db!.delete(categoryTable,
        where: '$columnCategoryId IN (?)', whereArgs: [id]);
  }

///////////////////Reminder////////////////////////////////////////////////////

  //insert reminder map in the reminderTable
  Future<int?> insertReminder(Map<String, dynamic> reminders) async {
    final db = await database;
    log("database ===== ${db.toString()}");
    return await db?.insert(
      reminderTable,
      reminders,
    );
  }

  //get all reminder
  Future<List<Reminder?>> queryAllReminder() async {
    final db = await database;
    var reminder = await db!.query(reminderTable);
    allReminder = reminder.isNotEmpty
        ? reminder.map((e) => Reminder?.fromJson(e)).toList()
        : [];
    log("queried");
    return [...allReminder];
  }

  //get reminder based on columnStatus which has argument status
  Future<List<Reminder?>> queryReminder({String? status}) async {
    final db = await database;
    var reminder = await db!.query(reminderTable,
        where: '$columnStatus IN (?)', whereArgs: [status]);
    reminderList = reminder.isNotEmpty
        ? reminder.map((e) => Reminder?.fromJson(e)).toList()
        : [];
    log("queried");
    return [...reminderList];
  }

  //get reminder based on columnStatus which has argument status
  Future<List<Reminder?>> queryReminderById({int? id}) async {
    final db = await database;
    var reminder = await db!.query(reminderTable,
        where: '$columnReminderId IN (?)', whereArgs: [id]);
    reminderListById = reminder.isNotEmpty
        ? reminder.map((e) => Reminder?.fromJson(e)).toList()
        : [];
    log("queried");
    return [
      ...reminderListById
    ]; //returning reminderListById inside the empty list []
  }

  //update reminder row based on id which has Reminder toJson as reference body
  Future<int?> updateReminder(
      {required Map<String, dynamic> reminder, int? id}) async {
    final db = await database;
    return await db!.update(reminderTable, reminder,
        where: '$columnReminderId IN (?)', whereArgs: [id]);
  }

  //update columnStatus with status argument based on id
  Future<int?> updateReminderStatus({String? status, int? id}) async {
    final db = await database;
    return await db!.rawUpdate(
        'UPDATE $reminderTable SET $columnStatus = ? WHERE id = ?',
        [status, id]);
  }

  //delete reminder based on id
  Future<int?> deleteReminder({int? id}) async {
    final db = await database;
    log("delete reminder successfully");
    return await db!.delete(reminderTable,
        where: '$columnReminderId IN (?)', whereArgs: [id]);
  }

/////////////////////////Reminder by Category///////////////////////////////////////////
  ///get reminder by cloumStatus and columnCategory based on "incomplete" status and id
  Future<List<Reminder?>> queryReminderByCategory(
      {required int categoryId}) async {
    final db = await database;
    var reminderCategory = await db!.query(reminderTable,
        where: '$columnStatus IN (?) and $columnCategory IN (?)',
        whereArgs: ["incomplete", categoryId]);
    reminderCategoryList = reminderCategory.isNotEmpty
        ? reminderCategory.map((e) => Reminder?.fromJson(e)).toList()
        : [];
    log("queried");
    return [...reminderCategoryList];
  }
}
