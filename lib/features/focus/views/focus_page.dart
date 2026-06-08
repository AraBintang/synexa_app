import 'package:flutter/material.dart';

import '../controllers/focus_controller.dart';

class FocusPage extends StatefulWidget {
  final FocusController focusController;

  const FocusPage({
    super.key,
    required this.focusController,
  });

  @override
  State<FocusPage> createState() => _FocusPageState();
}

class _FocusPageState extends State<FocusPage> {
  @override
  Widget build(BuildContext context) {
    widget.focusController.onTick = (_) {
      setState(() {});
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text("Focus Timer"),
      ),

      body: Center(
        child: Card(
          elevation: 5,

          child: Padding(
            padding: const EdgeInsets.all(30),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                const Icon(
                  Icons.timer,
                  size: 70,
                ),

                const SizedBox(height: 20),

                Text(
                  widget.focusController
                      .getFormattedTime(),

                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  children: [
                    ElevatedButton(
                      onPressed: () {
                        widget.focusController
                            .startTimer();
                      },

                      child: const Text(
                        "Start",
                      ),
                    ),

                    const SizedBox(width: 10),

                    ElevatedButton(
                      onPressed: () {
                        widget.focusController
                            .stopTimer();
                      },

                      child: const Text(
                        "Stop",
                      ),
                    ),

                    const SizedBox(width: 10),

                    ElevatedButton(
                      onPressed: () {
                        widget.focusController
                            .resetTimer();

                        setState(() {});
                      },

                      child: const Text(
                        "Reset",
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}