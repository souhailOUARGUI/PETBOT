import 'package:dog_house/apis/utilities.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static Future _notificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel id',
          'channel name',
          channelDescription: 'channel description',
          importance: Importance.max,
          icon: 'ic_notification',
        ),
        iOS: IOSNotificationDetails());
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,

    // required DateTime scheduleDate,
  }) async =>
      _notifications.show(id, title, body, await _notificationDetails(),
          payload: payload);
}
