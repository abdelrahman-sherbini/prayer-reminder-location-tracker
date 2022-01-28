import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';

class Notification {
  static var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      '1', 'location-bg',
      channelDescription: 'fetch location in background',
      playSound: false,
      importance: Importance.max,
      priority: Priority.high);
  static Future notificationDetails() async {
    return NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: const IOSNotificationDetails(),
    );
  }

  static var flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Future showNotificationWithoutSound({
    int id = 0,
    String? title,
    String? body,
    String payload = '',
    Position? position,
  }) async =>
      flutterLocalNotificationsPlugin.show(
        0,
        title,
        body,
        NotificationDetails(
            android: androidPlatformChannelSpecifics,
            iOS: const IOSNotificationDetails()),
        payload: payload,
      );

  // static Future showNotificationWithoutSound(Position position) async {
  //   var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
  //       '1', 'location-bg',
  //       channelDescription: 'fetch location in background',
  //       playSound: false,
  //       importance: Importance.max,
  //       priority: Priority.high);
  //   var iOSPlatformChannelSpecifics =
  //       const IOSNotificationDetails(presentSound: false);
  //   var platformChannelSpecifics = NotificationDetails(
  //       android: androidPlatformChannelSpecifics,
  //       iOS: iOSPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     'Location fetch',
  //     position.toString(),
  //     platformChannelSpecifics,
  //     payload: '',
  //   );
  // }

  Notification() {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = const IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
}
