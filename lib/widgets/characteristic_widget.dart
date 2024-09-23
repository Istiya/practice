import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CharacteristicWidget extends StatelessWidget {
  const CharacteristicWidget(
      {super.key, required this.icon, required this.value});

  final IconData icon;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [Icon(icon), Text('$value')],
    );
  }
}
