import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro_timer/controllers/pomodoro_controller.dart';
import 'package:pomodoro_timer/widgets/pomodoro_button.dart';
import 'package:pomodoro_timer/widgets/pomodoro_status_change_bar.dart';

class PomodoroTimer extends StatelessWidget {
  const PomodoroTimer({
    super.key,
    required PomodoroController controller,
  }) : _controller = controller;

  final PomodoroController _controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        heightFactor: 1.5,
        child: Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: PomodoroStatusChangeBar(controller: _controller),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    "${_controller.minutes}:${_controller.seconds}",
                    style: GoogleFonts.nunito(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 72,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: PomodoroButton(
                    onPressed: () {
                      if (_controller.isActive.value) {
                        _controller.pauseTimer();
                      } else {
                        _controller.startTimer();
                      }
                    },
                    text: _controller.isActive.value ? "Pause" : "Start",
                    fontSize: 36,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
