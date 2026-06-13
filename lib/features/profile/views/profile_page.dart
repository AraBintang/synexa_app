import 'package:flutter/material.dart';

import '../../settings/views/settings_page.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../services/storage_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? _user;

  String get _displayName =>
      _user?.displayName ?? StorageService.getCurrentUserDisplayName();

  String get _email => _user?.email ?? StorageService.getCurrentUserEmail();

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    await StorageService.clearAuthSession();
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(onPressed: _logout, icon: const Icon(Icons.logout)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(radius: 60, child: Icon(Icons.person, size: 70)),
            const SizedBox(height: 20),
            Text(
              _displayName.isEmpty ? 'User' : _displayName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              _email.isEmpty ? 'Student Productivity User' : _email,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),

            Card(
              child: ListTile(
                leading: const Icon(Icons.task),
                title: const Text("Total Features"),
                subtitle: const Text("Task, Focus, Schedule, Statistics"),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.timer),
                title: const Text("Pomodoro Timer"),
                subtitle: const Text("25 Minutes Focus Mode"),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.school),
                title: const Text("Schedule Manager"),
                subtitle: const Text("Manage Lecture Schedule"),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.bar_chart),
                title: const Text("Statistics"),
                subtitle: const Text("Track Productivity Progress"),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.settings),
                title: const Text("Settings"),
                subtitle: const Text("Theme & App Options"),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SettingsPage()),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "About Synexa",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            const Text(
              "Synexa is a Smart Productivity and Activity Management application developed using Flutter. This application helps users manage tasks, focus time, and schedules in one integrated platform.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.info),
              label: const Text("Version 1.0"),
            ),
          ],
        ),
      ),
    );
  }
}
