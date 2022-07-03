import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              Colors.indigo,
              Colors.indigoAccent,
              Colors.blueAccent,
              Colors.blue,
              Colors.cyan
            ]),
      ),
      child: SpinKitSpinningLines(
        duration: Duration(seconds: 2),
        color: Colors.white,
        size: 50,
      ),
    );
  }
}
