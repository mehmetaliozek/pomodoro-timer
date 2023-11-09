import 'package:flutter/material.dart';
import 'package:pomodoro_timer/controllers/pomodoro_controller.dart';
import 'package:pomodoro_timer/utils/pomodoro_modes.dart';
import 'package:pomodoro_timer/widgets/pomodoro_button.dart';

class PomodoroStatusChangeBar extends StatelessWidget {
  const PomodoroStatusChangeBar({
    super.key,
    required PomodoroController controller,
  }) : _controller = controller;

  final PomodoroController _controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PomodoroButton(
          onPressed: () {
            _controller.changeModeWithButton(PomodoroModes.pomodoro);
          },
          text: "Pomodoro",
          fontSize: 12,
        ),
        PomodoroButton(
          onPressed: () {
            _controller.changeModeWithButton(PomodoroModes.short);
          },
          text: "Short Break",
          fontSize: 12,
        ),
        PomodoroButton(
          onPressed: () {
            _controller.changeModeWithButton(PomodoroModes.long);
          },
          text: "Long Break",
          fontSize: 12,
        ),
      ],
    );
  }
}
