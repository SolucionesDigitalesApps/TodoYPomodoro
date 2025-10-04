import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';


typedef BackgroundMessageHandler = Future<void> Function(RemoteMessage message);

class NotificationController {
  NotificationController._privateConstructor();
  static final NotificationController _instance = NotificationController._privateConstructor();
  factory NotificationController() => _instance;
  FirebaseMessaging messaging = FirebaseMessaging.instance;


  final _messageStreamController = StreamController<RemoteMessage>.broadcast();

  Stream<RemoteMessage> get mensajes => _messageStreamController.stream;

  Future<void> initNotifications(BackgroundMessageHandler backgroundMessageHandler) async {
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
    if(Platform.isAndroid){
      messaging.subscribeToTopic('general');
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _messageStreamController.sink.add(message);
    });

    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  }


  Future<String> getToken() async {
    try {
      String? token;
      token = await messaging.getToken();
      return token ?? "";
    } catch (e) {
      return "";
    }
  }

  Future<String> onSelect(String data) async {
    return '';
  }
}
