// ignore_for_file: prefer_const_constructors
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

//local notifications package needs to be initialized, we will be creating a service class to handle this logic for our entire application.
//This class will also expose methods to create/send/cancel notifications.
class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();
  factory NotificationService() {
    return _notificationService;
  }
  NotificationService._internal();

  //initializing local notification package
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //initializing platform specifics
  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher'); //defining icon name
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    //creating instance of platform specific initialization (so 1 or 2 notification can be called at once)
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    //initializing local notification's timezone to schedule local notification
    tz.initializeTimeZones();

    //initializing flutter local notification with platform specific instance and on select method
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  //method to create a function which runs when notification is tapped.
  Future selectNotification(String? payload) async {
    //Handle notification tapped logic here
  }

  //Defining how notification will look like in android platform
  static const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
          'channel Id', 'channel Name', 'channelDescription',
          importance: Importance.max, priority: Priority.max);

  //how notification details will look like in different platform
  static const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  //method to show notification
  //id identify notification uniquely (same id notification can only be called once and different id notification can be called multiple times)
  static Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }
}
