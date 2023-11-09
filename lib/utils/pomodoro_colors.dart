import 'dart:ui';

enum PomodoroColors {
  pomodoro(Color(0xFFBA4949)),
  short(Color(0xFF49BABA)),
  long(Color(0xFF4A72BA));

  final Color color;

  const PomodoroColors(this.color);
}
