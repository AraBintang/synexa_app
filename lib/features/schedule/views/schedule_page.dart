import 'package:flutter/material.dart';

import '../controllers/schedule_controller.dart';

class SchedulePage extends StatefulWidget {
  final ScheduleController scheduleController;

  const SchedulePage({super.key, required this.scheduleController});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController dayController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  bool _showForm = false;

  final List<String> _days = const [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu',
  ];

  @override
  void dispose() {
    subjectController.dispose();
    dayController.dispose();
    timeController.dispose();

    super.dispose();
  }

  void _resetForm() {
    subjectController.clear();
    dayController.clear();
    timeController.clear();
  }

  void _handleSave() {
    if (subjectController.text.isNotEmpty &&
        dayController.text.isNotEmpty &&
        timeController.text.isNotEmpty) {
      widget.scheduleController.addSchedule(
        subjectController.text,
        dayController.text,
        timeController.text,
      );

      _resetForm();
      setState(() {
        _showForm = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Jadwal ditambahkan")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final schedules = widget.scheduleController.getSchedules();

    return Scaffold(
      appBar: AppBar(title: const Text("Schedule")),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            // Daftar jadwal (di atas tombol)
            Expanded(
              child: schedules.isEmpty
                  ? const Center(child: Text("Belum ada jadwal"))
                  : ListView.builder(
                      itemCount: schedules.length,
                      itemBuilder: (context, index) {
                        final schedule = schedules[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            leading: const Icon(
                              Icons.alarm,
                              color: Colors.blue,
                            ),
                            title: Text(
                              schedule.subject,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              "${schedule.day} • ${schedule.time}",
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                widget.scheduleController.deleteSchedule(index);
                                setState(() {});
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),

            const SizedBox(height: 20),

            // Jika form tidak tampil, tampilkan tombol tambah jadwal
            if (!_showForm)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: () {
                    setState(() {
                      _showForm = true;
                    });
                  },
                  child: const Text("Tambah Jadwal"),
                ),
              )
            else ...[
              // Form kegiatan, hari, jam
              TextField(
                controller: subjectController,
                decoration: const InputDecoration(
                  labelText: "Kegiatan",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Pilih Hari",
                  border: OutlineInputBorder(),
                ),
                items: _days
                    .map(
                      (day) => DropdownMenuItem(value: day, child: Text(day)),
                    )
                    .toList(),
                onChanged: (value) => dayController.text = value ?? "",
              ),

              const SizedBox(height: 10),

              TextField(
                controller: timeController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: "Pilih Jam",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.access_time),
                ),
                onTap: () async {
                  final pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  if (pickedTime != null) {
                    setState(() {
                      timeController.text = pickedTime.format(context);
                    });
                  }
                },
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: _handleSave,
                  child: const Text("Simpan"),
                ),
              ),

              const SizedBox(height: 10),

              TextButton(
                onPressed: () {
                  _resetForm();
                  setState(() {
                    _showForm = false;
                  });
                },
                child: const Text("Batal"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
