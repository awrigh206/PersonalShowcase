import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  final animationValue;
  final heightAnimationValue;
  final double rightShift = 200;

  const WaveClipper(this.animationValue, this.heightAnimationValue);
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height);

    var firstStart = Offset(size.width / 5 - animationValue, size.height);
    //fist point of quadratic bezier curve
    var firstEnd = Offset(
        (size.width / 2.25) + rightShift - animationValue, size.height - 50.0);
    //second point of quadratic bezier curve
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart = Offset(
        size.width - (size.width / 3.24) + rightShift - animationValue,
        size.height - 80);
    //third point of quadratic bezier curve
    var secondEnd = Offset(size.width, size.height - 10);
    //fourth point of quadratic bezier curve
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
