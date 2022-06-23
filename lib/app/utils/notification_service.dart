// ignore_for_file: prefer_const_constructors
import 'dart:developer';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
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

  //using rxdart package to listen our notification being tapped or not
  static final onNotification = BehaviorSubject<String?>();

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
        onSelectNotification: onSelectNotification);
  }

  //method to create a function which runs when notification is tapped.
  Future onSelectNotification(String? payload) async {
    //adding payload on stream so that when notification is tapped it can get the pay load
    onNotification.add(payload);
  }

  //Defining how notification will look like in android platform
  static const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
          'channel Id', 'channel Name', 'channelDescription',
          importance: Importance.max, priority: Priority.max);

  //how notification details will look like in different platform
  static const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  /////////////////////////////////////////////////////method to show notification/////////////////////////////////////////////////////////////////////////
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

  /////////////////////////////////////////////////////method to schedule notification/////////////////////////////////////////////////////////////////////////
  //id identify notification uniquely (same id notification can only be called once and different id notification can be called multiple times)
  static Future scheduleNotification(
      {int id = 0,
      String? title,
      String? body,
      tz.TZDateTime? dateTime,
      String? payload,
      DateTimeComponents? matchDateTimeComponents}) async {
    log("tz date: $dateTime");
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      // tz.TZDateTime.now(tz.getLocation('Asia/Kathmandu'))
      //     .add(const Duration(seconds: 5)),
      dateTime!,
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      payload: payload,
      matchDateTimeComponents: matchDateTimeComponents,
    );
    //log("notification scheduled on tz $dateTime");
  }

  //cancel scheduled notification
  static Future cancelScheduleNotification({required int id}) async {
    await flutterLocalNotificationsPlugin.cancel(id);
    log("notification cancelled");
  }
}

///////////////////////////////////////////////////add following in main.dart file/////////////////////////////////////////////////////////////
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   initLocator();
//   ///////initializing local notification
//   await NotificationService().init();         <-----------------add in main.dart
//   ///////initializing listen notification
//   listenNotification();                        <-----------------add in main.dart
//   runApp(
//     const GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SplashScreen(),
//     ),
//   );
// }

// //method to listen tap (strem) on notification, if the notification is clicked then will execute onClickedNotification function
// void listenNotification() {                     <-----------------add in main.dart
//   NotificationService.onNotification.stream.listen(onClickedNotification);
// }

// //method to direct to the page (also passes the payload)
// void onClickedNotification(String? payload) {    <-----------------add in main.dart
//   Get.to(() => ReminderDetailView(
//         id: payload,
//       ));
// }

///////////////////////////////////////////////////how to use in application////////////////////////////////////////////////////////////////////
////////////////////Call the show notification function to show notification
////////////////////use payload to transfer the data which we want to recieve when tapping notification
// onTap: () async {
//   await NotificationService.showNotification(
//       title: 'dawa',
//       body: "dfjalsdjlkasjsddf",
//       payload: 'laksksdj');
// },

////////////////////Call the show notification function to show notification
// onTap: () async {
//   await NotificationService.scheduleNotification(
//       id: 1,
//       title: 'hlw',
//       body: "prashanna sir",
//       scheduledDate: tz.TZDateTime.now(tz.local)
//           .add(const Duration(seconds: 10)),
//       payload: 'laksksdj');
// }
