import 'dart:math';

import 'package:flutter/material.dart';

class CircularRevealClipper extends CustomClipper<Path> {
  final double progress;

  CircularRevealClipper(this.progress);

  @override
  Path getClip(Size size) {
    double maxRadius = sqrt(size.width * size.width + size.height * size.height);
    double radius = progress * maxRadius;

    Path path = Path()..addOval(Rect.fromCircle(center: Offset(size.width / 1.5, size.height), radius: radius));

    if (progress >= 1.0) {
      path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    }

    return path;
  }

  @override
  bool shouldReclip(CircularRevealClipper oldClipper) {
    return progress != oldClipper.progress;
  }
}
