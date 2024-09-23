import 'package:flutter/material.dart';

class RoundedWidget extends StatelessWidget {
  RoundedWidget({super.key, required this.child});

  final double _elevation = 5.0;
  final ShapeBorderClipper clipper = ShapeBorderClipper(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)));
  final Color color = Colors.black38;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PhysicalShape(
        clipper: clipper,
        color: color,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
          child: child,
        ));
  }
}
