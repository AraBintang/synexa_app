import 'package:flutter/material.dart';

import '../../dashboard/widgets/summary_card.dart';
import '../../statistics/controllers/stats_controller.dart';
import '../../task/controllers/task_controller.dart';
import '../../../models/task_model.dart';
import '../widgets/header_card.dart';

class HomePage extends StatelessWidget {
  final TaskController taskController;
  final StatsController statsController;

  const HomePage({
    super.key,
    required this.taskController,
    required this.statsController,
  });

  @override
  Widget build(BuildContext context) {
    double progress = statsController.getProgress();

    List<Task> highPriorityTasks =
        taskController.getHighPriorityTasks();

    List<Task> upcomingTasks =
        taskController.getUpcomingTasks();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Synexa"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const HeaderCard(),

            const SizedBox(height: 20),

            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20),
              ),

              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  children: [
                    const Text(
                      "Today's Progress",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    LinearProgressIndicator(
                      value: progress,
                      minHeight: 14,
                      borderRadius:
                          BorderRadius.circular(
                        20,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      "${(progress * 100).toStringAsFixed(0)}%",
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight:
                            FontWeight.bold,
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
                  title: "Total Task",
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

            const SizedBox(height: 15),

            Row(
              children: [
                SummaryCard(
                  icon: Icons.pending_actions,
                  title: "Pending",
                  value:
                      "${statsController.getPendingTask()}",
                  color: Colors.orange,
                ),

                const SizedBox(width: 15),

                SummaryCard(
                  icon:
                      Icons.warning_amber_rounded,
                  title: "Near Deadline",
                  value:
                      "${taskController.getNearDeadlineTasks().length}",
                  color: Colors.red,
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              "🔥 High Priority Task",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            if (highPriorityTasks.isEmpty)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Tidak ada tugas prioritas tinggi.",
                  ),
                ),
              )
            else
              ...highPriorityTasks.map(
                (task) => Card(
                  color: Colors.red.shade50,

                  child: ListTile(
                    leading: const Icon(
                      Icons.priority_high,
                      color: Colors.red,
                    ),

                    title: Text(task.title),

                    subtitle: Text(
                      "${task.deadline.day}/${task.deadline.month}/${task.deadline.year}",
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 30),

            const Text(
              "📅 Upcoming Task",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            if (upcomingTasks.isEmpty)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Belum ada tugas.",
                  ),
                ),
              )
            else
              Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.calendar_month,
                    color: Colors.indigo,
                  ),

                  title:
                      Text(upcomingTasks.first.title),

                  subtitle: Text(
                    "${upcomingTasks.first.deadline.day}/${upcomingTasks.first.deadline.month}/${upcomingTasks.first.deadline.year}",
                  ),
                ),
              ),

            const SizedBox(height: 30),

            const Text(
              "💡 Motivation",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Card(
              color: Colors.blue.shade50,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20),
              ),

              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Row(
                  children: [
                    const Icon(
                      Icons.lightbulb,
                      color: Colors.orange,
                      size: 35,
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: Text(
                        taskController
                            .getSuggestion(),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                onPressed: () {},

                icon: const Icon(Icons.add),

                label: const Text(
                  "Tambah Task",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}