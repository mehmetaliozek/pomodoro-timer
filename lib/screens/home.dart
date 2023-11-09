import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro_timer/controllers/pomodoro_controller.dart';
import 'package:pomodoro_timer/widgets/pomodor_timer.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  static final PomodoroController _controller = Get.put(PomodoroController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: _controller.currentColor.value,
        appBar: AppBar(
          backgroundColor: _controller.currentColor.value,
          centerTitle: true,
          title: Text(
            "Pomodoro Timer",
            style: GoogleFonts.nunito(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              PomodoroTimer(controller: _controller),
              Text(
                "Tour #${_controller.tour.value}",
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ),
              Text(
                "Time to Focus!",
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
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
