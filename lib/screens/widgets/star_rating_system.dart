import 'package:accord/viewModel/review_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class StarRatingSystem extends StatelessWidget {
  const StarRatingSystem({
    Key key,
    this.isEditable = true,
    this.ratingPoint = 0,
    this.starSize = 60,
  }) : super(key: key);

  /// defines if the rating system is editable.
  ///
  /// default is true
  final bool isEditable;

  /// defines the number of start to be coloured in the system.
  ///
  /// default set to 0.
  final double ratingPoint;

  /// size of stars.
  ///
  /// default set to 60.
  final double starSize;

  @override
  Widget build(BuildContext context) {
    // differentiate either to send exact number like [3.0, 4.0]
    // or half number like [1.5, 2.5]
    // gets exact number if decimal point (1 decimal point) is less than 5
    // and half number if it is greater that 5.
    double starRatingPoint =
        int.parse(ratingPoint.toString().split('.').last) < 5
            ? double.parse(ratingPoint.toString().split('.').first + ".0")
            : double.parse(ratingPoint.toString().split('.').first + ".5");

    return RatingBar(
      ignoreGestures: !isEditable,
      glowColor: Colors.yellowAccent,
      initialRating: starRatingPoint,
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
        context.read<ReviewViewModel>().setUserRating(rating);
      },
      itemSize: starSize,
    );
  }
}

// class RateBook extends StatefulWidget {
//   const RateBook({Key key}) : super(key: key);

//   @override
//   _RateBookState createState() => _RateBookState();
// }

// class _RateBookState extends State<RateBook> {
//   static const bool isEditable = true;
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: RatingBar(
//         ignoreGestures: isEditable,
//         glowColor: Colors.yellowAccent,
//         initialRating: 2.5,
//         direction: Axis.horizontal,
//         allowHalfRating: true,
//         itemCount: 5,
//         ratingWidget: RatingWidget(
//           full: Icon(
//             Icons.star_rounded,
//             color: Color(0xffffbb00),
//           ),
//           half: Icon(
//             Icons.star_half_rounded,
//             color: Color(0xffffbb00),
//           ),
//           empty: Icon(
//             Icons.star_border_rounded,
//             color: Color(0xffffbb00),
//           ),
//         ),
//         itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
//         onRatingUpdate: (rating) {
//           print(rating);
//         },
//         itemSize: 60,
//       ),
//     );
//   }
// }
