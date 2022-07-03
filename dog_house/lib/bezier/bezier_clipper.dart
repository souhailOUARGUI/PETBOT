import 'package:flutter/material.dart';

class BezierClipper extends CustomClipper<Path> {
  final double progress;
  BezierClipper(this.progress);

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;

  @override
  Path getClip(Size size) {
    Path path = Path();
    final double artboardW = 414 + (0) * progress;
    final double artboardH = 363.15 + (-61.45999999999998) * progress;
    final double _xScaling = size.width / artboardW;
    final double _yScaling = size.height / artboardH;
    path.lineTo((0 + (0) * progress) * _xScaling,
        (341.78499999999997 + (-123.94399999999996) * progress) * _yScaling);
    path.cubicTo(
      (0 + (0) * progress) * _xScaling,
      (341.78499999999997 + (-123.94399999999996) * progress) * _yScaling,
      (23.465 + (-4.3210000000000015) * progress) * _xScaling,
      (363.15099999999995 + (-97.231) * progress) * _yScaling,
      (71.55699999999999 + (-4.319999999999993) * progress) * _xScaling,
      (363.15099999999995 + (-97.231) * progress) * _yScaling,
    );
    path.cubicTo(
      (119.649 + (-4.319000000000017) * progress) * _xScaling,
      (363.15099999999995 + (-97.231) * progress) * _yScaling,
      (142.221 + (-29.465000000000003) * progress) * _xScaling,
      (300.186 + (-65.57499999999999) * progress) * _yScaling,
      (203.299 + (-29.462000000000018) * progress) * _xScaling,
      (307.21 + (-65.57499999999999) * progress) * _yScaling,
    );
    path.cubicTo(
      (264.377 + (-29.45900000000003) * progress) * _xScaling,
      (314.234 + (-65.57499999999999) * progress) * _yScaling,
      (282.66999999999996 + (-9.799999999999955) * progress) * _xScaling,
      (333.47299999999996 + (-31.781999999999982) * progress) * _yScaling,
      (338.412 + (-9.800000000000011) * progress) * _xScaling,
      (333.47299999999996 + (-31.781999999999982) * progress) * _yScaling,
    );
    path.cubicTo(
      (394.154 + (-9.800000000000068) * progress) * _xScaling,
      (333.47299999999996 + (-31.781999999999982) * progress) * _yScaling,
      (414 + (0) * progress) * _xScaling,
      (254.199 + (-52.22200000000001) * progress) * _yScaling,
      (414 + (0) * progress) * _xScaling,
      (254.199 + (-52.22200000000001) * progress) * _yScaling,
    );
    path.cubicTo(
      (414 + (0) * progress) * _xScaling,
      (254.199 + (-52.22200000000001) * progress) * _yScaling,
      (414 + (0) * progress) * _xScaling,
      (0 + (0) * progress) * _yScaling,
      (414 + (0) * progress) * _xScaling,
      (0 + (0) * progress) * _yScaling,
    );
    path.cubicTo(
      (414 + (0) * progress) * _xScaling,
      (0 + (0) * progress) * _yScaling,
      (2.1316282072803006e-14 + (0) * progress) * _xScaling,
      (0 + (0) * progress) * _yScaling,
      (2.1316282072803006e-14 + (0) * progress) * _xScaling,
      (0 + (0) * progress) * _yScaling,
    );
    path.cubicTo(
      (2.1316282072803006e-14 + (0) * progress) * _xScaling,
      (0 + (0) * progress) * _yScaling,
      (0 + (0) * progress) * _xScaling,
      (341.78499999999997 + (-123.94399999999996) * progress) * _yScaling,
      (0 + (0) * progress) * _xScaling,
      (341.78499999999997 + (-123.94399999999996) * progress) * _yScaling,
    );
    return path;
  }
}
