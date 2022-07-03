import 'dart:ui';
import 'package:dog_house/auth/authentication_service.dart';
import 'package:dog_house/screens/edits/addDog.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:dog_house/models/user.dart';
import 'package:dog_house/screens/edits/editDog.dart';
import 'package:dog_house/screens/edits/addDogHouse.dart';
import 'package:dog_house/screens/edits/editUser.dart';

class profilPage extends StatefulWidget {
  const profilPage({Key? key}) : super(key: key);

  @override
  State<profilPage> createState() => _profilPageState();
}

class _profilPageState extends State<profilPage> {
  AuthService _auth = AuthService();
  double heating = 23.0;
  bool switchIsActive = false;
  bool _isElevated = false;
  late bool lampActive = true;
  late String _dogName;
  late String _username;
  late String _dogAge;
  late String _dogWeight;
  final TextEditingController _dNameController = TextEditingController();
  final TextEditingController _dAgeController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
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

  final ref = FirebaseDatabase.instance.reference();
  @override
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<customUser?>(context);

    Future? createDoc(
        {required String dogName,
        required String dogAge,
        required String dogWeight}) async {
      final _doc =
          FirebaseFirestore.instance.collection('Dogs').doc(_user!.uid);
      final json = {
        'name': dogName,
        'age': int.parse(dogAge),
        'weight': double.parse(dogWeight),
      };
      await _doc.set(json);
    }

    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(top: 18, left: 24, right: 24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(''),
                    // GestureDetector(
                    //   onTap: () => Navigator.,
                    //   child: const Icon(
                    //     Icons.arrow_back_ios,
                    //     color: Colors.indigo,
                    //   ),
                    // ),
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
                  'Personal Info',
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
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 40,
                ),
                Center(
                    child: Stack(
                  children: [
                    Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                          color: Colors.indigo.shade50,
                          border: Border.all(
                            width: 2,
                            color: Colors.white,
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.indigo.shade100,
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle),
                      child: Image.asset('assets/images/DOG1.png',
                          scale: 1, height: 18, width: 180),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 2, color: Colors.white),
                              color: Colors.blueAccent),
                          child: Icon(Icons.edit, color: Colors.white),
                        ))
                  ],
                )),
                SizedBox(
                  height: 100,
                ),
                _ListContainer(
                    title: 'Edit Personal info', widget: UserSettings()),

                // SizedBox(
                //   height: 10,
                // ),
                // _ListContainer(title: 'Edit Pet infos', widget: addDog()),
                // SizedBox(
                //   height: 10,
                // ),
                // _ListContainer(
                //     title: 'Edit PetHouse info', widget: addDogHouse()),
                // SizedBox(
                //   height: 10,
                // ),
              ],
            ),
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
