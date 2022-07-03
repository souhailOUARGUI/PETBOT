import 'dart:ui';
import 'package:dog_house/auth/authentication_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:dog_house/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';

class addDogHouse extends StatefulWidget {
  const addDogHouse({Key? key}) : super(key: key);

  @override
  State<addDogHouse> createState() => _addDogHouseState();
}

class _addDogHouseState extends State<addDogHouse> {
  late String _dogHouseName;
  late String _username;
  final TextEditingController _dNameController = TextEditingController();
  final TextEditingController _dAgeController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<customUser?>(context);

    Future? createDoc({
      required String dHouseName,
    }) async {
      final _doc = FirebaseFirestore.instance
          .collection('users')
          .doc(_user!.uid)
          .collection('DogHouses')
          .doc();
      final json = {
        'name': dHouseName,
      };
      await _doc.set(json);
      // final _docId = _doc.id;
      // print('before toast $_docId');
      showToast('DogHouse Added');
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
          child: Column(
        children: [
          TextFormField(
            onChanged: (value) {
              setState(() {
                _dogHouseName = value;
              });
            },
            controller: _dNameController,
            decoration: InputDecoration(hintText: 'DogHouse Name'),
          ),
          ElevatedButton(
              onPressed: () {
                createDoc(dHouseName: _dogHouseName);
              },
              child: Icon(Icons.add)),
        ],
      )),
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
}
