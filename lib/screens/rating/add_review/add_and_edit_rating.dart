import 'package:accord/constant/accord_colors.dart';
import 'package:accord/screens/rating/rate_book.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
class AddAndEditRating extends StatefulWidget {
  const AddAndEditRating({Key key}) : super(key: key);

  @override
  _AddAndEditRatingState createState() => _AddAndEditRatingState();
}

class _AddAndEditRatingState extends State<AddAndEditRating> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomText(textToShow: "Rate the Book", textColor: AccordColors.full_dark_blue_color,fontSize: 18,),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 25),
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: RateBook(),
            ),
          )


        ],
      ),
    );
  }
}
