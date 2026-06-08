import 'package:flutter/material.dart';

import 'features/home/views/home_page.dart';
import 'features/task/views/task_page.dart';
import 'features/statistics/views/statistics_page.dart';
import 'features/focus/views/focus_page.dart';
import 'features/schedule/views/schedule_page.dart';
import 'features/profile/views/profile_page.dart';
import 'features/settings/views/settings_page.dart';

import 'features/task/controllers/task_controller.dart';
import 'features/statistics/controllers/stats_controller.dart';
import 'features/focus/controllers/focus_controller.dart';
import 'features/schedule/controllers/schedule_controller.dart';
import 'services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await StorageService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Synexa",
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  final TaskController taskController = TaskController();

  late final StatsController statsController =
      StatsController(taskController);

  final FocusController focusController =
      FocusController();

  final ScheduleController scheduleController =
      ScheduleController();

  late final List<Widget> pages = [
    HomePage(
      taskController: taskController,
      statsController: statsController,
      focusController: focusController,
    ),

    TaskPage(
      taskController: taskController,
    ),

    StatisticsPage(
      statsController: statsController,
    ),

    FocusPage(
      focusController: focusController,
    ),

    SchedulePage(
      scheduleController: scheduleController,
    ),

    const ProfilePage(),

    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: "Task",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Stats",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: "Focus",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: "Schedule",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}