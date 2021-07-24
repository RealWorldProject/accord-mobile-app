import 'package:flutter/material.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';

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

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star_rate_rounded : Icons.star_border_rounded,
          size: 15,
          color: Colors.orange,
        );
      }),
    );
  }
}
