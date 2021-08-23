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
import 'package:accord/viewModel/provider/text_field_value_change_provider.dart';
import 'package:accord/viewModel/review_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'review_bottom_sheet.dart';

class PostOrEditRatingAndReview extends StatefulWidget {
  const PostOrEditRatingAndReview({
    Key key,
    this.reviewAction = ReviewAction.POST,
    this.ratingPoint = 0,
    this.review = "",
  }) : super(key: key);

  final ReviewAction reviewAction;
  final double ratingPoint;
  final String review;

  @override
  _PostOrEditRatingAndReviewState createState() =>
      _PostOrEditRatingAndReviewState();
}

class _PostOrEditRatingAndReviewState extends State<PostOrEditRatingAndReview> {
  final TextEditingController _reviewController = TextEditingController();
  double _userRating;
  TextFieldValueChangeProvider textChangeProvider;
  ReviewViewModel reviewViewModel;

  @override
  void initState() {
    // initializations.
    textChangeProvider = context.read<TextFieldValueChangeProvider>();
    reviewViewModel = context.read<ReviewViewModel>();
    _userRating = widget.ratingPoint;
    _reviewController.text = widget.review;

    // sets [valueChanged] to false.
    textChangeProvider.initializer();

    // for update: checks if the original review has been altered.
    // used for enabling/disabling update button.
    widget.reviewAction == ReviewAction.UPDATE
        ? widget.ratingPoint != _userRating
            ? textChangeProvider.setValueChanged()
            : _reviewController.addListener(() {
                _reviewController.text == ""
                    ? textChangeProvider.removeValueChange()
                    : _reviewController.text !=
                            context
                                .read<ReviewViewModel>()
                                .userReviewOnActiveBook
                                .review
                        ? textChangeProvider.setValueChanged()
                        : textChangeProvider.removeValueChange();
              })
        : null;
    super.initState();
  }

  @override
  void dispose() {
    _reviewController.dispose();
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
                      child: StarRatingSystem(
                        ratingPoint: widget.ratingPoint,
                      ),
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
                      fieldController: _reviewController,
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
        // alter button color according to the state of [userRating] & [valueChanged]
        buttonColor:
            widget.ratingPoint != context.watch<ReviewViewModel>().userRating ||
                    context.watch<TextFieldValueChangeProvider>().Valuechanged
                ? null
                : AccordColors.disabled_button_color,
        // alter button text according to [reviewAction] value
        buttonText: widget.reviewAction == ReviewAction.POST
            ? AccordLabels.postReviewButtonLabel
            : AccordLabels.editReviewLabel,
        // alter button funtion according to [reviewAction] value
        // if [reviewAction] is [UPDATE], futher alter button function
        // according to the state of [userRating] & [valueChanged].
        buttonAction: widget.reviewAction == ReviewAction.POST
            ? postReview
            : widget.ratingPoint !=
                        context.watch<ReviewViewModel>().userRating ||
                    context.watch<TextFieldValueChangeProvider>().Valuechanged
                ? editReview
                : () {},
      ),
    );
  }

  // method to post new review.
  Future<void> postReview() async {
    // removes focus from any textfield within the screen.
    FocusScope.of(context).unfocus();

    // display loading screen.
    loadingIndicator(context);

    // [Review] object with given values
    Review review = Review(
      rating: reviewViewModel.userRating ?? 0,
      review: _reviewController.text,
    );

    // json coversion of [Review] object
    String reviewJson = jsonEncode(review);

    // calls api to post [Review]
    await reviewViewModel.postReview(
      bookID: context.read<BookViewModel>().activeBook.id,
      review: reviewJson,
    );

    // closes screen after api call is finished.
    Navigator.of(context, rootNavigator: true).pop();

    // performs action according to the response status.
    if (reviewViewModel.data.status == Status.COMPLETE) {
      // closes screen if response status is [COMPLETE].
      Navigator.of(context).pop();
    } else if (reviewViewModel.data.status == Status.ERROR) {
      // displays error message if response status is [ERROR]
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

  // method to update user's existing review.
  Future<void> editReview() async {
    // removes focus from any textfield within the screen.
    FocusScope.of(context).unfocus();

    // display loading screen.
    loadingIndicator(context);

    // [Review] object with updated data
    Review updatedReview = Review(
      rating: reviewViewModel.userRating ?? 0,
      review: _reviewController.text,
    );

    // [Review] object's json conversion
    String updatedReviewJson = jsonEncode(updatedReview);

    // api call to update review
    await reviewViewModel.editReview(
      reviewID: reviewViewModel.userReviewOnActiveBook.id,
      updatedReview: updatedReviewJson,
    );

    // closes loading screen after api call is finished
    Navigator.of(context, rootNavigator: true).pop();

    // performs action according to the response status.
    if (reviewViewModel.data.status == Status.COMPLETE) {
      // closes screen if response status is [COMPLETE].
      Navigator.of(context).pop();

      // then, displays success message
      showDialog(
        context: context,
        builder: (context) => InformationDialogBox(
          contentType: ContentType.DONE,
          content: reviewViewModel.data.message,
          actionText: AccordLabels.okay,
        ),
      );
    } else if (reviewViewModel.data.status == Status.ERROR) {
      // displays error message if response status is [ERROR]
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

enum ReviewAction {
  /// used for adding new review
  POST,

  /// used for updating existing user's review.
  UPDATE,
}
