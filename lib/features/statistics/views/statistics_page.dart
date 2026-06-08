import 'package:flutter/material.dart';

import '../controllers/stats_controller.dart';

class StatisticsPage extends StatelessWidget {
  final StatsController statsController;

  const StatisticsPage({
    super.key,
    required this.statsController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Statistics"),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [
            Text(
              "Total Task : ${statsController.getTotalTask()}",
            ),

            Text(
              "Completed : ${statsController.getCompletedTask()}",
            ),

            Text(
              "Pending : ${statsController.getPendingTask()}",
            ),

            Text(
              "Progress : ${(statsController.getProgress() * 100).toStringAsFixed(0)}%",
            ),
          ],
        ),
      ),
    );
  }
}