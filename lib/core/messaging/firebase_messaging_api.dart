import 'package:demandes/core/messaging/repository/user_token_repository.dart';
import 'package:demandes/features/demandes/presentation/pages/notification_screen.dart';
import 'package:demandes/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseMessagingApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final androidChannel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'Channel utilisé pour les importantes notifications.', // description
    importance: Importance.high,
  );
  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    print('fcmToken: $fcmToken');
    //Store the fcmToken in the database

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('fcmToken', fcmToken!);
    initPushNotifications();
  }

  static Future<void> storeToken(String token) async {}

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    navigatorKey.currentState?.push(NotificationScreen.route(message));
    print('Navigated to the notification screen');
  }

  void initPushNotifications() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    _firebaseMessaging.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    print('Title: ${message.notification?.title}');
    print('body: ${message.notification?.body}');
    print('payload: ${message.data}');
  }
}
