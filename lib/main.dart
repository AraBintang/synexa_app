import 'package:flutter/material.dart';
import 'package:synexa_app/features/task/controllers/task_controller.dart';
import 'package:synexa_app/features/statistics/controllers/stats_controller.dart';
import 'package:synexa_app/features/focus/controllers/focus_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TaskController taskController = TaskController();
  late final StatsController statsController =
      StatsController(taskController);
  final FocusController focusController = FocusController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Synexa',
      home: HomePage(
        taskController: taskController,
        statsController: statsController,
        focusController: focusController,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
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
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController inputController = TextEditingController();

  void refresh() {
    setState(() {});
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tasks = widget.taskController.getTasks();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Synexa"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // INPUT
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: inputController,
                    decoration: const InputDecoration(
                      hintText: "Tambah tugas...",
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    widget.taskController.addTask(inputController.text);
                    inputController.clear();
                    refresh();
                  },
                )
              ],
            ),

            const SizedBox(height: 20),

            // STATS
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Progress: ${(widget.statsController.getProgress() * 100).toStringAsFixed(0)}%",
                ),
                Text(widget.taskController.getSuggestion()),
              ],
            ),

            const SizedBox(height: 20),

            // LIST TASK
            Expanded(
              child: tasks.isEmpty
                  ? const Center(child: Text("Belum ada tugas"))
                  : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];

                        return ListTile(
                          title: Text(
                            task.title,
                            style: TextStyle(
                              decoration: task.isDone
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          leading: Checkbox(
                            value: task.isDone,
                            onChanged: (_) {
                              widget.taskController.toggleTask(index);
                              refresh();
                            },
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              widget.taskController.deleteTask(index);
                              refresh();
                            },
                          ),
                        );
                      },
                    ),
            ),

            // TIMER
            Column(
              children: [
                Text(
                  widget.focusController.getFormattedTime(),
                  style: const TextStyle(fontSize: 24),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        widget.focusController.onTick = (_) {
                          setState(() {});
                        };
                        widget.focusController.startTimer();
                      },
                      child: const Text("Start"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        widget.focusController.resetTimer();
                        setState(() {});
                      },
                      child: const Text("Reset"),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}