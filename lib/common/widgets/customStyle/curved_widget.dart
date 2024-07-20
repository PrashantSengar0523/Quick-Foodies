import 'package:flutter/material.dart';

class CustomCurvedEdge extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    var firstControlPoint = Offset(0, size.height-20);
    var firstEndPoint = Offset(30, size.height-20);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(0, size.height-20);
    var secondEndPoint = Offset(size.width-30, size.height - 20);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    var thirdControlPoint = Offset(size.width, size.height-20);
    var thirdEndPoint = Offset(size.width, size.height);

    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy, thirdEndPoint.dx, thirdEndPoint.dy);

    path.lineTo(size.width, 0);
    
    return path;
  }

  @override
  bool shouldReclip(CustomCurvedEdge oldClipper) {
    return true;
  }
}
