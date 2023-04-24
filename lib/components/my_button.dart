import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final Widget child;

  const MyButton({super.key, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromRGBO(143, 148, 251, .7),Color.fromRGBO(143, 148, 251, 1), Color.fromRGBO(143, 148, 251, .7),],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: child
          ),
        ),
      );
  }
}
