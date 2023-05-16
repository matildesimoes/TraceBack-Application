import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> configureFirebaseMessaging() async {
    // Configurações iniciais do Firebase Messaging
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Permissão concedida pelo usuário.');
    } else {
      print('Permissão negada pelo usuário.');
    }

    // Configura o listener para receber notificações em primeiro plano
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Mensagem recebida em primeiro plano: ${message.notification
          ?.title}');
      // Realize as ações desejadas com a notificação recebida
    });

    // Configura o listener para receber notificações quando o aplicativo estiver fechado
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Aplicativo aberto através da notificação: ${message.notification
          ?.title}');
      // Realize as ações desejadas ao abrir o aplicativo através da notificação
    });
  }

  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }

  Future<void> createChannel(AndroidNotificationChannel channel) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }


  Future<void> sendNotificationToAllUsers(String title, String body) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosInitializationSettings =
    DarwinInitializationSettings();
    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'New Found Post',
      'A new post has been upload to TraceBack! Check it out to see if it´s yours!',
      description: 'This is for flutter firebase',
      importance: Importance.max,
    );
    createChannel(channel);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((event) {
      final notification = event.notification;
      final android = event.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: android.smallIcon,
            ),
          ),
        );
      }
    });
  }
}
