import 'package:flutter/material.dart';

class ConcealPassword extends StatelessWidget {
  // toggles passward texts between visibile and invisible
  // takes two parameters, a boolean value and toggler function.
  final bool obscurePassword;
  final VoidCallback toggleConceal;

  ConcealPassword({
    this.obscurePassword,
    this.toggleConceal,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.grey),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      onPressed: toggleConceal,
      child: (obscurePassword)
          ? Icon(Icons.visibility_off)
          : Icon(Icons.visibility),
    );
  }
}
