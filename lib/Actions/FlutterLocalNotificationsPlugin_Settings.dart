export 'Reminder.dart';
export 'ReminderNotification.dart';

import 'package:jlb_flutter_app_2/Actions/ReminderNotification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

//why hardcode some notification values in show_Notification??????


//From rxdart
// https://pub.dev/documentation/rxdart/latest/rx/BehaviorSubject-class.html
final BehaviorSubject<ReminderNotification> didReceiveLocalNotificationSubject =
BehaviorSubject<ReminderNotification>();

final BehaviorSubject<String> selectNotificationSubject =
BehaviorSubject<String>();

// From  FlutterLocalNotificationsPlugin

Future<void> initNotifications(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async{
  var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:(int id, String title, String body, String payload) async{
        didReceiveLocalNotificationSubject.add(ReminderNotification(id: id, title: title, body: body, payload: payload));
      }
  );
  var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(
      initializationSettings, onSelectNotification: (String payload) async {
          if (payload != null){
              debugPrint('Notification payload: ' + payload);
          }
          //rxdart
          selectNotificationSubject.add(payload);
  });

}

Future<void> showNotification(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  var androidNotificationDetails = AndroidNotificationDetails('0', 'jlb_AndroidChannel', 'jlb_AndroidChannel', importance: Importance.max, priority: Priority.high, ticker: 'jlb_AndroidChannel Ticker text');
  var iOSNotificationDetails = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(android: androidNotificationDetails, iOS: iOSNotificationDetails);
  await flutterLocalNotificationsPlugin.show(99, 'jlb_Notification_Title', 'jlb_Notification_body', platformChannelSpecifics, payload: 'jlb_Notification_payload_sample');

}

Future<void> cancelNotification(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    await flutterLocalNotificationsPlugin.cancelAll();
}

Future<void> cancelNotificationByID(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin, num id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
}

Future<void> scheduleNotificationPeriodically(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    String id,
    String body,
    RepeatInterval interval) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(id, 'jlb_periodic_notification', 'jlb_notification_body', icon: '@mipmap/ic_launcher');
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.periodicallyShow(99, 'jlb_Reminder', body, interval, platformChannelSpecifics);
}

//add zonedSchedule if desired
//zonedSchedule(int id, String? title, String? body, TZDateTime scheduledDate, NotificationDetails notificationDetails, {required UILocalNotificationDateInterpretation uiLocalNotificationDateInterpretation, required bool androidAllowWhileIdle, String? payload, DateTimeComponents? matchDateTimeComponents}) → Future<void>
// Schedules a notification to be shown at the specified date and time relative to a specific time zone. [...]
//https://pub.dev/documentation/flutter_local_notifications/latest/flutter_local_notifications/FlutterLocalNotificationsPlugin-class.html

Future<void> scheduleNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    String id,
    String body,
    DateTime scheduledNotificationDateTime) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    id,
    'Reminder notifications',
    'Remember it',
    icon: 'app_icon',
  );
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.schedule(0, 'Reminder', body,
      scheduledNotificationDateTime, platformChannelSpecifics);
}

void requestIOSPermissions(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
  flutterLocalNotificationsPlugin
    .resolvePlatformSpecificImplementation<
    IOSFlutterLocalNotificationsPlugin>()
    ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
  );
}
