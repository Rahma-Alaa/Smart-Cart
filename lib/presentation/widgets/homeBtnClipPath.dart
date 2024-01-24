// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ClipPathBtn extends CustomClipper<Path> {
  String title;
  ClipPathBtn({required this.title});

  @override
  Path getClip(Size size) {
    final double startPoint, secondPoint, thirdPoint, endPoint;
    Path path = Path();

    startPoint = (title == "Invoices") ? size.width : 0.0;
    secondPoint = (title == "Invoices") ? 120.0 : 55.0;
    thirdPoint = (title == "Invoices") ? 100.0 : 70.0;
    endPoint = (title == "Invoices") ? size.width : 0.0;

    path.moveTo(startPoint, 0.0);
    path.lineTo(secondPoint, 0);
    path.lineTo(thirdPoint, size.height);
    path.lineTo(endPoint, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
