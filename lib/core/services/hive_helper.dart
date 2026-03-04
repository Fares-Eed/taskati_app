import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:taskati_app/core/models/task_model.dart';
//we will use two opject to all of the app

class HiveHelper {
  // boxes
  static late Box userBox;
  static late Box<TaskModel> tasksBox;

  // box names
  static const String userBoxName = 'user';
  static const String tasksBoxName = 'tasks';

  // keys
  static const String nameKey = 'name';
  static const String imageKey = 'image';
  static const String isUploadedKey = 'isUploaded';

  static Future<void> init() async {
    userBox = await Hive.openBox(userBoxName);
    tasksBox = await Hive.openBox<TaskModel>(tasksBoxName);
  }

  // we want to call the init method before use the helper methods
  // so we will call it in main func. before the runApp Func.

  // user box methods
  static Future<void> setUserInfo(String name, String image) async {
    await userBox.put(nameKey, name);
    await userBox.put(imageKey, image);
  }

  static dynamic cacheData(String key, dynamic value) {
    return userBox.put(key, value);
  }

  static dynamic getCachedData(String key) {
    return userBox.get(key);
  }

  // tasks box methods
  static dynamic cacheTask(String key, TaskModel value) {
    return tasksBox.put(key, value);
  }

  static TaskModel? getCachedTask(String key) {
    return tasksBox.get(key);
  }

  static void deleteTask(String key) {
    tasksBox.delete(key);
  }
}
















