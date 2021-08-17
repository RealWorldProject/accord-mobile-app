import 'package:accord/constant/accord_labels.dart';
import 'package:accord/screens/rating/rating_section.dart';
import 'package:accord/screens/rating/review_bottom_sheet.dart';
import 'package:accord/screens/rating/review_section.dart';
import 'package:accord/screens/widgets/custom_app_bar.dart';
import 'package:accord/screens/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class RatingAndReveiwScreen extends StatefulWidget {
  const RatingAndReveiwScreen({Key key}) : super(key: key);

  @override
  _RatingAndReveiwScreenState createState() => _RatingAndReveiwScreenState();
}

class _RatingAndReveiwScreenState extends State<RatingAndReveiwScreen> {
  final bool isEditable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          title: "Rating & Reviews",
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.only(bottom: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [RatingSection(), ReviewSection()],
          ),
        ),
      ),
      bottomSheet: ReviewBottomSheet(
        buttonText: !isEditable
            ? AccordLabels.addReviewButtonTitle
            : AccordLabels.editReviewButtonTitle,
        buttonType: ButtonType.OUTLINED,
      ),
    );
  }
}
