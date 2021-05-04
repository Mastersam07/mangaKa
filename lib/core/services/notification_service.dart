import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:otakuzon/ui/views/home/notification.dart';
import 'package:path_provider/path_provider.dart';

import '../../locator.dart';
import 'navigator.dart';

class NotificationService {
  final _navigationService = locator<NavigationService>();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  NotificationService() {
    notificationServe();
  }

  void notificationServe() async {
    Hive.init((await getApplicationDocumentsDirectory()).path);
    await Hive.openBox('otakuzon');

    var db = Hive.box('otakuzon');

    bool isNotified = db.get('isNotification', defaultValue: true);

    print('isNotified: $isNotified');

    if (isNotified) {
      var content = await getNotificationContent();

      if (content != null) {
        await initializing();
        _showNotifications(content);
      }
    }
  }

  Future<Map> getNotificationContent() async {
    // final resData = await ComicData.getHomeData();
    // List<ComicV3> listV3 = resData['latestChapter'];

    // if (listV3.first.linkId != KomikcastSystem().getLastChapterId(db: Hive.box('komikcast'))) {
    //   KomikcastSystem()
    //       .setLastChapterId(listV3.first.linkId, db: Hive.box('komikcast'));
    //   return {
    //     'title': '[Update] ' + listV3.first.title,
    //     'body': listV3.first.chapters.first.title
    //   };
    // } else {
    //   return null;
    // }
    //
    // Just mocking
    return {
      'title': '[Update] ' + 'Mockanime',
      'body': 'Title of the mocked manga'
    };
  }

  Future<void> initializing() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  void _showNotifications(Map content) async {
    await notification(content);
  }

  Future<void> notification(Map content) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'Channel _ID', 'Channel title', 'Channel body',
            priority: Priority.high,
            importance: Importance.max,
            ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
        0, content['title'], content['body'], notificationDetails);
  }

  // Future onSelectNotification(String payload) {
  //   if (payload != null) {
  //     print(payload);
  //   }
  // }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Navigator.push(
      _navigationService.navigationKey.currentContext,
      MaterialPageRoute<void>(
          builder: (context) => NotificationScreen(payload: payload)),
    );
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            print('Cupertino Pressed');
          },
          child: Text('Okay'),
        ),
      ],
    );
  }
}
