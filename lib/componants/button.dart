import 'package:flutter/material.dart';

import '../constants.dart';

class Button extends StatelessWidget {
  Button({Key? key, required this.onPressed, required this.text})
      : super(key: key);
  final Function onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        side: BorderSide(width: 2, color: lightColor),
        fixedSize: const Size(150, 50),
        primary: primeColor,
        onPrimary: lightColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: onPressed(),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, letterSpacing: 2),
      ),
    );
  }
}
