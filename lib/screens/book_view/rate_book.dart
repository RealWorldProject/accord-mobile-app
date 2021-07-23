import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateBook extends StatefulWidget {
  const RateBook({Key key}) : super(key: key);

  @override
  _RateBookState createState() => _RateBookState();
}

class _RateBookState extends State<RateBook> {
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: RatingBar(
        initialRating: 0,
        direction: Axis.horizontal,
        allowHalfRating: false,
        itemCount: 5,
        ratingWidget: RatingWidget(
          full: Icon(Icons.star_rate_rounded,),
          empty: Icon(Icons.star_outline_rounded,),
        ),
        itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
        onRatingUpdate: (rating) {
          print(rating);
        },
        itemSize: 32,
      ),
    );
  }
}
