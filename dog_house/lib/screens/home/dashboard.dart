import 'dart:ui';
import 'package:dog_house/auth/authentication_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import '../../apis/notification_api.dart';

class dashboardPage extends StatefulWidget {
  const dashboardPage({Key? key}) : super(key: key);

  @override
  State<dashboardPage> createState() => _dashboardPageState();
}

class _dashboardPageState extends State<dashboardPage> {
  AuthService _auth = AuthService();
  double heating = 23.0;
  bool switchIsActive = false;
  bool _isElevated = false;
  late bool lampActive = true;
  final ref = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Allow Notifications'),
                  content: Text('our app is using notifs'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('dont allow')),
                    TextButton(
                        onPressed: () {
                          AwesomeNotifications()
                              .requestPermissionToSendNotifications()
                              .then((_) => Navigator.pop(context));
                        },
                        child: Text('Allow'))
                  ],
                ));
      }
    });
    AwesomeNotifications().createdStream.listen((notification) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Notification Created on ${notification.channelKey}',
        ),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 18, left: 24, right: 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(''),
                  FlatButton.icon(
                      onPressed: () async {
                        try {
                          await _auth.SignOut();
                        } catch (e) {
                          print(e.toString());
                        }
                      },
                      icon: Icon(Icons.logout_sharp, color: Colors.indigo),
                      label: Text(
                        'logout',
                        style: TextStyle(color: Colors.indigo),
                      )),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Dashboard',
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.indigo.shade700,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                          blurRadius: 20,
                          color: Colors.grey.shade500,
                          offset: Offset(5, 10))
                    ],
                    letterSpacing: 3),
              ),
              SizedBox(
                height: 250,
              ),
              Center(
                child: Text(
                  'Page Under Construction...',
                  style: TextStyle(color: Colors.indigo, fontSize: 24),
                ),
              ),
              ElevatedButton(onPressed: () {}, child: Icon(Icons.add))
            ],
          ),
        ),
      ),
    );
  }
}
