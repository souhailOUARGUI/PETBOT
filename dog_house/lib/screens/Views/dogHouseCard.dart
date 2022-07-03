import 'dart:ui';
import 'package:dog_house/auth/authentication_service.dart';
import 'package:dog_house/models/doghouses.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/user.dart';

class dogHouseCard extends StatelessWidget {
  final dogHouses dHouse;
  dogHouseCard({required this.dHouse});

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<customUser?>(context);
    Future? DeleteDoc({
      required String uid,
    }) async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_user!.uid)
          .collection('DogHouses')
          .doc(uid)
          .delete();
      ;

      // print('before toast $_docId');
      // showToast('DogHouse Added');
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            color: Colors.indigo.shade100,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(blurRadius: 5, spreadRadius: 1, color: Colors.blueGrey)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  '${dHouse.name}\'s PetHouse',
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 16),
                ),
                // Text(
                //   'uid: ${dHouse.uid}',
                //   style: TextStyle(fontFamily: 'Montserrat', fontSize: 16),
                // ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward)),
                IconButton(
                    onPressed: () {
                      DeleteDoc(uid: dHouse.uid);
                      showToast('PetHouse deleted');
                    },
                    icon: Icon(Icons.delete)),
              ],
            ),
          ],
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
        backgroundColor: Colors.cyan,
        textColor: Colors.white);
  }

  void cancelToast() => Fluttertoast.cancel();
}
