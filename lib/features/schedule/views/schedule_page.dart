import 'package:flutter/material.dart';

import '../controllers/schedule_controller.dart';

class SchedulePage extends StatefulWidget {
  final ScheduleController scheduleController;

  const SchedulePage({
    super.key,
    required this.scheduleController,
  });

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final TextEditingController subjectController =
      TextEditingController();

  final TextEditingController dayController =
      TextEditingController();

  final TextEditingController timeController =
      TextEditingController();

  @override
  void dispose() {
    subjectController.dispose();
    dayController.dispose();
    timeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final schedules =
        widget.scheduleController.getSchedules();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Schedule",
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(15),

        child: Column(
          children: [
            TextField(
              controller: subjectController,
              decoration: const InputDecoration(
                labelText: "Mata Kuliah",
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: dayController,
              decoration: const InputDecoration(
                labelText: "Hari",
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: timeController,
              decoration: const InputDecoration(
                labelText: "Jam",
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: () {
                  widget.scheduleController.addSchedule(
                    subjectController.text,
                    dayController.text,
                    timeController.text,
                  );

                  subjectController.clear();
                  dayController.clear();
                  timeController.clear();

                  setState(() {});
                },

                child: const Text(
                  "Tambah Jadwal",
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: schedules.isEmpty
                  ? const Center(
                      child: Text(
                        "Belum ada jadwal",
                      ),
                    )
                  : ListView.builder(
                      itemCount: schedules.length,

                      itemBuilder: (context, index) {
                        final schedule =
                            schedules[index];

                        return Card(
                          child: ListTile(
                            leading: const Icon(
                              Icons.schedule,
                            ),

                            title: Text(
                              schedule.subject,
                            ),

                            subtitle: Text(
                              "${schedule.day} • ${schedule.time}",
                            ),

                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                              ),

                              onPressed: () {
                                widget.scheduleController
                                    .deleteSchedule(
                                        index);

                                setState(() {});
                              },
                            ),
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}