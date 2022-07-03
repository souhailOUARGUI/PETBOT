import 'package:dog_house/auth/Login_Signup.dart';
import 'package:dog_house/bezier/bezier_curve.dart';
import 'package:dog_house/screens/home/calender.dart';
import 'package:dog_house/screens/services/food.dart';
import 'package:dog_house/screens/home/homepage.dart';
import 'package:dog_house/screens/services/light.dart';
import 'package:dog_house/screens/services/temperature.dart';
import 'package:dog_house/screens/services/water.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../../bezier/bezier_curve.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 1;
  final items = const [
    Icon(
      Icons.camera,
      size: 30,
    ),
    Icon(
      Icons.home_filled,
      size: 30,
    ),
    Icon(
      Icons.calendar_today,
      size: 30,
    ),
    Icon(
      Icons.account_circle_rounded,
      size: 30,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        items: items,
        index: index,
        onTap: (newIndex) {
          setState(() {
            index = newIndex;
          });
        },
        height: 50,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.ease,
        animationDuration: const Duration(milliseconds: 300),
      ),
      backgroundColor: Colors.indigo.shade50,
      body: Container(
          color: Colors.indigo.shade50,
          alignment: Alignment.center,
          height: double.infinity,
          width: double.infinity,
          child: _getSelectedWidget(index: index)),
    );
  }

  Widget _getSelectedWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = LightPage();
        break;
      case 1:
        widget = const HomePage();
        break;
      case 2:
        widget = WaterPage();
        break;
      case 3:
        widget = const WaterPage();
        break;
      default:
        widget = const HomePage();
        break;
    }
    return widget;
  }
}
