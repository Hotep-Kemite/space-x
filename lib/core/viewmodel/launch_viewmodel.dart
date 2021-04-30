import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:iem_space_x/app/locator.dart';
import 'package:iem_space_x/core/api/api.dart';
import 'package:iem_space_x/core/model/launch.dart';

class LaunchViewModel extends ChangeNotifier {
  Api _api = locator<Api>();

  List<Launch> launches = [];

  // The view is loading by default, waiting for API call to succeed
  bool isLoading = true;

  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  LaunchViewModel() {
    loadData();
    initializeNotifications();
  }

  void loadData() async {
    try {
      var response = await _api.getUpcomingLaunches();
      launches.addAll(List<Launch>.from(
          response.data.map((item) => Launch.fromJson(item))));
    } catch (error, stackTrace) {
      print(stackTrace);
    }
    isLoading = false;
    notifyListeners();
  }

  void initializeNotifications() async {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final MacOSInitializationSettings initializationSettingsMacOS =
        MacOSInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: initializationSettingsMacOS);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future selectNotification(String payload) async {
    print("Notifications clicked");
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    print("Received local notification");
  }

  void showTestNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'space-x', 'Space X', 'Space X notification channel',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false);
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
        0, 'Notif test', 'Hello', platformChannelSpecifics,
        payload: 'item x');
  }
}
