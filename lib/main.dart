import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'features/home/views/home_page.dart';
import 'features/task/views/task_page.dart';
import 'features/statistics/views/statistics_page.dart';
import 'features/schedule/views/schedule_page.dart';
import 'features/profile/views/profile_page.dart';

import 'features/task/controllers/task_controller.dart';
import 'features/statistics/controllers/stats_controller.dart';
import 'features/schedule/controllers/schedule_controller.dart';
import 'features/auth/views/login_page.dart';
import 'features/auth/views/register_page.dart';
import 'features/auth/views/success_page.dart';
import 'services/storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await StorageService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Synexa',
      routes: {
        '/login': (_) => const LoginPage(),
        '/register': (_) => const RegisterPage(),
        '/auth_success': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          final message = (args as Map?)?['message'] as String? ?? 'Berhasil';
          return SuccessPage(message: message);
        },
        '/main': (_) => const MainPage(),
      },
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    super.initState();
    _decide();
  }

  Future<void> _decide() async {
    final isLoggedIn = await StorageService.getIsLoggedIn();
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(isLoggedIn ? '/main' : '/login');
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
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
  late final StatsController statsController = StatsController(taskController);
  final ScheduleController scheduleController = ScheduleController();

  late final List<Widget> pages = [
    HomePage(taskController: taskController, statsController: statsController),
    TaskPage(taskController: taskController),
    StatisticsPage(statsController: statsController),
    SchedulePage(scheduleController: scheduleController),
    const ProfilePage(),
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Task'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stats'),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
