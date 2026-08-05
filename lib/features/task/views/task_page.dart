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
  final TextEditingController titleController =
      TextEditingController();

  String selectedPriority = "Medium";

  @override
  Widget build(BuildContext context) {
    var tasks = widget.taskController.getTasks();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),

        onPressed: () async {
          titleController.clear();

          DateTime tempDate = DateTime.now();
          selectedPriority = "Medium";

          await showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setDialogState) {
                  return AlertDialog(
                    title: const Text(
                      "Tambah Tugas",
                    ),

                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: titleController,
                          decoration:
                              const InputDecoration(
                            labelText: "Nama tugas",
                          ),
                        ),

                        const SizedBox(height: 20),

                        ElevatedButton(
                          onPressed: () async {
                            DateTime? picked =
                                await showDatePicker(
                              context: context,
                              initialDate: tempDate,
                              firstDate:
                                  DateTime.now().subtract(const Duration(days: 365)),
                              lastDate:
                                  DateTime(2100),
                            );

                            if (picked != null) {
                              tempDate = picked;
                            }
                          },

                          child: const Text(
                            "Pilih Deadline",
                          ),
                        ),

                        const SizedBox(height: 20),

                        DropdownButton<String>(
                          value: selectedPriority,
                          isExpanded: true,

                          items: const [
                            DropdownMenuItem(
                              value: "High",
                              child: Text("High"),
                            ),

                            DropdownMenuItem(
                              value: "Medium",
                              child: Text("Medium"),
                            ),

                            DropdownMenuItem(
                              value: "Low",
                              child: Text("Low"),
                            ),
                          ],

                          onChanged: (value) {
                            setDialogState(() {
                              selectedPriority = value!;
                            });
                          },
                        ),
                      ],
                    ),

                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Batal",
                        ),
                      ),

                      ElevatedButton(
                        onPressed: () {
                          widget.taskController.addTask(
                            titleController.text,
                            tempDate,
                            selectedPriority,
                          );

                          setState(() {});

                          Navigator.pop(context);
                        },

                        child: const Text(
                          "Tambah",
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),

      body: ListView.builder(
        itemCount: tasks.length,

        itemBuilder: (context, index) {
          Color priorityColor;

          if (tasks[index].priority == "High") {
            priorityColor = Colors.red;
          } else if (tasks[index].priority ==
              "Medium") {
            priorityColor = Colors.orange;
          } else {
            priorityColor = Colors.green;
          }

          return Card(
            margin: const EdgeInsets.all(10),

            child: ListTile(
              leading: Checkbox(
                value: tasks[index].isDone,

                onChanged: (value) {
                  widget.taskController.toggleTask(
                    index,
                  );

                  setState(() {});
                },
              ),

              title: Text(
                tasks[index].title,
                style: TextStyle(
                  decoration: tasks[index].isDone
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),

              subtitle: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Text(
                    "Deadline : "
                    "${tasks[index].deadline.day}/"
                    "${tasks[index].deadline.month}/"
                    "${tasks[index].deadline.year}",
                  ),

                  Text(
                    "Sisa waktu : "
                    "${widget.taskController.getRemainingDays(index)} hari",
                  ),

                  Text(
                    "Priority : ${tasks[index].priority}",
                    style: TextStyle(
                      color: priorityColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  if (widget.taskController
                      .isNearDeadline(index))
                    const Text(
                      "⚠ Deadline hampir tiba!",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                  if (widget.taskController
                      .isOverdue(index))
                    const Text(
                      "❌ Deadline terlewat",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                ],
              ),

              trailing: IconButton(
                icon: const Icon(
                  Icons.delete,
                ),

                onPressed: () {
                  widget.taskController.deleteTask(
                    index,
                  );

                  setState(() {});
                },
              ),
            ),
          );
        },
      ),
    );
  }
}