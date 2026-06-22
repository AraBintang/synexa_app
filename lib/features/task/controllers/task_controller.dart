import '../../../models/task_model.dart';
import '../../../services/storage_service.dart';

class TaskController {
  final List<Task> _tasks = [];

  TaskController() {
    loadTasks();
  }

  List<Task> getTasks() {
    return _tasks;
  }

  void addTask(
    String title,
    DateTime deadline,
    String priority,
  ) {
    if (title.trim().isEmpty) return;

    _tasks.add(
      Task(
        title: title,
        deadline: deadline,
        priority: priority,
      ),
    );

    StorageService.taskBox.add({
      "title": title,
      "deadline": deadline.toIso8601String(),
      "isDone": false,
      "priority": priority,
    });
  }

  void deleteTask(int index) {
    StorageService.taskBox.deleteAt(index);
    _tasks.removeAt(index);
  }

  void toggleTask(int index) {
    _tasks[index].isDone = !_tasks[index].isDone;

    StorageService.taskBox.putAt(
      index,
      {
        "title": _tasks[index].title,
        "deadline":
            _tasks[index].deadline.toIso8601String(),
        "isDone": _tasks[index].isDone,
        "priority": _tasks[index].priority,
      },
    );
  }

  void editTask(
    int index,
    String title,
    DateTime deadline,
    String priority,
  ) {
    _tasks[index].title = title;
    _tasks[index].deadline = deadline;
    _tasks[index].priority = priority;

    StorageService.taskBox.putAt(
      index,
      {
        "title": title,
        "deadline": deadline.toIso8601String(),
        "isDone": _tasks[index].isDone,
        "priority": priority,
      },
    );
  }

  int getTotalTask() {
    return _tasks.length;
  }

  int getCompletedTask() {
    return _tasks.where((task) => task.isDone).length;
  }

  int getPendingTask() {
    return _tasks.where((task) => !task.isDone).length;
  }

  String getSuggestion() {
    int pending =
        _tasks.where((task) => !task.isDone).length;

    if (_tasks.isEmpty) {
      return "Belum ada tugas.";
    }

    if (pending > 5) {
      return "Tugas masih banyak, ayo selesaikan satu per satu.";
    }

    if (pending == 0) {
      return "Semua tugas selesai. Kerja bagus!";
    }

    return "Tetap semangat dan produktif!";
  }

  void loadTasks() {
    _tasks.clear();

    for (var item in StorageService.taskBox.values) {
      _tasks.add(
        Task(
          title: item["title"],

          deadline: item["deadline"] != null
              ? DateTime.parse(item["deadline"])
              : DateTime.now(),

          isDone: item["isDone"] ?? false,

          priority: item["priority"] ?? "Medium",
        ),
      );
    }
  }

  int getRemainingDays(int index) {
    Duration difference =
        _tasks[index].deadline.difference(
      DateTime.now(),
    );

    return difference.inHours ~/ 24;
  }

  bool isNearDeadline(int index) {
    int days = getRemainingDays(index);

    return days >= 0 &&
        days <= 1 &&
        !_tasks[index].isDone;
  }

  bool isOverdue(int index) {
    return getRemainingDays(index) < 0 &&
        !_tasks[index].isDone;
  }

  List<Task> getPendingTasks() {
    return _tasks
        .where((task) => !task.isDone)
        .toList();
  }

  List<Task> getNearDeadlineTasks() {
    return _tasks.where((task) {
      Duration difference =
          task.deadline.difference(
        DateTime.now(),
      );

      int days = difference.inHours ~/ 24;

      return days >= 0 &&
          days <= 1 &&
          !task.isDone;
    }).toList();
  }

  List<Task> getHighPriorityTasks() {
  return _tasks.where((task) {
    return task.priority == "High" &&
        !task.isDone;
  }).toList();
}

List<Task> getUpcomingTasks() {
  List<Task> pendingTasks =
      _tasks.where((task) => !task.isDone).toList();

  pendingTasks.sort(
    (a, b) => a.deadline.compareTo(b.deadline),
  );

  return pendingTasks;
}
}