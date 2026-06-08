import 'package:flutter/material.dart';

import '../../dashboard/widgets/summary_card.dart';
import '../../focus/controllers/focus_controller.dart';
import '../../statistics/controllers/stats_controller.dart';
import '../../task/controllers/task_controller.dart';
import '../widgets/header_card.dart';
import '../../dashboard/widgets/progress_circle.dart';

class HomePage extends StatelessWidget {
  final TaskController taskController;
  final StatsController statsController;
  final FocusController focusController;

  const HomePage({
    super.key,
    required this.taskController,
    required this.statsController,
    required this.focusController,
  });

  @override
  Widget build(BuildContext context) {
    double progress = statsController.getProgress();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Synexa"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            HeaderCard(),

            const SizedBox(
              height: 25,
            ),

            const SizedBox(height: 25),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  children: [

                    const Text(
                      "Today's Progress",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    LinearProgressIndicator(
                      value: progress,
                      minHeight: 12,
                      borderRadius: BorderRadius.circular(20),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      "${(progress * 100).toStringAsFixed(0)}%",
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [

                SummaryCard(
                  icon: Icons.task_alt,
                  title: "Task",
                  value:
                      "${taskController.getTotalTask()}",
                  color: Colors.indigo,
                ),

                const SizedBox(width: 15),

                SummaryCard(
                  icon: Icons.check_circle,
                  title: "Done",
                  value:
                      "${statsController.getCompletedTask()}",
                  color: Colors.green,
                ),
              ],
            ),

            const SizedBox(height: 20),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  children: [

                    const Icon(
                      Icons.timer,
                      size: 50,
                      color: Colors.orange,
                    ),

                    const SizedBox(height: 10),

                    Text(
                      focusController.getFormattedTime(),
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Focus Timer",
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text(
                "Tambah Task",
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.timer),
              label: const Text(
                "Start Focus",
              ),
            ),
          ],
        ),
      ),
    );
  }
}