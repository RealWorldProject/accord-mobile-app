import 'package:accord/screens/rating/add_review/add_rating_and_review.dart';
import 'package:accord/screens/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ReviewBottomSheet extends StatelessWidget {
  final String buttonText;
  final ButtonType buttonType;
  final VoidCallback buttonAction;

  const ReviewBottomSheet({
    this.buttonText,
    this.buttonType = ButtonType.ROUNDED_EDGE,
    this.buttonAction,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: CustomButton(
          height: 45,
          buttonLabel: buttonText,
          textSize: 18,
          buttonType: buttonType,
          triggerAction: () => buttonAction(),
        ),
      ),
    ]);
  }
}
