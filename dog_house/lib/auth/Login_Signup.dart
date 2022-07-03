import 'package:dog_house/auth/authentication_service.dart';
import 'package:dog_house/auth/loading.dart';
import 'package:flutter/material.dart';
import 'package:dog_house/bezier/bezier_clipper.dart';
import 'package:dog_house/main.dart';
import 'package:dog_house/onboarding_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../screens/services/home.dart';

class LoginSignup extends StatefulWidget {
  // final Function(User) onSignInAno;
  // LoginSignup({required this.onSignInAno});
  @override
  _LoginSignupState createState() => _LoginSignupState();
}

class _LoginSignupState extends State<LoginSignup>
    with TickerProviderStateMixin {
  final AuthService _auth = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late String _email;
  late String _password;
  late String _registerEmail;
  late String _registerPassword;
  late String _registerUsername;
  final _formKey = GlobalKey<FormState>();
  String _loginError = '';
  String _registerError = '';
  bool _loading = false;

  bool isFinalState = false;
  AnimationController? _controller;
  Animation<double>? _animation;
  final PageController _LoginPageController = PageController(initialPage: 0);
  int _currentPage = 0;
  bool _login = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  _toggle() {
    setState(() {
      isFinalState = !isFinalState;
      if (!isFinalState)
        _controller!.reverse(from: 1.0);
      else
        _controller!.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.indigo.shade50,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: <Widget>[
                      AnimatedBuilder(
                          animation: _controller!,
                          builder: (context, anim) {
                            final double progress = _animation!.value;
                            final double heightScaling =
                                0.405 + (0.337 - 0.405) * progress;
                            final double height =
                                MediaQuery.of(context).size.height *
                                    heightScaling;
                            return ClipPath(
                              clipper: BezierClipper(progress),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Colors.indigo,
                                        Colors.indigoAccent,
                                        Colors.blue,
                                        Colors.lightBlue
                                      ]),
                                ),
                                height: height,
                                width: double.infinity,
                                child: Center(
                                    child: Image.asset(
                                        'assets/images/login_logo.png')),
                              ),
                            );
                          }),
                      // Container(
                      //     child: Center(
                      //   child: RaisedButton(
                      //     child: Text("Toggle"),
                      //     onPressed: _toggle,
                      //   ),
                      // )),
                    ],
                  ),
                  _login
                      ? Container(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: GestureDetector(
                                    onTap: _toggle,
                                    child: Text(
                                      'Welcome back',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'sign into your account',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.grey[700]),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 10,
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    offset: Offset(1, 1))
                                              ]),
                                          child: TextFormField(
                                            validator: (value) => value!.isEmpty
                                                ? 'Enter a valid Email'
                                                : null,
                                            onChanged: ((value) {
                                              setState(() {
                                                _email = value.trim();
                                              });
                                            }),
                                            //controller: emailController,
                                            decoration: InputDecoration(
                                                hintText: 'Email',
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            BorderSide(
                                                                color:
                                                                    Colors
                                                                        .indigo,
                                                                width: 2)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white))),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 10,
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    offset: Offset(1, 1))
                                              ]),
                                          child: TextFormField(
                                            validator: (value) =>
                                                value!.length < 6
                                                    ? 'Enter more than 6 digits'
                                                    : null,
                                            onChanged: ((value) {
                                              setState(() {
                                                _password = value.trim();
                                              });
                                            }),
                                            //controller: passwordController,
                                            obscureText: true,
                                            decoration: InputDecoration(
                                                hintText: 'Password',
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            BorderSide(
                                                                color:
                                                                    Colors
                                                                        .indigo,
                                                                width: 2)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white))),
                                          ),
                                        ),
                                      ],
                                    )),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Text(
                                      'Forgot your password?',
                                      style: TextStyle(
                                          fontFamily: 'Sora',
                                          fontSize: 16,
                                          color: Colors.grey[700]),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  _loginError,
                                  style: TextStyle(color: Colors.red),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        // setState(() => _loading = true);

                                        dynamic result = _auth.SignIn(
                                            email: _email, password: _password);
                                        // print('outer code');
                                        if (result == false) {
                                          print('after error');
                                          setState(() {
                                            _loginError =
                                                'Please supply a valid email';
                                            _loading = false;
                                          });
                                        }
                                      }
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        width: 150,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              Colors.lightBlue,
                                              Colors.blue,
                                              // Colors.indigoAccent
                                            ]),
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            border: Border.all(
                                                color: Colors.blueAccent)),
                                        child: Text(
                                          'Sign in',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'sans_serif',
                                              fontSize: 24),
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _toggle();
                                    setState(() {
                                      _login = !_login;
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: RichText(
                                          text: TextSpan(
                                              text:
                                                  "Don\'t have an account yet?",
                                              style: TextStyle(
                                                  fontFamily: 'Sora',
                                                  fontSize: 16,
                                                  color: Colors.grey[700]),
                                              children: [
                                                TextSpan(
                                                    text: ' Create',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Sora',
                                                        color: Colors.blue))
                                              ]),
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: GestureDetector(
                                    onTap: () async {
                                      //setState(() => _loading = true);
                                      dynamic result = await _auth.loginAno();
                                      if (result == null) {
                                        setState(() => _loading = false);
                                        print('error signing in');
                                      } else {
                                        print(result);
                                        print(result.uid);
                                      }
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        width: 200,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  spreadRadius: 1,
                                                  blurRadius: 5,
                                                  color: Colors.grey,
                                                  offset: Offset(0, 3))
                                            ],
                                            gradient: LinearGradient(colors: [
                                              Colors.lightBlue,
                                              Colors.blue,
                                              // Colors.indigoAccent
                                            ]),
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            border: Border.all(
                                              color: Colors.blueAccent,
                                            )),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Icon(
                                              Icons.person_add_rounded,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              'Guest Login',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal,
                                                  fontFamily: 'sans_serif',
                                                  fontSize: 24),
                                            ),
                                          ],
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: GestureDetector(
                                    onTap: _toggle,
                                    child: Text(
                                      'Welcome',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 50,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Create a new account',
                                    style: TextStyle(
                                        fontFamily: 'Sora',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[700]),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 10,
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    offset: Offset(1, 1))
                                              ]),
                                          child: TextFormField(
                                            validator: (value) => value!.isEmpty
                                                ? 'Enter a valid name'
                                                : null,
                                            onChanged: (value) {
                                              setState(() {
                                                _registerUsername =
                                                    value.trim();
                                              });
                                            },
                                            decoration: InputDecoration(
                                                hintText: 'Username',
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            BorderSide(
                                                                color:
                                                                    Colors
                                                                        .indigo,
                                                                width: 2)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white))),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 10,
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    offset: Offset(1, 1))
                                              ]),
                                          child: TextFormField(
                                            validator: (value) => value!.isEmpty
                                                ? 'Enter a valid Email'
                                                : null,
                                            onChanged: (value) {
                                              setState(() {
                                                _registerEmail = value.trim();
                                              });
                                            },
                                            decoration: InputDecoration(
                                                hintText: 'Email',
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            BorderSide(
                                                                color:
                                                                    Colors
                                                                        .indigo,
                                                                width: 2)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white))),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 10,
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    offset: Offset(1, 1))
                                              ]),
                                          child: TextFormField(
                                            validator: (value) =>
                                                value!.length < 6
                                                    ? 'Enter more than 6 digits'
                                                    : null,
                                            onChanged: (value) {
                                              setState(() {
                                                _registerPassword =
                                                    value.trim();
                                              });
                                            },
                                            obscureText: true,
                                            decoration: InputDecoration(
                                                hintText: 'Password',
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            BorderSide(
                                                                color:
                                                                    Colors
                                                                        .indigo,
                                                                width: 2)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white))),
                                          ),
                                        ),
                                      ],
                                    )),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  _registerError,
                                  style: TextStyle(color: Colors.red),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (_formKey.currentState!.validate()) {
                                        //setState(() => _loading = true);
                                        dynamic result = _auth.SignUp(
                                            username: _registerUsername,
                                            email: _registerEmail,
                                            password: _registerPassword);
                                        if (result == null) {
                                          setState(() {
                                            _registerError =
                                                'Please supply a valid email';
                                            _loading = false;
                                          });
                                        }
                                      }
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        width: 150,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              Colors.lightBlue,
                                              Colors.blue,
                                              // Colors.indigoAccent
                                            ]),
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            border: Border.all(
                                                color: Colors.blueAccent)),
                                        child: Text(
                                          'Sign up',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'sans_serif',
                                              fontSize: 24),
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _toggle();
                                    setState(() {
                                      _login = !_login;
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: RichText(
                                          text: TextSpan(
                                              text:
                                                  "Already having an account ?",
                                              style: TextStyle(
                                                  fontFamily: 'Sora',
                                                  fontSize: 16,
                                                  color: Colors.grey[700]),
                                              children: [
                                                TextSpan(
                                                    text: ' Log in',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Sora',
                                                        color: Colors.blue))
                                              ]),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                ],
              ),
            ),
          );
  }
}
