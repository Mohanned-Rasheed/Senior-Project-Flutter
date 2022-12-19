import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class notification {
  final FlutterLocalNotificationsPlugin _notification =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidNotification =
      AndroidInitializationSettings('logo');

  void initialiseNotifications() async {
    InitializationSettings initializationSettings =
        InitializationSettings(android: _androidNotification);

    _notification.initialize(initializationSettings);
  }

  void sendNotification(String title, String body) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('channelId', 'ChannelName',
            importance: Importance.max, priority: Priority.high);

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await _notification.show(0, title, body, notificationDetails);
  }
}
