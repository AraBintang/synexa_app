import '../../../models/schedule_model.dart';
import '../../../services/storage_service.dart';

class ScheduleController {
  final List<Schedule> _schedules = [];

ScheduleController() {
  loadSchedules();
}

  void addSchedule(
  String subject,
  String day,
  String time,
) {

  _schedules.add(
    Schedule(
      subject: subject,
      day: day,
      time: time,
    ),
  );

  StorageService.scheduleBox.add({
    "subject": subject,
    "day": day,
    "time": time,
  });
}

  void deleteSchedule(int index) {

  StorageService.scheduleBox.deleteAt(index);

  _schedules.removeAt(index);
}

void loadSchedules() {
  _schedules.clear();

  for (var item in StorageService.scheduleBox.values) {
    _schedules.add(
      Schedule(
        subject: item["subject"],
        day: item["day"],
        time: item["time"],
      ),
    );
  }
}

List<Schedule> getSchedules() {
  return _schedules;
}
}