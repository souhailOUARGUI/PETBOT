import 'package:dog_house/auth/authentication_service.dart';
import 'package:dog_house/auth/authenticate.dart';
import 'package:dog_house/auth/wrapper.dart';
import 'package:dog_house/onboarding_screen.dart';
import 'package:dog_house/screens/services/temperature.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'screens/services/home.dart';
import 'package:timezone/timezone.dart';
import 'package:dcdg/dcdg.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.white)
  ]);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        title: 'Smart DogHouse',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        // initialRoute: '/onboarding',
        // routes: {
        //   '/': (context) => Home(),
        //   '/temperature': (context) => TemperaturePage(),
        //   '/onboarding': (context) => OnboardingScreen(),
        // },
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}

void Notify() async {
  String _timezone = await AwesomeNotifications().getLocalTimeZoneIdentifier();
  // local notification
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 7,
        channelKey: 'basic_channel',
        title: 'Simple Notification',
        body: 'Simple body',
      ),
      schedule: NotificationInterval(
        interval: 5,
        allowWhileIdle: true,
        timeZone: _timezone,
        repeats: true,
      ));
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  //call awesomenotification to how the push notification.
  AwesomeNotifications().createNotificationFromJsonData(message.data);
}
