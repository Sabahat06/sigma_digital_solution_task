import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) {
    final InitializationSettings initializationSettings =
    InitializationSettings(android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    _notificationsPlugin.initialize(initializationSettings,onSelectNotification: (String? route) async {
      // if(route != null){
      //   // Navigator.of(context).pushNamed(route);
      //   Get.toNamed(route);
      // }
    });
  }

  static void display(RemoteMessage message) async {

    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/1000;

       NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            "YousufMobiles",
            "My  channel",
            importance: Importance.max,
            priority: Priority.high,
          )
      );


      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data["route"],
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}