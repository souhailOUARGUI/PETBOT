import 'dart:ui';

import 'package:dog_house/auth/Login_Signup.dart';
import 'package:dog_house/screens/services/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dog_house/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (var i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
          color: isActive ? Colors.white : Color(0xFF7B51D3),
          borderRadius: BorderRadius.circular(12)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                    0.1,
                    0.4,
                    0.7,
                    0.9
                  ],
                  colors: [
                    Color(0xFF3594DD),
                    Color(0xFF4563DB),
                    Color(0xFF5036d5),
                    Color(0xFF5b16D0),
                  ]),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginSignup()));
                          },
                          child: Text(
                            'Skip',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontFamily: 'sans_serif'),
                          )),
                    ),
                    Container(
                      height: 600.0,
                      child: PageView(
                        physics: ClampingScrollPhysics(),
                        controller: _pageController,
                        onPageChanged: (page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Image(
                                    image: AssetImage(
                                        'assets/images/human-dog.png'),
                                    height: 300.0,
                                    width: 300.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 120.0,
                                ),
                                Text(
                                    'Welcome to DOGBOT, your doghouse conroller',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30.0,
                                      fontFamily: 'sans_serif',
                                    ),
                                    textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Image(
                                    image:
                                        AssetImage('assets/images/dog_3d.png'),
                                    height: 300.0,
                                    width: 300.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 130.0,
                                ),
                                Text(
                                    'This App will help you track your dog activity wherever you are ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22.0,
                                      fontFamily: 'Sora',
                                    ),
                                    textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Image(
                                    image: AssetImage(
                                        'assets/images/dog_walk.png'),
                                    height: 300.0,
                                    width: 300.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 130.0,
                                ),
                                Text(
                                    'Watch over your dog just by having few clicks',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontFamily: 'Sora',
                                    ),
                                    textAlign: TextAlign.center),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildPageIndicator(),
                    ),
                    _currentPage != _numPages - 1
                        ? Expanded(
                            child: Align(
                            alignment: FractionalOffset.bottomRight,
                            child: FlatButton(
                                onPressed: () {
                                  _pageController.nextPage(
                                    duration: Duration(milliseconds: 150),
                                    curve: Curves.ease,
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      'Next',
                                      style: TextStyle(
                                          fontFamily: 'sans_serif',
                                          fontSize: 22,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 30.0,
                                    )
                                  ],
                                )),
                          ))
                        : Container(),
                  ]),
            ),
          )),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: 100.0,
              width: double.infinity,
              color: Colors.white,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginSignup()));
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                          color: Color(0xFF5B16D0),
                          fontFamily: 'sans_serif',
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }
}
