import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:todo_app/services/firebase/reminder.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationPlugin =
      FlutterLocalNotificationsPlugin();

  void requestNotificationsPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      sound: true,
      carPlay: true,
      provisional: false,
    );

    // if user don't grant permission
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('user grant permisson');
    } else if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('user grant provisional permisson');
    } else {
      AppSettings.openAppSettings(type: AppSettingsType.notification);
      print('user grant permisson');
    }
  }

  void initLocalNotification(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _flutterLocalNotificationPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) => {});
  }

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
      print(message.notification!.title.toString());
      print(message.notification!.body.toString());
      showNotification(message);
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotification? android = message.notification!.android;
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(100000).toString(),
        'High Importance Notifications',
        importance: Importance.max);

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      icon: android?.smallIcon,
      channelDescription: 'Your channel description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    // For IOS

    DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
  }

  Future<String> getDevideToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      print('refresh');
    });
  }

  // schedule notification
  Future<void> scheduleNotification(
    int id,
    String title,
    String body,
    DateTime scheduledTime,
  ) async {
    await _flutterLocalNotificationPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your_channel_id',
          'your_channel_name',
          // 'your_channel_description',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }


  /// -------------------------------------------------------------------------------
   Stream<List<Reminder>> fetchRemindersFromFirestore() {
  try {
   
   User? user = FirebaseAuth.instance.currentUser;
        String userId = user!.uid;
        
     Stream<QuerySnapshot<Map<String, dynamic>>> stream = FirebaseFirestore.instance
        .collection('task_list')
        .doc(userId)
        .collection('notes').snapshots()
        ;

    return stream.map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        // Assuming your Firestore document has 'task' and 'reminderTime' fields
        String task = doc['task'];
        String timestamp = doc['reminderTime'];
     

        return Reminder(
          task: task,
          reminderTime: timestamp,
          bellIc: false,
        );
      }).toList();
    });
  } catch (e) {
    print("Error fetching reminders: $e");
    return Stream.value([]); // Return an empty stream in case of an error
  }
}


// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

void backgroundFetchHeadlessTask(String taskId) async {
  try {
    // Fetch reminder data from Firestore
    var remindersStream = await fetchRemindersFromFirestore();

     // Listen to the stream and schedule notifications
    await for (var reminders in remindersStream) {
      scheduleNotifications(reminders);
    }
  } finally {
    BackgroundFetch.finish(taskId);
  }
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
void scheduleNotifications(List<Reminder> reminders) {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialize notification plugin if not already initialized
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  flutterLocalNotificationsPlugin.initialize(initializationSettings);
  AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(100000).toString(),
        'High Importance Notifications',
        importance: Importance.max);

  // Schedule notifications for each reminder
  for (var reminder in reminders) {
    flutterLocalNotificationsPlugin.zonedSchedule(
      reminder.task.hashCode, // Unique ID for the notification
      'Reminder',
      reminder.task,
      tz.TZDateTime.from( DateTime.parse(reminder.reminderTime) , tz.local),
       NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id.toString(),
          'Reminders',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
}