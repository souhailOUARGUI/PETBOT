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

class UserInput extends StatefulWidget {
  const UserInput({Key? key}) : super(key: key);

  @override
  State<UserInput> createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  late String _newUserName;
  late String _username;
  late String _dogNum;
  late String _dHouseNum;
  final TextEditingController _dNameController = TextEditingController();
  final TextEditingController _dAgeController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<customUser?>(context);

    Future? createDoc(
        {required String dogNum, required String dogHouseNum}) async {
      final _doc =
          FirebaseFirestore.instance.collection('users').doc(_user!.uid);
      final json = {
        'petnum': int.parse(dogNum),
        'dHouseNum': double.parse(dogHouseNum),
      };
      await _doc.update(json);
      showToast('Info Succssfully updated');
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            child: Column(
          children: [
            // TextFormField(
            //   onChanged: (value) {
            //     setState(() {
            //       _newUserName = value;
            //     });
            //   },
            //   controller: _dNameController,
            //   decoration: InputDecoration(hintText: 'Update Username'),
            // ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  _dogNum = value;
                });
              },
              controller: _dAgeController,
              decoration: InputDecoration(hintText: 'How much Pets you have?'),
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  _dHouseNum = value;
                });
              },
              controller: _usernameController,
              decoration:
                  InputDecoration(hintText: 'How much DogHouses you have?'),
            ),
            ElevatedButton(
                onPressed: () {
                  createDoc(dogNum: _dogNum, dogHouseNum: _dHouseNum);
                },
                child: Icon(Icons.add)),
            SizedBox(
              height: 200,
            )
          ],
        )),
      ),
    );
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        fontSize: 18,
        timeInSecForIosWeb: 2,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.cyan,
        textColor: Colors.white);
  }

  void cancelToast() => Fluttertoast.cancel();
}
