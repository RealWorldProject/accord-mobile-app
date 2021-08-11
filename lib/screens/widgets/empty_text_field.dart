import 'package:flutter/material.dart';
class EmptyTextField extends StatelessWidget {

  final VoidCallback toggleRemoveText;

  EmptyTextField ({
    this.toggleRemoveText
});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.grey),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      onPressed: toggleRemoveText,
      child: Icon(Icons.highlight_remove_rounded),
    );
  }
}
