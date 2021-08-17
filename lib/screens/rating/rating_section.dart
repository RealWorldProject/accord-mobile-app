import 'package:accord/screens/home/book_view/rating_stars.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:flutter/material.dart';

class RatingSection extends StatefulWidget {
  const RatingSection({Key key}) : super(key: key);

  @override
  _RatingSectionState createState() => _RatingSectionState();
}

class _RatingSectionState extends State<RatingSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 22),
      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text("4.0",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 57),),
          CustomText(
            textToShow: "3.5",
            fontSize: 56,
          ),
          RatingStars(3.5,60),
          CustomText(
            textToShow: "based on 56 reviews",
            fontSize: 14,
            fontWeight: FontWeight.bold,
            textColor: Colors.grey[600],
          ),
          Divider(
            height: 35,
            thickness: 1,
            indent: 12,
            endIndent: 12,
            color: Color(0xffcdcdcd),
          ),
        ],
      ),
    );
  }
}
