import 'package:dog_house/auth/authentication_service.dart';
import 'package:dog_house/screens/First_info_Input/UserInput.dart';
import 'package:dog_house/screens/home.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:dog_house/screens/services/food.dart';
import 'package:dog_house/screens/services/light.dart';
import 'package:dog_house/screens/services/temperature.dart';
import 'package:dog_house/screens/services/water.dart';
import 'package:dog_house/auth/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_house/auth/userlist.dart';
import '../../auth/user.dart';
import '../../models/user.dart';
import '../edits/addDogHouse.dart';
import '../edits/editUser.dart';

class FirstInfoInput extends StatefulWidget {
  const FirstInfoInput({Key? key}) : super(key: key);

  @override
  State<FirstInfoInput> createState() => _FirstInfoInputState();
}

class _FirstInfoInputState extends State<FirstInfoInput> {
  AuthService _auth = AuthService();

  final ref = FirebaseDatabase.instance.reference();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String myId = '';
  String myUsername = '';

  // void _getData() async {
  //   User? __user = _firebaseAuth.currentUser;
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(__user!.uid)
  //       .snapshots()
  //       .listen((userData) {
  //     setState(() {
  //       myUsername = userData.data()!['name'];
  //     });
  //   });
  // }

  //Bottom sheet
  void _showSheetPanel(Widget w) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade300,
            ),
            height: 500,
            child: w,
          );
        });
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _getData();
  //   print('here the naaame $myUsername');
  // }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<customUser?>(context);
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
                      },
                      icon: Icon(Icons.logout_sharp, color: Colors.indigo),
                      label: Text(
                        'logout',
                        style: TextStyle(color: Colors.indigo),
                      )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Hello $myUsername',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.indigo.shade700,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                        blurRadius: 20,
                        color: Colors.grey.shade500,
                        offset: Offset(5, 10))
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'My name is PetBot, your Pet breeding assistant   ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.indigo.shade700,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Before using me, Please Enter Some infos about your Pet Below',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.indigo.shade700,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 100,
              ),
              _ListContainer(title: 'Enter general infos', widget: UserInput()),
              SizedBox(
                height: 20,
              ),
              _ListContainer(title: 'Add a PetHouse', widget: addDogHouse()),
              SizedBox(
                height: 70,
              ),
              Center(
                child: ElevatedButton.icon(
                  label: Text(
                    "Homepage",
                    style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                  icon: Icon(Icons.home),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => Home())));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _ListContainer({required String title, required Widget widget}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.indigo.shade200,
              Colors.indigo.shade300,
              Colors.indigo.shade400
            ]),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 25, fontFamily: 'Montserrat', color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                _showSheetPanel(widget);
              },
              icon: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
