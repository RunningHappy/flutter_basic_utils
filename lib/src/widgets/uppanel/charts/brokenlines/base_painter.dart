import 'package:flutter/material.dart';

abstract class BasePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size);

  @override
  bool shouldRepaint(CustomPainter oldDelegate);
}
