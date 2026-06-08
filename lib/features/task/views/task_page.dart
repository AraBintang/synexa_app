import 'package:flutter/material.dart';

import '../controllers/task_controller.dart';

class TaskPage extends StatefulWidget {
  final TaskController taskController;

  const TaskPage({
    super.key,
    required this.taskController,
  });

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final TextEditingController inputController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final tasks = widget.taskController.getTasks();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Manager"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(15),

        child: Column(
          children: [

            TextField(
              controller: inputController,

              decoration: const InputDecoration(
                labelText: "Tambah tugas",
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {

                widget.taskController
                    .addTask(inputController.text);

                inputController.clear();

                setState(() {});
              },

              child: const Text(
                "Tambah Task",
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,

                itemBuilder: (context, index) {

                  return ListTile(
                    title: Text(
                      tasks[index].title,
                    ),

                    leading: Checkbox(
                      value: tasks[index].isDone,

                      onChanged: (_) {

                        widget.taskController
                            .toggleTask(index);

                        setState(() {});
                      },
                    ),

                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                      ),

                      onPressed: () {

                        widget.taskController
                            .deleteTask(index);

                        setState(() {});
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}