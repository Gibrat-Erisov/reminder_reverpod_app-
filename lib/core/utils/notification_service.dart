import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'channel description',
        importance: Importance.max,
        // priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  static Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) {
        onNotifications.add(payload);
      },
    );
    final settings = InitializationSettings(android: android, iOS: iOS);

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  static void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) {
    onNotifications.add(notificationResponse.payload);
  }

  static Future<void> turnOffNotification() async {
    await _notifications.cancelAll();
  }

  static Future<void> turnOffNotificationById(int id) async {
    await _notifications.cancel(id);
  }

  static Future show({
    required int id,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notifications.show(id, title, body, await _notificationDetails());

  static Future showScheduledNotification({
    required int id,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate,
  }) async {
    tz.initializeTimeZones();
    return _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      await _notificationDetails(),
      payload: payload,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}
