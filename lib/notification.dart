import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future<String?> getToken() async {
    try {
      return await messaging.getToken();
    } catch (e) {
      // ignore: avoid_print
      print('Failed to get notification token: $e');
      return null;
    }
  }

  static Future<void> configure() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // ignore: avoid_print
      print('Received message: ${message.notification?.body}');
      // Handle incoming message when the app is in the foreground
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // ignore: avoid_print
      print('Opened app from notification: ${message.notification?.body}');
      // Handle opening the app from a terminated state via notification
    });

    // Request permission to display notifications
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // ignore: avoid_print
      print('User granted permission for notifications');
    } else {
      // ignore: avoid_print
      print('User declined or has not granted permission for notifications');
    }
  }
}
