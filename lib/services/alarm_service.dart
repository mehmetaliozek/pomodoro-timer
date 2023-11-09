import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:just_audio/just_audio.dart';

class AlarmService {
  final int _alarmID = 0;

  Future<void> initialize() async {
    await AndroidAlarmManager.initialize();
  }

  Future<void> ringCountdownAlarm() async {
    await AndroidAlarmManager.oneShotAt(DateTime.now(), _alarmID, _callbackCountdownAlarm);
  }

  @pragma("vm:entry-point")
  static void _callbackCountdownAlarm() async {
    final player = AudioPlayer();
    await player.setAsset("assets/notification.mp3");
    await player.setVolume(2);
    await player.play();
  }
}
