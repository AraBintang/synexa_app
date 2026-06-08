import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            const CircleAvatar(
              radius: 60,
              child: Icon(
                Icons.person,
                size: 70,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Ara Bintang",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Student Productivity User",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
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

            const SizedBox(height: 30),

            const Text(
              "About Synexa",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              "Synexa is a Smart Productivity and Activity Management application developed using Flutter. This application helps users manage tasks, focus time, and schedules in one integrated platform.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
              ),
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