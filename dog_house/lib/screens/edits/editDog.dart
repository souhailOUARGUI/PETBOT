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

class dogSettings extends StatefulWidget {
  const dogSettings({Key? key}) : super(key: key);

  @override
  State<dogSettings> createState() => _dogSettingsState();
}

class _dogSettingsState extends State<dogSettings> {
  late String _dogName;
  late String _username;
  late String _dogAge;
  late String _dogWeight;
  final TextEditingController _dNameController = TextEditingController();
  final TextEditingController _dAgeController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<customUser?>(context);

    Future? createDoc(
        {required String dogName,
        required String dogAge,
        required String dogWeight}) async {
      final _doc = FirebaseFirestore.instance
          .collection('users')
          .doc(_user!.uid)
          .collection('Dogs')
          .doc();
      final json = {
        'name': dogName,
        'age': int.parse(dogAge),
        'weight': double.parse(dogWeight),
      };
      await _doc.update(json);
      showToast('Pet infos Succesfully Updated  ');
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            child: Column(
          children: [
            TextFormField(
              onChanged: (value) {
                setState(() {
                  _dogName = value;
                });
              },
              controller: _dNameController,
              decoration: InputDecoration(hintText: 'Dog Name'),
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  _dogAge = value;
                });
              },
              controller: _dAgeController,
              decoration: InputDecoration(hintText: 'Dog Age'),
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  _dogWeight = value;
                });
              },
              controller: _usernameController,
              decoration: InputDecoration(hintText: 'Dog Weight'),
            ),
            ElevatedButton(
                onPressed: () {
                  createDoc(
                      dogName: _dogName,
                      dogAge: _dogAge,
                      dogWeight: _dogWeight);
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
