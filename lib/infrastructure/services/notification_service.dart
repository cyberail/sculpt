import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sculpt/constants/enums.dart';
import 'package:sculpt/infrastructure/services/handlers.dart';
import 'package:sculpt/models/notification_data.dart';

class NotificationService {
  NotificationService._();

  static NotificationService? _instance;
  static FlutterLocalNotificationsPlugin? _notifhandler;

  factory NotificationService() {
    _instance ??= NotificationService._();
    _notifhandler ??= FlutterLocalNotificationsPlugin();
    return _instance!;
  }

  Future<void> init() async {
    await _notifhandler?.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('icon'),
      ),
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveBackgroundNotificationResponse,
    );
  }

  Future<bool?> requestPermissions() async {
    return await _notifhandler
        ?.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> cancelNotification(int id) async {
    await _notifhandler?.cancel(id);
  }

  Future<void> showNotification(NotificationData data) async {
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      "sculpt",
      "sculpt_channel",
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction(
          NotificationAction.stop.name,
          'Stop',
          icon: DrawableResourceAndroidBitmap("stop"),
          cancelNotification: false,
        ),
      ],
      priority: Priority.max,
      importance: Importance.max,
      largeIcon: const DrawableResourceAndroidBitmap("icon"),
      groupKey: "group-1",
      setAsGroupSummary: true,
      showProgress: data.progress == null ? false : true,
      maxProgress: data.progress?.maxProgress ?? 0,
      progress: data.progress?.progress ?? 0,
      colorized: true,
      category: AndroidNotificationCategory.progress,
      silent: true,
      styleInformation: DefaultStyleInformation(true, true),
    );
    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await _notifhandler?.show(1, data.title, data.body, notificationDetails);
  }
}
