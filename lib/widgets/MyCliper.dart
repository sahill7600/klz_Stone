import 'dart:ui';

import 'package:flutter/material.dart';

class MyCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height - 20);

    var firstControlPoint1 = new Offset(-10, size.height + 20);
    var firstEndPoint1 = new Offset(10, size.height - 20);
    path.quadraticBezierTo(firstControlPoint1.dx, firstControlPoint1.dy,
        firstEndPoint1.dx, firstEndPoint1.dy);
    var firstControlPoint = new Offset(size.width / 4.8, size.width / 5);
    var firstEndPoint = new Offset(size.width / 1.5, size.height / 6);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width, size.height / 10);
    var secondEndPoint = Offset(size.width, -20);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
