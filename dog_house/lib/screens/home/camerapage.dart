import 'dart:ui';
import 'package:dog_house/auth/authentication_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class cameraPage extends StatefulWidget {
  const cameraPage({Key? key}) : super(key: key);

  @override
  State<cameraPage> createState() => _cameraPageState();
}

class _cameraPageState extends State<cameraPage> {
  double heating = 23.0;
  AuthService _auth = AuthService();
  bool switchIsActive = false;
  bool _isElevated = false;
  late bool lampActive = true;
  String petPos = '';
  bool Bool_petPos = true;
  final Uri _url = Uri.parse('http://192.168.69.106/pethouse');
  final ref = FirebaseDatabase.instance.reference();

  DatabaseReference _ref = FirebaseDatabase.instance.ref('ESP32_APP/POSITION');

  void _activateListeners() {
    ref.child('ESP32_APP/POSITION/Position').onValue.listen((event) {
      final Object? _pos = event.snapshot.value;
      setState(() {
        petPos = _pos.toString();
        if (petPos == 'INSIDE') {
          Bool_petPos = true;
        } else if (petPos == 'OUTSIDE') {
          Bool_petPos = false;
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _activateListeners();
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
                'Live CAM',
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
                height: 20,
              ),
              Center(
                  child: Lottie.asset('assets/images/lottie_test.json',
                      height: 200)),
              SizedBox(
                height: 30,
              ),
              Container(
                  width: 350,
                  height: 180,
                  decoration: BoxDecoration(
                      color: Colors.indigo.shade100,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5,
                            color: Colors.blueGrey,
                            spreadRadius: 1)
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Bool_petPos
                          ? Lottie.asset('assets/images/dog_inside1.json',
                              width: 180, fit: BoxFit.cover)
                          : Lottie.asset('assets/images/dog_outside1.json',
                              width: 180, fit: BoxFit.cover),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Your Pet Is',
                              style: TextStyle(
                                  fontFamily: 'snas_serif',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '$petPos',
                              style: TextStyle(
                                  fontFamily: 'snas_serif',
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigoAccent),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              SizedBox(
                height: 70,
              ),
              Center(
                child: RaisedButton(
                  color: Colors.indigo.shade100,
                  onPressed: _launchUrl,
                  child: Text(
                    'Activate Real-time Cam',
                    style: TextStyle(fontSize: 18, fontFamily: 'Montserrat'),
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  void _launchUrl() {
    launchUrl(_url);
  }
}
