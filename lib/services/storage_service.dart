import 'package:hive_flutter/hive_flutter.dart';

class StorageService {
  static late Box taskBox;
  static late Box scheduleBox;

  static Future<void> init() async {
    await Hive.initFlutter();

    taskBox = await Hive.openBox("tasks");
    scheduleBox = await Hive.openBox("schedules");
  }
}