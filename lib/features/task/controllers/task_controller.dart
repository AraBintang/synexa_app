class Task {
  String title;
  bool isDone;

  Task({required this.title, this.isDone = false});
}

class TaskController {
  List<Task> _tasks = [];

  // Ambil semua task
  List<Task> getTasks() {
    return _tasks;
  }

  // Tambah task
  void addTask(String title) {
    if (title.isEmpty) return;
    _tasks.add(Task(title: title));
  }

  // Hapus task
  void deleteTask(int index) {
    if (index < 0 || index >= _tasks.length) return;
    _tasks.removeAt(index);
  }

  // Toggle selesai / belum
  void toggleTask(int index) {
    if (index < 0 || index >= _tasks.length) return;
    _tasks[index].isDone = !_tasks[index].isDone;
  }

  // Progress (0 - 1)
  double getProgress() {
    if (_tasks.isEmpty) return 0;
    int done = _tasks.where((t) => t.isDone).length;
    return done / _tasks.length;
  }

  // Total task
  int getTotalTask() {
    return _tasks.length;
  }

  // Task selesai
  int getCompletedTask() {
    return _tasks.where((t) => t.isDone).length;
  }

  // Suggestion (biar keliatan smart 😄)
  String getSuggestion() {
    int pending = _tasks.where((t) => !t.isDone).length;

    if (pending > 5) {
      return "Tugas kamu banyak banget, coba selesaikan satu-satu ya!";
    } else if (pending == 0 && _tasks.isNotEmpty) {
      return "Keren! Semua tugas selesai!";
    } else if (_tasks.isEmpty) {
      return "Belum ada tugas, yuk mulai produktif!";
    } else {
      return "Tetap semangat, kamu pasti bisa!";
    }
  }
}