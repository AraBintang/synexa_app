import 'package:hive_flutter/hive_flutter.dart';

class StorageService {
  static late Box taskBox;
  static late Box scheduleBox;

  static late Box settingsBox;
  static late Box usersBox;

  static Future<void> init() async {
    await Hive.initFlutter();

    taskBox = await Hive.openBox("tasks");
    scheduleBox = await Hive.openBox("schedules");

    settingsBox = await Hive.openBox("settings");
    usersBox = await Hive.openBox("users");
  }

  static Future<void> setAuthSession({
    required bool isLoggedIn,
    required String email,
    required String displayName,
  }) async {
    await settingsBox.put('isLoggedIn', isLoggedIn);
    await settingsBox.put('currentUserEmail', email);
    await settingsBox.put('currentUserDisplayName', displayName);
  }

  static Future<bool> getIsLoggedIn() async {
    return (settingsBox.get('isLoggedIn', defaultValue: false) as bool);
  }

  static String getCurrentUserEmail() {
    return settingsBox.get('currentUserEmail', defaultValue: '') as String;
  }

  static String getCurrentUserDisplayName() {
    return settingsBox.get('currentUserDisplayName', defaultValue: '')
        as String;
  }

  static Future<void> clearAuthSession() async {
    await settingsBox.put('isLoggedIn', false);
    await settingsBox.delete('currentUserEmail');
    await settingsBox.delete('currentUserDisplayName');
  }
}
