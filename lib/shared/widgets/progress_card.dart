import 'package:flutter/material.dart';

class ProgressCard extends StatelessWidget {
  final int totalTask;
  final int completedTask;
  final double progress;

  const ProgressCard({
    super.key,
    required this.totalTask,
    required this.completedTask,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              "Progress ${(progress * 100).toStringAsFixed(0)}%",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            LinearProgressIndicator(
              value: progress,
            ),

            const SizedBox(height: 15),

            Text(
              "$completedTask dari $totalTask tugas selesai",
            ),
          ],
        ),
      ),
    );
  }
}