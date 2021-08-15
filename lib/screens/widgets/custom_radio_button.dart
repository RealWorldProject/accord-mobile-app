import 'package:accord/screens/widgets/custom_label.dart';
import 'package:flutter/material.dart';

class CustomRadioButton<T> extends StatelessWidget {
  // returns a workable radion button
  // `value` represents the radion button's actual value.
  // `groupValue` represents the active radio button in the radio group.
  // `onChanged` is responsible for updating the `value` & `groupValue` when active radio button changes.
  // `text` represents the display name for the corresponding radio button.
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final String text;

  CustomRadioButton({
    this.value,
    this.groupValue,
    this.onChanged,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(0),
        child: Row(
          children: [
            Radio(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
            ),
            CustomText(
              textToShow: text,
              fontSize: 16,
            ),
          ],
        ),
      ),
    );
  }
}
