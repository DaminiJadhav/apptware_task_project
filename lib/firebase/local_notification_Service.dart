import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService{
  static final FlutterLocalNotificationsPlugin flutterlocalnotificationplugin=FlutterLocalNotificationsPlugin();


  static void initialize(){

    InitializationSettings initializationSettings=InitializationSettings(
        android: AndroidInitializationSettings("@drawable/ic_launcher")
    );

    flutterlocalnotificationplugin.initialize(initializationSettings,
    );

  }



  static void display(RemoteMessage message) async{

    try {

      final NotificationDetails notificationDetails=NotificationDetails(
          android: AndroidNotificationDetails(
              'easyapproach',
              "easyapproach channel",
              importance: Importance.max,
              priority: Priority.high
          )
      );
      flutterlocalnotificationplugin.show(
          0,
          message.notification!.title,
          message.notification!.body,
          notificationDetails,
          payload: message.data['route']
      );
    } on Exception catch (e) {
      print(e);
    }
  }



}
