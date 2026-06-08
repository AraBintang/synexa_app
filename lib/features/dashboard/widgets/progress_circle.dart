import 'package:flutter/material.dart';

class ProgressCircle extends StatelessWidget {
  final double progress;

  const ProgressCircle({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 130,

      child: Stack(
        fit: StackFit.expand,

        children: [

          CircularProgressIndicator(
            value: progress,
            strokeWidth: 10,
            backgroundColor: Colors.grey.shade300,
          ),

          Center(
            child: Text(
              "${(progress * 100).toStringAsFixed(0)}%",
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}