import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  late final AndroidNotificationDetails _androidPlatformChannelSpecifics;
  late final NotificationDetails _platformChannelSpecifics;

  final int _countdownID = 0;

  Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings("notification");

    const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

    const String channelId = '0';
    const String channelName = 'Pomodoro Timer';

    _androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      channelId,
      channelName,
      importance: Importance.max,
      priority: Priority.high,
      ongoing: true,
      onlyAlertOnce: true,
    );

    _platformChannelSpecifics = NotificationDetails(android: _androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showCountdownNotification(String minute) async {
    await _flutterLocalNotificationsPlugin.show(
      _countdownID,
      'Countdown',
      '$minute min left',
      _platformChannelSpecifics,
    );
  }

  Future<void> cancelCountdownNotification() async {
    await _flutterLocalNotificationsPlugin.cancel(_countdownID);
  }
}
