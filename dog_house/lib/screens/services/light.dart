import 'package:dog_house/apis/notification_api.dart';
import 'package:dog_house/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dog_house/auth/authentication_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LightPage extends StatefulWidget {
  const LightPage({Key? key}) : super(key: key);

  @override
  State<LightPage> createState() => _LightPageState();
}

class _LightPageState extends State<LightPage> {
  AuthService _auth = AuthService();
  double heating = 23.0;
  bool switchIsActive = false;
  bool _isElevated = false;
  late bool lampActive = false;
  late String _lampstate = "none";
  final _ref = FirebaseDatabase.instance.reference();
  DatabaseReference setLampRef =
      FirebaseDatabase.instance.ref("Flutter_ESP_Actions/Lamp");

  void lampAction() async {
    lampActive
        ? await setLampRef.set({
            "lamp": "on",
          })
        : await setLampRef.set({
            "lamp": "off",
          });
  }

  Future<void> _activateListeners() async {
    await _ref.child('Flutter_ESP_Actions/Lamp/lamp').onValue.listen((event) {
      final Object? _lmp = event.snapshot.value;
      setState(() {
        lampActive = _lmp.toString() == "on" ? true : false;
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
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.indigo,
                    ),
                  ),
                  FlatButton.icon(
                      onPressed: () async {
                        try {
                          await _auth.SignOut();
                        } catch (e) {
                          print(e.toString());
                        }
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.logout_sharp, color: Colors.indigo),
                      label: Text(
                        'logout',
                        style: TextStyle(color: Colors.indigo),
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () {
                        Notify();
                        setState(() {
                          lampActive = lampActive ? false : true;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 90),
                        child: Text(
                          'Heating\n Light',
                          style: TextStyle(
                              color: Colors.indigo,
                              fontSize: 40,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3,
                              shadows: [
                                Shadow(
                                    color: Colors.black.withOpacity(0.3),
                                    offset: const Offset(15, 15),
                                    blurRadius: 15),
                              ]),
                        ),
                      )),
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/lamp.png',
                        width: 140,
                      ),
                      lampActive
                          ? Image.asset(
                              'assets/images/orange.png',
                              width: 150,
                              height: 130,
                            )
                          : Container(
                              height: 130,
                              width: 150,
                            ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.indigo,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.indigo.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Turn light On/Off ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'quicksand',
                              fontSize: 16),
                        ),
                        const SizedBox(height: 13),
                        SvgPicture.asset(
                          'assets/svg/light.svg',
                          width: 60,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 8),
                        Switch.adaptive(
                            value: lampActive,
                            activeColor: Colors.white,
                            onChanged: (bool newValue) {
                              setState(() {
                                lampActive = newValue;
                                lampAction();
                              });
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showToast() => Fluttertoast.showToast(
      msg: 'invalid email',
      fontSize: 18,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.red,
      textColor: Colors.white);
  void cancelToast() => Fluttertoast.cancel();
}
