import 'package:flutter/material.dart';

class EntryTextField extends StatelessWidget {
  const EntryTextField(
      {super.key, required this.hintText, this.obscureText = false, required this.controller});

  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          filled: true,
          hintText: hintText,
        ),
        maxLines: 1,
        obscureText: obscureText,
        controller: controller,
      ),
    );
  }
}
