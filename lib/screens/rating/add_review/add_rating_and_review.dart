import 'package:accord/constant/accord_labels.dart';
import 'package:accord/screens/rating/add_review/add_and_edit_book_detail.dart';
import 'package:accord/screens/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../review_bottom_sheet.dart';
import 'add_and_edit_rating.dart';
import 'add_and_edit_review.dart';

class AddRatingAndReview extends StatefulWidget {
  const AddRatingAndReview({Key key}) : super(key: key);

  @override
  _AddRatingAndReviewState createState() => _AddRatingAndReviewState();
}

class _AddRatingAndReviewState extends State<AddRatingAndReview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          title: "Add Rating & Reviews",
        ),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // AddAndEditBookDetail(),
            AddAndEditRating(),
            AddAndEditReview()
          ],
        ),
      ),
      bottomSheet: ReviewBottomSheet(
        buttonText: AccordLabels.submitReviewButtonTitle,
      ),
    );
  }
}
