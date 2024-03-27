import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseMessagingService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  //FCM 토큰 가져오기
  static Future<String> getFirebaseToken() async {
    String? token = await _firebaseMessaging.getToken(
        vapidKey:
            'BE9mL23oP0e2wY9kjVb24VeWCl50tGuYzVmaWBjEwjg9QfUpGDgOMv7VPKc3BIR-65wAlzMCNqK67R_GAGJcaxQ');
    return token ?? '';
  }

  static Future<void> initializeFirebaseMessaging() async {
    //FCM 메시지 수신 핸들러 등록

    // 1. 앱 실행 중일 때 FCM 수신하면 호출
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(
          'FCM 메시지 수신 : ${message.notification?.title} - ${message.notification?.body} ');
      _showNotification(
          message.notification?.title, message.notification?.body);
    });

    // 2. 앱 종료되었을 때 FCM 수신하면 호출
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(
          'FCM 메시지 오픈 : ${message.notification?.title} - ${message.notification?.body} ');
      _showNotification(
          message.notification?.title, message.notification?.body);
    });

    // 로컬 알림 초기화
    // 1. 안드로이드
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('app_icon'); // 앱 아이콘 리소스 이름으로 변경

    // 2. iOS
    // const IOSInitializationSettings iosInitializationSettings =
    //     IOSInitializationSettings(
    //         onDidReceiveLocalNotification: _onDidReceiveLocalNotification);

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      // iOS: iosInitializationSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  static Future<void> _showNotification(String? title, String? body) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channel id',
      'channel name',
      channelDescription: 'channel description',
      importance: Importance.max,
      priority: Priority.max,
      showWhen: false,
    );
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      // iOS: IOSNotificationDetails(),
    );

    await _flutterLocalNotificationsPlugin.show(
      0,
      title ?? '',
      body ?? '',
      notificationDetails,
    );
  }

  //FCM 알림 권한 요청
  static Future<void> requestFirebaseNotificationPermission() async {
    await _firebaseMessaging.requestPermission(
      sound: true,
      badge: true,
      alert: true,
      announcement: false,
    );
  }
}
