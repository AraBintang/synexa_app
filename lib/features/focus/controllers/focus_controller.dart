import 'dart:async';

class FocusController {
  int time = 1500;

  Timer? _timer;

  Function(int)? onTick;

  void startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (time > 0) {
          time--;

          if (onTick != null) {
            onTick!(time);
          }
        } else {
          timer.cancel();
        }
      },
    );
  }

  void stopTimer() {
    _timer?.cancel();
  }

  void resetTimer() {
    _timer?.cancel();

    time = 1500;

    if (onTick != null) {
      onTick!(time);
    }
  }

  String getFormattedTime() {
    int minutes = time ~/ 60;
    int seconds = time % 60;

    return "$minutes:${seconds.toString().padLeft(2, '0')}";
  }
}