import 'dart:ui';
import 'package:dog_house/auth/authentication_service.dart';
import 'package:dog_house/models/doghouses.dart';
import 'package:dog_house/screens/Views/dogHouseCard.dart';
import 'package:dog_house/screens/edits/editDog.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../edits/addDog.dart';
import '../edits/addDogHouse.dart';

class dogHouseView extends StatefulWidget {
  const dogHouseView({Key? key}) : super(key: key);

  @override
  State<dogHouseView> createState() => _dogHouseViewState();
}

class _dogHouseViewState extends State<dogHouseView> {
  AuthService _auth = AuthService();

  final ref = FirebaseDatabase.instance.reference();
  List<Object> _dHouseList = [];

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

  Future getDogHousesList() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('DogHouses')
        .get();
    // print('heyeye ${data.docs[1].id}');
    setState(() {
      _dHouseList = List.from(data.docs.map((e) => dogHouses.fromSnapshot(e)));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDogHousesList();
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
                  // GestureDetector(
                  //   onTap: () => Navigator.pop(context),
                  //   child: const Icon(
                  //     Icons.arrow_back_ios,
                  //     color: Colors.indigo,
                  //   ),
                  // ),
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
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PetHouse List',
                    style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 40,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                        shadows: [
                          Shadow(
                              color: Colors.black.withOpacity(0.3),
                              offset: const Offset(0, 5),
                              blurRadius: 15),
                        ]),
                  ),
                  // IconButton(
                  //     onPressed: () {
                  //       setState(() {
                  //         initState();
                  //       });
                  //     },
                  //     icon: Icon(
                  //       Icons.refresh,
                  //       color: Colors.grey.shade800,
                  //     ))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 10,
              ),
              _ListContainer(title: 'Add Pet infos', widget: addDog()),
              SizedBox(
                height: 10,
              ),
              _ListContainer(title: 'Add PetHouse info', widget: addDogHouse()),
              SizedBox(
                height: 20,
              ),
              SizedBox(height: 50),
              Expanded(
                child: ListView.builder(
                    itemCount: _dHouseList.length,
                    itemBuilder: (context, index) {
                      return dogHouseCard(
                          dHouse: _dHouseList[index] as dogHouses);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        fontSize: 18,
        timeInSecForIosWeb: 2,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.lightGreen,
        textColor: Colors.white);
  }

  void cancelToast() => Fluttertoast.cancel();
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
