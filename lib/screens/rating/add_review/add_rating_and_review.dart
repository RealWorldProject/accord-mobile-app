import 'dart:convert';

import 'package:accord/constant/accord_colors.dart';
import 'package:accord/constant/accord_labels.dart';
import 'package:accord/models/review.dart';
import 'package:accord/screens/widgets/custom_app_bar.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/screens/widgets/custom_text_field.dart';
import 'package:accord/screens/widgets/information_dialog_box.dart';
import 'package:accord/screens/widgets/loading_indicator.dart';
import 'package:accord/screens/widgets/star_rating_system.dart';
import 'package:accord/utils/exposer.dart';
import 'package:accord/viewModel/book_view_model.dart';
import 'package:accord/viewModel/review_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../review_bottom_sheet.dart';

class PostRatingAndReview extends StatefulWidget {
  const PostRatingAndReview({
    Key key,
  }) : super(key: key);

  @override
  _PostRatingAndReviewState createState() => _PostRatingAndReviewState();
}

class _PostRatingAndReviewState extends State<PostRatingAndReview> {
  final TextEditingController reviewController = TextEditingController();

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          title: AccordLabels.addReviewScreenTitle,
          backButton: true,
        ),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Rating section
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    textToShow: AccordLabels.rateBookSectionLabel,
                    textColor: AccordColors.full_dark_blue_color,
                    fontSize: 18,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 25),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: StarRatingSystem(),
                    ),
                  )
                ],
              ),
            ),

            // Review section
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    textToShow: AccordLabels.addReviewLabel,
                    textColor: AccordColors.full_dark_blue_color,
                    fontSize: 18,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: CustomTextField(
                      fieldController: reviewController,
                      noOfLines: 12,
                      designType: DesignType.BORDER,
                      designTypeBorderRadius: 20,
                      contentVerticalPadding: 10,
                      hintText:
                          "Would you like to leave your experience about the book?",
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: ReviewBottomSheet(
        buttonText: AccordLabels.postReviewButtonLabel,
        buttonAction: postReview,
      ),
    );
  }

  Future<void> postReview() async {
    FocusScope.of(context).unfocus();
    loadingIndicator(context);

    final ReviewViewModel reviewViewModel = context.read<ReviewViewModel>();

    Review review = Review(
      rating: reviewViewModel.userRating ?? 0,
      review: reviewController.text,
    );

    String reviewJson = jsonEncode(review);

    await reviewViewModel.postReview(
      bookID: context.read<BookViewModel>().activeBook.id,
      review: reviewJson,
    );

    Navigator.of(context, rootNavigator: true).pop();

    if (reviewViewModel.data.status == Status.COMPLETE) {
      Navigator.of(context).pop();
    } else if (reviewViewModel.data.status == Status.ERROR) {
      showDialog(
        context: context,
        builder: (context) => InformationDialogBox(
          contentType: ContentType.ERROR,
          content: reviewViewModel.data.message,
          actionText: AccordLabels.tryAgain,
        ),
      );
    }
  }
}
