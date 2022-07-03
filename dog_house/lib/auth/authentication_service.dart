// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:dog_house/auth/database.dart';
import 'package:dog_house/models/user.dart';
import 'package:dog_house/screens/services/home.dart';
import 'package:dog_house/screens/services/water.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:dog_house/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  customUser? _userFromFirebaseUser(User? user) {
    return user != null ? customUser(uid: user.uid) : null;
  }

  Stream<customUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future loginAno() async {
    try {
      loadingToast();
      UserCredential _userCre = await _auth.signInAnonymously();
      User user = _userCre.user!;
      return _userFromFirebaseUser(user);
      // return Home();
      // User user = _userCre.user!;
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future SignIn({required String email, required String password}) async {
    try {
      loadingToast();
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      print(' errorrr :${e}');
      if (e.code == 'invalid-email') {
        showToast('Invalid Email');
      } else if (e.code == 'wrong-password') {
        showToast('wrong Password');
      } else {
        showToast('Something went wrong');
      }
    }
  }

  // Future SignUp({required String email, required String password}) async {
  //   try {
  //     loadingToast();
  //     UserCredential result = await _auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //     User user = result.user!;

  //     await DatabaseService(uid: user.uid).updateUserData('souhail', 'Pet', 7);
  //     return _userFromFirebaseUser(user);
  //   } on FirebaseAuthException catch (e) {
  //     print(' errorrr :${e.code}');
  //     if (e.code == 'invalid-email') {
  //       showToast('Invalid Email');
  //     } else {
  //       showToast('Something went wrong');
  //     }
  //     return null;
  //   }
  // }
  Future SignUp(
      {required String username,
      required String email,
      required String password}) async {
    try {
      loadingToast();
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;

      await DatabaseService(uid: user.uid).updateUserData(username, 0, 0);

      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      print(' errorrr :${e.code}');
      if (e.code == 'invalid-email') {
        showToast('Invalid Email');
      } else {
        showToast('Something went wrong');
      }
      return null;
    }
  }

  Future SignOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        fontSize: 18,
        timeInSecForIosWeb: 2,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }

  void loadingToast() {
    Fluttertoast.showToast(
        msg: 'Please Wait... ',
        fontSize: 18,
        timeInSecForIosWeb: 1,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.blueAccent,
        textColor: Colors.white);
  }

  void cancelToast() => Fluttertoast.cancel();
}
