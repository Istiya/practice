import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;
  final ButtonStyle style =
  ElevatedButton.styleFrom(foregroundColor: Colors.black, backgroundColor: Colors.black12, textStyle: const TextStyle(fontSize: 20));


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, style: style, child: Text(text));
  }

}