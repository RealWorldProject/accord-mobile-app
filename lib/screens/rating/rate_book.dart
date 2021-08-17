import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateBook extends StatefulWidget {
  const RateBook({Key key}) : super(key: key);

  @override
  _RateBookState createState() => _RateBookState();
}

class _RateBookState extends State<RateBook> {
  static const bool isEditable = true;
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: RatingBar(
        initialRating: isEditable?3.5:0,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        ratingWidget: RatingWidget(
          full: Icon(
            Icons.star_rounded,
            color: Color(0xffffbb00),
          ),
          half: Icon(
            Icons.star_half_rounded,
            color: Color(0xffffbb00),
          ),
          empty: Icon(
            Icons.star_border_rounded,
            color: Color(0xffffbb00),
          ),
        ),
        itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
        onRatingUpdate: (rating) {
          print(rating);
        },
        itemSize: 60,
      ),
    );
  }
}
