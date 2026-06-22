class Task {
  String title;
  DateTime deadline;
  bool isDone;
  String priority;

  Task({
    required this.title,
    required this.deadline,
    this.isDone = false,
    this.priority = "Medium",
  });
}