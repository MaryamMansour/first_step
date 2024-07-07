
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FcmManager{
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Native Channel to handle foreground
  AndroidNotificationChannel channel =const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  Future<void> initFirebaseMessaging()async{
    await _requestPermission();
    await getToken();
    foreGroundMessaging();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  }
  Future<void> _requestPermission()async {
    NotificationSettings settings = await messaging.requestPermission(
    );
  }

  Future<void> getToken()async {
    String? token = await messaging.getToken();
    print("Token: $token");
  }


  Future<void> foreGroundMessaging() async {

    // FlutterLocalNotificationsPlugin just to show it while app in use(Package)
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();


    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);



    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;






      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
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
                icon: 'mipmap/ic_launcher',
                // other properties...
              ),
            ));
      }
    });  }



}

//Top level fun
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();


}
