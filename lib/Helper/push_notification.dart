import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:wifyfood/Helper/cart_count.dart';
import 'package:wifyfood/Helper/global_key.dart';

// class NavigateRouteData extends ChangeNotifier {
//   String navigateData = "";

//   void getNavigateData(String data) {
//     navigateData = data;
//     notifyListeners();
//   }
// }

class PushNotification {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  // FirebaseMessaging _messaging = FirebaseMessaging();

  initialize() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('wify_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onSelectNotification: onSelectNotification
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        _showNotification(0, message.notification.title,
            message.notification.body, "GET PAYLOAD FROM message OBJECT");
      }
    });

    // _messaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print("onMessageUser $message");
    //     // FlutterRingtonePlayer.playNotification(
    //     //   volume: 100,
    //     // );
    //     _showNotification(0, message["notification"]["title"],
    //         message["notification"]["body"], "GET PAYLOAD FROM message OBJECT");
    //     return;
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("onResumeUser $message");
    //     // FlutterRingtonePlayer.playNotification(
    //     //   volume: 100,
    //     // );
    //     // _showNotification(0, message["notification"]["title"],
    //     //     message["notification"]["body"], "GET PAYLOAD FROM message OBJECT");
    //     return;
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunchUser $message");
    //     // FlutterRingtonePlayer.playNotification(
    //     //   volume: 100,
    //     // );
    //     // _showNotification(0, message["notification"]["title"],
    //     //     message["notification"]["body"], "GET PAYLOAD FROM message OBJECT");
    //     return;
    //   },
    // );
  }

  initializeKitchen(BuildContext context) {
    // final c = Provider.of<CartCount>(context);
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('wify_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onSelectNotification: onSelectNotification
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      context.watch<CartCount>().updateBell(true);
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        _showNotificationKitchen(0, message.notification.title,
            message.notification.body, "GET PAYLOAD FROM User");
      }
    });

    // _messaging.configure(
    //   onBackgroundMessage: onBackgroundMessageHandler,
    //   onMessage: (Map<String, dynamic> message) async {
    //     print("onMessageKitchen $message");
    //     // c.updateBell(true);
    //     //
    //     print("onMessage:------------------------------------$message");
    //     print("onMessageKitchenScreen ${message['data']['screen']}");
    //     _showNotificationKitchen(0, message["notification"]["title"],
    //         message["notification"]["body"], "GET PAYLOAD FROM User");
    //     // GlobalVariable.navState.currentState
    //     //     .pushReplacementNamed("${message['data']['screen']}");

    //     GlobalVariable.navState.currentState
    //         .popUntil(ModalRoute.withName("KitchenDashboard"));
    //     GlobalVariable.c.updateBell(true);
    //     // GlobalVariable.navState.currentState
    //     //     .push(MaterialPageRoute(builder: (_) => KitchenDashboard()));
    //     // CartCount().getNavigateData(message['data']["screen"]);
    //     // Navigator.of().pushNamed(message['screen']);
    //     // navigatorKey.currentState
    //     //     .push(MaterialPageRoute(builder: (_) => KitchenDashboard()));

    //     return;
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("onResumeKitchen $message");
    //     print("onResumeKitchenScreen ${message['data']['screen']}");
    //     GlobalVariable.navState.currentState
    //         .popUntil(ModalRoute.withName("${message['data']["screen"]}"));
    //     GlobalVariable.c.updateBell(true);
    //     // GlobalVariable.navState.currentState
    //     //     .push(MaterialPageRoute(builder: (_) => KitchenDashboard()));
    //     // Navigator.of(GlobalKey().currentState.context)
    //     //     .pushNamed(message['data']["screen"]);
    //     // CartCount().getNavigateData(message['data']["screen"]);
    //     // KitchenDashboard();
    //     // c.updateBell(true);

    //     return;
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunchKitchen $message");
    //     print("onLaunchKitchenScreen ${message['data']['screen']}");
    //     GlobalVariable.c.updateBell(true);
    //     // GlobalVariable.navState.currentState
    //     //     .push(MaterialPageRoute(builder: (_) => KitchenDashboard()));
    //     // CartCount().getNavigateData(message['data']["screen"]);
    //     // KitchenDashboard();
    //     // c.updateBell(true);
    //     return;
    //   },
    // );
  }

  static Future<dynamic> onBackgroundMessageHandler(
      Map<String, dynamic> message) async {
    if (message.containsKey("data")) {
      // final data = message['data'];
      // final title = data['title'];
      // final body = data['message'];
      // _showNotificationKitchen(0, message["notification"]["title"],
      //     message["notification"]["body"], "GET PAYLOAD FROM User");

    }

// android:name="io.flutter.app.FlutterApplication"
    return Future<void>.value();
  }

  Future<void> _showNotification(
    int notificationId,
    String notificationTitle,
    String notificationContent,
    String payload, {
    String channelId = '1',
    String channelTitle = 'User Channel',
    String channelDescription = 'User Channel for notifications',
    Priority notificationPriority = Priority.high,
    Importance notificationImportance = Importance.max,
  }) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      channelId,
      channelTitle,
      channelDescription,
      playSound: true,
      enableVibration: true,
      importance: notificationImportance,
      priority: notificationPriority,
      // sound: RawResourceAndroidNotificationSound("bell"),
    );
    var iOSPlatformChannelSpecifics =
        new IOSNotificationDetails(presentSound: false);
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      notificationId,
      notificationTitle,
      notificationContent,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  Future<void> _showNotificationKitchen(
    int notificationId,
    String notificationTitle,
    String notificationContent,
    String payload, {
    String channelId = '2',
    String channelTitle = 'Kitchen Channel',
    String channelDescription = 'Kitchen Channel for notifications',
    Priority notificationPriority = Priority.high,
    Importance notificationImportance = Importance.max,
  }) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      channelId,
      channelTitle,
      channelDescription,
      playSound: true,
      enableVibration: true,
      importance: notificationImportance,
      priority: notificationPriority,
      icon: 'wify_launcher',
      sound: RawResourceAndroidNotificationSound("iphone"),
    );
    var iOSPlatformChannelSpecifics =
        new IOSNotificationDetails(presentSound: true);
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      notificationId,
      notificationTitle,
      notificationContent,
      platformChannelSpecifics,
      payload: payload,
    );
  }
}

// Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   // PushNotification()._showNotificationKitchen(
//   //     0,
//   //     message["notification"]["title"],
//   //     message["notification"]["body"],
//   //     "GET PAYLOAD FROM Kitchen");
//   // return message;
// }
