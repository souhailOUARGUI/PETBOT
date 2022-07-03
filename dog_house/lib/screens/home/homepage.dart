import 'package:dog_house/auth/authentication_service.dart';
import 'package:dog_house/screens/First_info_Input/First_info_input.dart';
import 'package:dog_house/screens/services/food.dart';
import 'package:dog_house/screens/services/light.dart';
import 'package:dog_house/screens/services/temperature.dart';
import 'package:dog_house/screens/services/water.dart';
import 'package:flutter/material.dart';
import 'package:dog_house/auth/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_house/auth/userlist.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../auth/user.dart';
import '../../models/user.dart';
import 'package:lottie/lottie.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');
  // static User fromJson(Map<String, dynamic> json) {
  //   return User(
  //       name: json['name'],
  //       dHouseNum: json['dHouseNum'],
  //       petNum: json['petNum']);
  // }

  // Stream<List<User>> readUsers() {
  //   return FirebaseFirestore.instance.collection('users').snapshots().map(
  //       (snapshot) =>
  //           snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
  // }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String myId = '';
  String myUsername = '';

  void _getData() async {
    User? __user = _firebaseAuth.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(__user!.uid)
        .snapshots()
        .listen((userData) {
      setState(() {
        myUsername = userData.data()!['name'];
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
    print('here the naaame $myUsername');
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<customUser?>(context);
    Stream<QuerySnapshot> readItem() {
      CollectionReference _ref =
          _usersCollection.doc(_user!.uid).collection('name');
      return _ref.snapshots();
    }

    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 18, left: 24, right: 24),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                'Hi $myUsername',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Titillium',
                ),
              ),
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
              // RotatedBox(
              //     quarterTurns: 135,
              //     child: Icon(
              //       Icons.bar_chart_rounded,
              //       color: Colors.indigo,
              //       size: 28,
              //     ))
            ]),
            Expanded(
                child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Center(
                  child: Text(
                    'PETBOT',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                      shadows: [
                        Shadow(
                            blurRadius: 15,
                            color: Colors.cyan,
                            offset: Offset(1, 4))
                      ],
                      color: Colors.indigo,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Center(
                  child: Lottie.asset('assets/images/lottie_home1.json',
                      height: 300, width: 300),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    'Your Pet SmartHouse',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                      color: Colors.indigo,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Center(
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 15.0),
                      child: const Text(
                        'Services',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'DM_sans',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _cardMenuLottie(
                        title: 'LIGHT',
                        icon: 'assets/images/lottie_light.json',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LightPage()));
                        }),
                    _cardMenuLottie(
                        title: 'TEMPERATURE',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TemperaturePage(),
                              ));
                        },
                        icon: 'assets/images/temp.json',
                        color: Colors.indigo,
                        fontColor: Colors.white),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _cardMenuLottie(
                        title: 'WATER',
                        icon: 'assets/images/water.json',
                        onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WaterPage()))
                            }),
                    _cardMenuLottie(
                        title: 'FOOD',
                        icon: 'assets/images/food.json',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FoodPage()));
                        }),
                  ],
                ),
              ],
            ))
          ]),
        ),
      ),
    );
  }

  Widget _cardMenu({
    required String title,
    required String icon,
    onTap,
    Color color = Colors.white,
    Color fontColor = Colors.grey,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 36),
        width: 156,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: color,
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
          children: [
            Image.asset(
              icon,
              height: 90,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, color: fontColor),
            )
          ],
        ),
      ),
    );
  }

  Widget _cardMenuSVG({
    required String title,
    required String icon,
    onTap,
    Color color = Colors.white,
    Color fontColor = Colors.grey,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 36),
        width: 156,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: color,
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
          children: [
            SvgPicture.asset(
              icon,
              height: 90,
              color: Colors.white,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, color: fontColor),
            )
          ],
        ),
      ),
    );
  }

  Widget _cardMenuLottie({
    required String title,
    required String icon,
    onTap,
    Color color = Colors.white,
    Color fontColor = Colors.grey,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 36),
        width: 156,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: color,
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
          children: [
            Lottie.asset(
              icon,
              height: 90,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, color: fontColor),
            )
          ],
        ),
      ),
    );
  }

  void _showSnackBar({required BuildContext context, required String text}) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.amberAccent,
      content: Text(
        text,
        style: TextStyle(fontSize: 17),
      ),
      action: SnackBarAction(
        label: 'Dismiss',
        textColor: Colors.black,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => FirstInfoInput())));
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
