import 'package:dog_house/auth/Login_Signup.dart';
import 'package:dog_house/auth/authentication_service.dart';

import 'package:flutter/material.dart';
import 'package:dog_house/auth/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_house/auth/user.dart';
import 'package:dog_house/auth/userlist.dart';
import 'usertile.dart';

class userLsit extends StatefulWidget {
  const userLsit({Key? key}) : super(key: key);

  @override
  State<userLsit> createState() => _userLsitState();
}

class _userLsitState extends State<userLsit> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<Userr>>(context);

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return UserTile(user: users[index]);
      },
    );
  }
}
