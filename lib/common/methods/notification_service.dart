import 'dart:io';

import 'package:flutter/rendering.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  // immediate TEST notification -- FOR DEBUGGING PURPOSES--
  // Future<void> showTestNotification() async {
  //   const AndroidNotificationDetails androidDetails =
  //       AndroidNotificationDetails(
  //         'task_channel',
  //         'Task Notifications',
  //         channelDescription: 'Test Channel',
  //         importance: Importance.max,
  //         priority: Priority.high,
  //       );

  //   const NotificationDetails notificationDetails = NotificationDetails(
  //     android: androidDetails,
  //     iOS: DarwinNotificationDetails(),
  //   );

  //   await NotificationService._notifications.show(
  //     0, // ID
  //     '🚨 Test Notification',
  //     'This is a test message',
  //     notificationDetails,
  //   );
  // }

  // Handles all the needed initializations - call in main.dart
  Future<void> init() async {
    // Initialize time zones (required for scheduling)
    tz.initializeTimeZones();

    // Set local timezone explicitly to IST Asia/Kolkata - this is done because tz.local automatically gets set to UTC not IST
    //tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));

    // Initialization settings for Android and iOS
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    // Initialize the plugin
    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle notification tap here (optional)
      },
    );

    // iOS permissions
    await _notifications
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    // Android 13+ permissions and channel creation
    if (Platform.isAndroid) {
      final androidPlugin =
          _notifications
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();

      // Request notification permission
      await androidPlugin?.requestNotificationsPermission();

      // Create notification channel
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'task_channel', // Channel ID (must match the one used in AndroidNotificationDetails)
        'Task Notifications', // Channel name (visible in system settings)
        description: 'Notifies about scheduled tasks',
        importance: Importance.max,
      );

      await androidPlugin?.createNotificationChannel(channel);
    }
  }

  // Scheduling a notification
  static Future<void> scheduleNotification({
    required String taskId,
    required String title,
    required String desc,
    required DateTime scheduledDate,
  }) async {
    int notificationId = taskId.hashCode;

    final scheduledTZ = tz.TZDateTime.local(
      scheduledDate.year,
      scheduledDate.month,
      scheduledDate.day,
      scheduledDate.hour,
      scheduledDate.minute,
      scheduledDate.second,
    );

    try {
      await _notifications.zonedSchedule(
        notificationId,
        title,
        desc,
        scheduledTZ,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'task_channel',
            'Task Notifications',
            channelDescription: 'Notifies about scheduled tasks',
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),

        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    } catch (e) {
      debugPrint("❌ Failed to schedule exact alarm: $e");
      if (e.toString().contains('exact_alarms_not_permitted')) {
        debugPrint("Redirecting to settings for exact alarm permission...");
        await openExactAlarmSettings();
      }
    }
  }
}

Future<void> openExactAlarmSettings() async {
  if (Platform.isAndroid) {
    const intent = AndroidIntent(
      action: 'android.settings.REQUEST_SCHEDULE_EXACT_ALARM',
    );
    await intent.launch();
  }
}
