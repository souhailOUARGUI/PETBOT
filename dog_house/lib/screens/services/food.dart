import 'dart:ui';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:dog_house/screens/services/water.dart';
import 'package:dog_house/auth/authentication_service.dart';
import 'package:lottie/lottie.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({Key? key}) : super(key: key);

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  AuthService _auth = AuthService();
  double heating = 23.0;
  bool IsActive = false;
  bool _isElevated = false;
  bool isAuto = false;
  final ref = FirebaseDatabase.instance.reference();
  DatabaseReference foodRef =
      FirebaseDatabase.instance.ref("Flutter_ESP_Actions/Food");

  //Food action
  void foodAction() async {
    await foodRef.update({
      "food": "on",
    });
  }

  void autoFoodAction() async {
    isAuto
        ? await foodRef.update({
            "autoMode": "on",
          })
        : await foodRef.update({
            "autoMode": "off",
          });
  }

  Future<void> _activateListeners() async {
    await ref
        .child('Flutter_ESP_Actions/Food/autoMode')
        .onValue
        .listen((event) {
      final Object? _watermode = event.snapshot.value;
      setState(() {
        isAuto = _watermode.toString() == "on" ? true : false;
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
                          Navigator.pop(context);
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
                'Pet Food',
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
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Lottie.asset(
                      'assets/images/hungry_dog1.json',
                      width: 200,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  _showSnackBar(
                      context: context, text: 'Food is dropping into the Bowl');
                  setState(() {
                    foodAction();
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[500]!,
                          offset: const Offset(4, 4),
                          blurRadius: 15,
                          spreadRadius: 1),
                      BoxShadow(
                          spreadRadius: 1,
                          blurRadius: 15,
                          color: Colors.white,
                          offset: Offset(-4, -4))
                    ],
                  ),
                  width: 250,
                  height: 70,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 15.0),
                      child: const Text(
                        'Click to fulfill Food Bowl',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Sora',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.indigo,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.indigo.withOpacity(0.4),
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
                          'Turn On/Off Auto Mode',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Sora',
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Switch.adaptive(
                            value: isAuto,
                            activeColor: Colors.white,
                            onChanged: (bool newValue) {
                              setState(() {
                                isAuto = newValue;
                                autoFoodAction();
                              });
                            }),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar({required BuildContext context, required String text}) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green,
      content: Text(
        text,
        style: TextStyle(fontSize: 17),
      ),
      action: SnackBarAction(
        label: 'Dismiss',
        textColor: Colors.yellow,
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
