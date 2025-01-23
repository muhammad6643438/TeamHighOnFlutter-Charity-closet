// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      if (Platform.isAndroid) {
        initLocalNotification(context, message);
        showNotification(message);
      //  fetchNotificationsCount(context);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      navigateToDetailView(message, context);
    });

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (Platform.isAndroid) {
        if (message != null) {
          navigateToDetailView(message, context);
        }
      }
    });
  }

  void navigateToDetailView(RemoteMessage message, BuildContext context) {
    final String titleWithDate = message.notification?.title ?? 'No Title';
    final String body = message.notification?.body ?? 'No Message';

    String dateTime = 'No Date';
    String title = 'No Title';

    if (titleWithDate.contains(" / ")) {
      List<String> parts = titleWithDate.split(" / ");
      if (parts.length == 2) {
        dateTime = parts[0].trim();
        title = parts[1].trim();
      }
      parts.clear();
    }
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => NotificationDetailView(
    //       title: title,
    //       message: body,
    //       date: dateTime,
    //     ),
    //   ),
    // );
  }

  void initLocalNotification(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSetting,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        final String? payload = response.payload;
        if (payload != null) {
      //    fetchNotificationsCount(context);
          navigateToDetailView(message, context);
        }
      },
    );
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel',
      "GoatApp Notification",
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id,
      channel.name,
      importance: Importance.high,
      priority: Priority.high,
      ticker: "ticker",
    );

    DarwinNotificationDetails iosNotificationDetails =
        const DarwinNotificationDetails(
      presentBadge: true,
      presentAlert: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );

    String titleWithDate = message.notification?.title ?? 'No Title';
    String title = 'No Title';

    if (titleWithDate.contains(" / ")) {
      List<String> parts = titleWithDate.split(" / ");
      if (parts.length == 2) {
        //dateTime = parts[0].trim();
        title = parts[1].trim();
      }
      parts.clear();
    }

    //List<String>? parts = message.notification?.title?.split(" / ");

    // Extract datetime and title
    // String? dateTime = parts?[0];
    // String? title = parts?[1];
    // debugPrint('$title');

    Future.delayed(Duration.zero, () {
      flutterLocalNotificationsPlugin.show(
          0, title, message.notification?.body.toString(), notificationDetails);
    });
  }

  void requestNotificationsPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        announcement: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        alert: true,
        badge: true,
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint("Authorized Permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint("Provisional Permission Granted");
    } else {
      AppSettings.openAppSettings();
      debugPrint("Permission Denied");
    }
  }

  Future<String> getDeviceToken() async {
    var token = await messaging.getToken();
    return token ?? '';
  }
}
