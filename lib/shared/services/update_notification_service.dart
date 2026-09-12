import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'app_update_service.dart';

class UpdateNotificationService {
  UpdateNotificationService._();

  static const String updatesTopic = 'app_updates';
  static const String _channelId = 'app_updates';
  static const String _channelName = 'Atualizações do aplicativo';
  static const String _channelDescription =
      'Avisos sobre novas versões do Cálculo Trivial.';

  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    if (kIsWeb) {
      return;
    }

    await _initializeLocalNotifications();

    final messaging = FirebaseMessaging.instance;

    final settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      debugPrint('Notificações de atualização foram negadas pelo usuário.');
      return;
    }

    await messaging.subscribeToTopic(updatesTopic);

    FirebaseMessaging.onMessage.listen(_showForegroundNotification);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleRemoteMessageTap);

    final initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      await _handleRemoteMessageTap(initialMessage);
    }

    final token = await messaging.getToken();
    debugPrint(
      token == null
          ? 'FCM inicializado, mas sem token disponível.'
          : 'FCM inicializado e inscrito no tópico $updatesTopic.',
    );
  }

  static Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const darwinSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
      macOS: darwinSettings,
    );

    await _localNotifications.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: _handleLocalNotificationTap,
    );
  }

  static Future<void> _showForegroundNotification(
    RemoteMessage message,
  ) async {
    final notification = message.notification;

    if (notification == null) {
      return;
    }

    const androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.high,
      priority: Priority.high,
    );

    const darwinDetails = DarwinNotificationDetails();

    const details = NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
      macOS: darwinDetails,
    );

    await _localNotifications.show(
      id: message.messageId?.hashCode ?? DateTime.now().millisecondsSinceEpoch,
      title: notification.title ?? 'Cálculo Trivial',
      body: notification.body ?? 'Uma nova atualização está disponível.',
      notificationDetails: details,
      payload: 'open_store',
    );
  }

  static Future<void> _handleRemoteMessageTap(RemoteMessage message) async {
    await AppUpdateService.openPlayStore();
  }

  static void _handleLocalNotificationTap(
    NotificationResponse response,
  ) {
    if (response.payload == 'open_store') {
      AppUpdateService.openPlayStore();
    }
  }
}
