import '../../../models/task_model.dart';
import '../../../services/storage_service.dart';

class TaskController {
  List<Task> _tasks = [];

  TaskController() {
  loadTasks();
}

  List<Task> getTasks() {
    return _tasks;
  }

  void addTask(String title) {
    if (title.trim().isEmpty) return;

    _tasks.add(
      Task(
      title: title,
    ),
  );

  StorageService.taskBox.add({
    "title": title,
    "isDone": false,
  });
}

  void deleteTask(int index) {
  StorageService.taskBox.deleteAt(index);

  _tasks.removeAt(index);
}

  void toggleTask(int index) {

  _tasks[index].isDone =
      !_tasks[index].isDone;

  StorageService.taskBox.putAt(
    index,
    {
      "title": _tasks[index].title,
      "isDone": _tasks[index].isDone,
    },
  );
}

  int getTotalTask() {
    return _tasks.length;
  }

  int getCompletedTask() {
    return _tasks.where((task) => task.isDone).length;
  }

  String getSuggestion() {
    int pending = _tasks.where((task) => !task.isDone).length;

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
  _tasks = [];

  for (var item in StorageService.taskBox.values) {
    _tasks.add(
      Task(
        title: item["title"],
        isDone: item["isDone"],
      ),
    );
  }
}
}