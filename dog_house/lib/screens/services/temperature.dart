import 'dart:collection';
import 'dart:ui';
import 'package:dog_house/auth/authentication_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TemperaturePage extends StatefulWidget {
  const TemperaturePage({Key? key}) : super(key: key);

  @override
  State<TemperaturePage> createState() => _TemperaturePageState();
}

class _TemperaturePageState extends State<TemperaturePage> {
  AuthService _auth = AuthService();
  double heating = 23.0;
  bool IsActive = false;
  bool _isElevated = false;
  var humNum;
  var tempNum;
  double humPercent = 0.0;
  double tempPercent = 0.0;
  bool FanActive = false;
  final ref = FirebaseDatabase.instance.reference();
  DatabaseReference fanRef =
      FirebaseDatabase.instance.ref('Flutter_ESP_Actions/Fan');
  void fanAction() async {
    FanActive
        ? await fanRef.update({
            "fan": "on",
          })
        : await fanRef.update({
            "fan": "off",
          });
  }

  void autoFanAction() async {
    FanActive
        ? await fanRef.update({
            "autoMode": "on",
          })
        : await fanRef.update({
            "autoMode": "off",
          });
  }

  Future<void> _activateListeners() async {
    ref.child('ESP32_APP/WEATHER/HUMIDITY').onValue.listen((event) {
      final Object? hum = event.snapshot.value;
      setState(() {
        humNum = hum;
        humPercent = humNum / 100;
      });
    });
    ref.child('ESP32_APP/WEATHER/TEMPERATURE').onValue.listen((event) {
      final Object? temp = event.snapshot.value;
      setState(() {
        tempNum = temp;
        tempPercent = tempNum / 60;
      });
    });
    await ref.child('Flutter_ESP_Actions/Fan/fan').onValue.listen((event) {
      final Object? _faan = event.snapshot.value;
      setState(() {
        FanActive = _faan.toString() == "on" ? true : false;
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
              Expanded(
                  child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  Wrap(
                    children: [
                      Text(
                        'Temperature & Humidity',
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
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  CircularPercentIndicator(
                    radius: 180,
                    lineWidth: 14,
                    percent: tempPercent,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Colors.red,
                    backgroundColor: Colors.red.shade100,
                    center: Text('$tempNum\u00B0',
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Center(
                    child: const Text('Temperature',
                        style: TextStyle(
                            fontSize: 32,
                            fontFamily: 'quicksand',
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CircularPercentIndicator(
                    radius: 180,
                    lineWidth: 14,
                    percent: humPercent,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Colors.blueAccent.shade700,
                    backgroundColor: Colors.blueAccent.shade100,
                    center: Text('$humNum%',
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Center(
                    child: const Text('Humidity',
                        style: TextStyle(
                            fontSize: 32,
                            fontFamily: 'quicksand',
                            fontWeight: FontWeight.bold)),
                  ),
                  /* const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _roundedButton(title: 'General', isActive: true),
                      _roundedButton(title: 'Services'),
                    ],
                  ), */
                  const SizedBox(
                    height: 18,
                  ),
                  // Container(
                  //   padding: EdgeInsets.symmetric(vertical: 20),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(8),
                  //     color: Colors.white,
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       const Padding(
                  //         padding: EdgeInsets.symmetric(horizontal: 32),
                  //         child: const Text('HEATING',
                  //             style: TextStyle(
                  //                 fontWeight: FontWeight.bold, fontSize: 18)),
                  //       ),
                  //       Slider(
                  //         value: heating,
                  //         onChanged: (newHeating) {
                  //           setState(() => heating = newHeating);
                  //         },
                  //         max: 30,
                  //       ),
                  //       Padding(
                  //         padding: EdgeInsets.symmetric(horizontal: 24),
                  //         child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Text(
                  //                 '0\u00B0',
                  //                 style: TextStyle(fontSize: 12),
                  //               ),
                  //               Text(
                  //                 '15\u00B0',
                  //                 style: TextStyle(fontSize: 12),
                  //               ),
                  //               Text(
                  //                 '30\u00B0',
                  //                 style: TextStyle(fontSize: 12),
                  //               )
                  //             ]),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _fan(title: 'FAN ', isActive: FanActive),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _fan({required String title, required bool isActive}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.indigo)),
      width: 250,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SvgPicture.asset(
                'assets/svg/fan.svg',
                color: Colors.white,
                width: 60,
              ),
              SizedBox(height: 5),
              Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Red_Hat_Display'),
              ),
            ],
          ),
          Switch.adaptive(
              value: FanActive,
              activeColor: Colors.white,
              onChanged: (bool newValue) {
                setState(() {
                  FanActive = newValue;
                  fanAction();
                });
              }),
        ],
      ),
    );
  }

  Widget _roundedButton({
    required String title,
    bool isActive = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
      decoration: BoxDecoration(
        color: isActive ? Colors.indigo : Colors.transparent,
        border: Border.all(color: Colors.indigo),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(title,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black,
          )),
    );
  }
}
