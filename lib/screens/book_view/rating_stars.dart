import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class RatingStars extends StatelessWidget {
  final double rating;

  RatingStars(this.rating);

  @override
  Widget build(BuildContext context) {
    // String stars = '';
    // for (int i = 0; i < rating; i++) {
    //   stars += '⭐';
    // }
    // stars.trim();
    // return Text(
    //   stars,
    //   style: TextStyle(
    //     fontSize: 12.0,
    //   ),
    // );

    return RatingBar(
    initialRating: rating,
    direction: Axis.horizontal,
    allowHalfRating: true,
    itemCount: 5,
    ratingWidget: RatingWidget(
    full: Icon(Icons.star_rate_rounded,color: Colors.orangeAccent,),
    half: Icon(Icons.star_half_rounded,color: Colors.orangeAccent,),
    empty: Icon(Icons.star_outline_rounded,color: Colors.orangeAccent,),
    ),
    itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
    // onRatingUpdate: (rating) {
    //   print(rating);
    // },
    itemSize: 18,
    );
  }
}
