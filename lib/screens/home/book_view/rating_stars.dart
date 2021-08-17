import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final double size;

  RatingStars(this.rating, this.size);

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
      wrapAlignment: WrapAlignment.start,
      tapOnlyMode: false,
      ignoreGestures: true,
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

      itemPadding: EdgeInsets.zero,

      // onRatingUpdate: (rating) {
      //   print(rating);
      // },
      itemSize: size,
    );
  }
}
