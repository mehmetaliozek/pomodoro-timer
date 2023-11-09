import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:pomodoro_timer/services/alarm_service.dart';
import 'package:pomodoro_timer/services/notification_service.dart';
import 'package:pomodoro_timer/utils/pomodoro_colors.dart';
import 'package:pomodoro_timer/utils/pomodoro_modes.dart';

class PomodoroController extends GetxController {
  late AlarmService _alarmManager;
  late NotificationService _notificationManager;
  Timer? _timer;
  RxBool isActive = false.obs;

  final RxInt _currentMinutes = 0.obs;
  final RxInt _currentSeconds = 0.obs;
  final int _pomodoroMinutes = 25;
  final int _shortMinutes = 5;
  final int _longMinutes = 15;

  String get minutes => _currentMinutes.value < 10 ? "0${_currentMinutes.value}" : "${_currentMinutes.value}";
  String get seconds => _currentSeconds.value < 10 ? "0${_currentSeconds.value}" : "${_currentSeconds.value}";

  final RxInt tour = 1.obs;

  late Rx<Color> currentColor;
  late Rx<PomodoroModes> currentMode;

  Future<void> requestNotificationPermissions() async {
    NotificationPermissions.getNotificationPermissionStatus().then((value) {
      if (value == PermissionStatus.denied) {
        NotificationPermissions.requestNotificationPermissions(openSettings: true);
      }
    });
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    currentColor = PomodoroColors.pomodoro.color.obs;
    currentMode = PomodoroModes.pomodoro.obs;
    _currentMinutes.value = _pomodoroMinutes;

    await requestNotificationPermissions();

    _notificationManager = NotificationService();
    await _notificationManager.initialize();

    _alarmManager = AlarmService();
    await _alarmManager.initialize();
  }

  void changeColor(PomodoroColors colors) {
    switch (colors) {
      case PomodoroColors.pomodoro:
        currentColor.value = PomodoroColors.pomodoro.color;
        break;
      case PomodoroColors.short:
        currentColor.value = PomodoroColors.short.color;
        break;
      case PomodoroColors.long:
        currentColor.value = PomodoroColors.long.color;
        break;
    }
  }

  void changeModeWithButton(PomodoroModes modes) {
    isActive.value = false;
    switch (modes) {
      case PomodoroModes.pomodoro:
        _currentMinutes.value = _pomodoroMinutes;
        currentMode.value = PomodoroModes.pomodoro;
        changeColor(PomodoroColors.pomodoro);
        break;
      case PomodoroModes.short:
        _currentMinutes.value = _shortMinutes;
        currentMode.value = PomodoroModes.short;
        changeColor(PomodoroColors.short);
        break;
      case PomodoroModes.long:
        _currentMinutes.value = _longMinutes;
        currentMode.value = PomodoroModes.long;
        changeColor(PomodoroColors.long);
        break;
    }
    _notificationManager.cancelCountdownNotification();
    _currentSeconds.value = 0;
    _timer?.cancel();
  }

  void changeModeWithTimer(PomodoroModes modes) {
    isActive.value = false;
    if (modes == PomodoroModes.pomodoro) {
      if (tour.value % 4 == 0) {
        _currentMinutes.value = _longMinutes;
        currentMode.value = PomodoroModes.long;
        changeColor(PomodoroColors.long);
      } else {
        _currentMinutes.value = _shortMinutes;
        currentMode.value = PomodoroModes.short;
        changeColor(PomodoroColors.short);
      }
    } else {
      tour.value++;
      _currentMinutes.value = _pomodoroMinutes;
      currentMode.value = PomodoroModes.pomodoro;
      changeColor(PomodoroColors.pomodoro);
    }
    _currentSeconds.value = 0;
    _timer?.cancel();
  }

  void startTimer() {
    isActive.value = true;
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_currentMinutes.value == 0 && _currentSeconds.value == 0) {
          changeModeWithTimer(currentMode.value);
          Future.delayed(
            const Duration(seconds: 1),
            () => _notificationManager.cancelCountdownNotification().then((value) => _alarmManager.ringCountdownAlarm()),
          );
        } else if (_currentSeconds.value == 0) {
          _currentMinutes.value--;
          _currentSeconds.value = 59;
        } else {
          _currentSeconds.value--;
        }
        _notificationManager.showCountdownNotification("$minutes:$seconds");
      },
    );
  }

  void pauseTimer() {
    isActive.value = false;
    _timer?.cancel();
  }
}
