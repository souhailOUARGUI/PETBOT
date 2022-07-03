import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dog_house/screens/services/home.dart';
import 'package:dog_house/auth/Login_Signup.dart';
import 'package:dog_house/auth/userlist.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _DecisonsTreeState();
}

class _DecisonsTreeState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return LoginSignup();
  }
}
