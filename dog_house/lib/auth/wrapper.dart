import 'package:dog_house/auth/Login_Signup.dart';

import 'package:dog_house/models/user.dart';
import 'package:dog_house/screens/First_info_Input/First_info_input.dart';
import 'package:dog_house/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dog_house/auth/authenticate.dart';
import 'authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:dog_house/models/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<customUser?>(context);
    print(user);
    if (user == null) {
      return Authenticate();
    }
    return Home();
  }
}
