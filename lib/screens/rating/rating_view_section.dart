import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/screens/widgets/star_rating_system.dart';
import 'package:accord/viewModel/review_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RatingSection extends StatefulWidget {
  const RatingSection({Key key}) : super(key: key);

  @override
  _RatingSectionState createState() => _RatingSectionState();
}

class _RatingSectionState extends State<RatingSection> {
  @override
  Widget build(BuildContext context) {
    // total number of reviews for the give book.
    int totalReviewsOnActiveBook =
        context.read<ReviewViewModel>().totalReviewsOnActiveBook;

    // total ratings for the given book.
    double overallRatingsOnActiveBook =
        context.read<ReviewViewModel>().overallRatingsOnActiveBook;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 22),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            textToShow: overallRatingsOnActiveBook.toStringAsFixed(1),
            fontSize: 56,
          ),
          StarRatingSystem(
            ratingPoint:
                double.parse(overallRatingsOnActiveBook.toStringAsFixed(1)),
            isEditable: false,
          ),
          CustomText(
            textToShow: "based on $totalReviewsOnActiveBook reviews",
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
