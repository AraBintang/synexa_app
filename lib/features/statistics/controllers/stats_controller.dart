import '../../task/controllers/task_controller.dart';

class StatsController {
  final TaskController taskController;

  StatsController(this.taskController);

  int getTotalTask() {
    return taskController.getTasks().length;
  }

  int getCompletedTask() {
    return taskController
        .getTasks()
        .where((task) => task.isDone)
        .length;
  }

  int getPendingTask() {
    return taskController
        .getTasks()
        .where((task) => !task.isDone)
        .length;
  }

  double getProgress() {
    if (getTotalTask() == 0) return 0;
    return getCompletedTask() / getTotalTask();
  }
}