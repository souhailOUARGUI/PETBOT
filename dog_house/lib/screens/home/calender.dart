import 'dart:ui';
import 'package:dog_house/auth/authentication_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:babylonjs_viewer/babylonjs_viewer.dart';
import 'package:lottie/lottie.dart';

class CalenderPage extends StatefulWidget {
  const CalenderPage({Key? key}) : super(key: key);

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  AuthService _auth = AuthService();
  double heating = 23.0;
  bool switchIsActive = false;
  bool _isElevated = false;
  late bool lampActive = true;

  final ref = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BabylonJSViewer(
        src: 'assets/images/doghouse4.glb',
      ),
    );
    // return Scaffold(
    //   backgroundColor: Colors.indigo.shade50,
    //   body: SafeArea(
    //     child: Container(
    //       margin: const EdgeInsets.only(top: 18, left: 24, right: 24),
    //       child: Column(
    //         children: [
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               GestureDetector(
    //                 onTap: () => Navigator.pop(context),
    //                 child: const Icon(
    //                   Icons.arrow_back_ios,
    //                   color: Colors.indigo,
    //                 ),
    //               ),
    //               FlatButton.icon(
    //                   onPressed: () async {
    //                     try {
    //                       await _auth.SignOut();
    //                     } catch (e) {
    //                       print(e.toString());
    //                     }
    //                   },
    //                   icon: Icon(Icons.logout_sharp, color: Colors.indigo),
    //                   label: Text(
    //                     'logout',
    //                     style: TextStyle(color: Colors.indigo),
    //                   )),
    //             ],
    //           ),
    //           BabylonJSViewer(
    //             src: 'assets/images/dog.glb',
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
