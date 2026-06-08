import '../../task/controllers/task_controller.dart';

class StatsController {
  final TaskController taskController;

  StatsController(this.taskController);

  int getTotalTask() {
    return taskController.getTotalTask();
  }

  int getCompletedTask() {
    return taskController.getCompletedTask();
  }

  int getPendingTask() {
    return getTotalTask() - getCompletedTask();
  }

  double getProgress() {
    if (getTotalTask() == 0) {
      return 0;
    }

    return getCompletedTask() / getTotalTask();
  }
}