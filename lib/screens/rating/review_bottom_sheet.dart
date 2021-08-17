import 'package:accord/constant/accord_labels.dart';
import 'package:accord/screens/rating/add_review/add_rating_and_review.dart';
import 'package:accord/screens/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import 'edit_rating_and_review.dart';

class ReviewBottomSheet extends StatelessWidget {
  final String buttonText;
  final ButtonType buttonType;

  const ReviewBottomSheet({

    this.buttonText,
    this.buttonType = ButtonType.ROUNDED_EDGE,
  }) ;

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
            triggerAction: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddRatingAndReview()));
            },
          )),
    ]);
  }
}
