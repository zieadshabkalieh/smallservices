import 'package:flutter/material.dart';

Widget otpTextButton(String text, VoidCallback onPressed) {
  return TextButton(
    onPressed: onPressed,
    child: Text(
      text,
      style: TextStyle(
        backgroundColor: Colors.grey.shade50,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: const Color(0xFFFFC727),
      ),
    ),
  );
}
