import 'package:accord/constant/accord_colors.dart';
import 'package:accord/constant/accord_labels.dart';
import 'package:accord/models/review.dart';
import 'package:accord/screens/rating/add_edit_rating_and_review.dart';
import 'package:accord/screens/widgets/avatar_displayer.dart';
import 'package:accord/screens/widgets/custom_bottom_sheet.dart';
import 'package:accord/screens/widgets/custom_dialog_box.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/screens/widgets/information_dialog_box.dart';
import 'package:accord/screens/widgets/star_rating_system.dart';
import 'package:accord/utils/exposer.dart';
import 'package:accord/utils/text_utils.dart';
import 'package:accord/utils/time_calculator.dart';
import 'package:accord/viewModel/book_view_model.dart';
import 'package:accord/viewModel/provider/button_loading_provider.dart';
import 'package:accord/viewModel/review_view_model.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReviewViewSection extends StatefulWidget {
  const ReviewViewSection({Key key}) : super(key: key);

  @override
  _ReviewViewSectionState createState() => _ReviewViewSectionState();
}

class _ReviewViewSectionState extends State<ReviewViewSection> {
  final bool isMyReview = false;

  @override
  Widget build(BuildContext context) {
    final ReviewViewModel reviewViewModel = context.read<ReviewViewModel>();
    final List<Review> currentBookReviews = reviewViewModel.currentBookReviews;

    final Review activeUserReviewOnCurrentBook =
        reviewViewModel.userReviewOnActiveBook;

    return Column(
      children: [
        activeUserReviewOnCurrentBook == null
            ? Container()
            : activeUserReviewOnCurrentBook.book !=
                    context.read<BookViewModel>().activeBook.id
                ? Container()
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          textToShow: "Your review",
                          textColor: Colors.grey[800],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ReviewDisplayFormat(
                          review: activeUserReviewOnCurrentBook,
                          isActiveUserReview: true,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: Colors.grey[900],
                        )
                      ],
                    ),
                  ),
        Container(
          alignment: Alignment.bottomLeft,
          margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 15),
          child: Column(
            children: [
              CustomText(
                textToShow: "All reviews",
                textColor: Colors.grey[800],
              ),
            ],
          ),
        ),
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount:
                currentBookReviews.isEmpty ? 1 : currentBookReviews.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return currentBookReviews.isNotEmpty
                  ? ReviewDisplayFormat(
                      review: currentBookReviews[index],
                      isActiveUserReview: false,
                    )
                  : Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width,
                      child: CustomText(
                        textToShow:
                            reviewViewModel.userReviewOnActiveBook == null
                                ? "This book has not received any review yet."
                                : "Others have not reviewed this book yet.",
                        fontSize: 18,
                        letterSpacing: -1,
                        fontWeight: FontWeight.w500,
                        textColor: Colors.black45,
                      ),
                    );
            }),
      ],
    );
  }
}

class ReviewDisplayFormat extends StatelessWidget {
  const ReviewDisplayFormat({
    Key key,
    this.review,
    this.isActiveUserReview,
  }) : super(key: key);

  final Review review;
  final bool isActiveUserReview;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AvatarDisplayer(
                          avatarUrl: review.user.image,
                          radius: 28,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 9,
                    child: Container(
                      margin: EdgeInsets.only(top: 3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomText(
                            textToShow:
                                TextUtils().capitalizeAll(review.user.fullName),
                            fontSize: 14,
                            textColor: AccordColors.full_dark_blue_color,
                            fontWeight: FontWeight.w600,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              StarRatingSystem(
                                isEditable: false,
                                ratingPoint: review.rating,
                                starSize: 18,
                              ),
                            ],
                          ),
                          CustomText(
                            textToShow: TimeCalculator.getTimeDifference(
                                review.createdAt),
                            fontSize: 12,
                            textColor: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ),
                  !isActiveUserReview
                      ? Container()
                      : ClipOval(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) => CustomBottomSheet(
                                    // option 1
                                    option1: AccordLabels.editReviewLabel,
                                    iconOpt1: Icons.edit_rounded,
                                    action1: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            PostOrEditRatingAndReview(
                                          reviewAction: ReviewAction.UPDATE,
                                          ratingPoint: review.rating,
                                          review: review.review,
                                        ),
                                      ));
                                    },

                                    //option 2
                                    option2:
                                        AccordLabels.deleteReviewButtonTitle,
                                    iconOpt2: Icons.delete_forever_rounded,
                                    action2: () {
                                      showDialog(
                                          context: context,
                                          useRootNavigator: false,
                                          builder: (context) {
                                            return CustomDialogBox(
                                              content:
                                                  "Are you sure you want to delete your review?",
                                              neglectLabel: AccordLabels.keep,
                                              performLabel: AccordLabels.delete,
                                              performAction: () => deleteReview(
                                                  context, review.id),
                                            );
                                          });
                                    },
                                  ),
                                );
                              },
                              child: SizedBox(
                                width: 35,
                                height: 35,
                                child: Icon(
                                  Icons.more_vert,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ExpandableText(
                TextUtils.capitalize(review.review),
                expandText: null,
                animation: true,
                maxLines: 3,
                collapseOnTextTap: true,
                expandOnTextTap: true,
              ),
              isActiveUserReview
                  ? Container()
                  : Divider(
                      height: 35,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                      color: Color(0xffcdcdcd),
                    ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> deleteReview(BuildContext context, String reviewID) async {
    // [ButtonLoadingProvider] instance.
    var buttonLoadingProvider = context.read<ButtonLoadingProvider>();

    // sets [isLoading] to true.
    buttonLoadingProvider.setIsLoading();

    // [BookViewModel] instance.
    ReviewViewModel reviewViewModel = context.read<ReviewViewModel>();

    // api call to delete book.
    await reviewViewModel.deleteReview(reviewID: reviewID);

    // dialog box depending on the api result.
    if (reviewViewModel.data.status == Status.COMPLETE) {
      // sets [isLoading] to false
      buttonLoadingProvider.removeIsLoading();

      // closes in-effect dialog box.
      Navigator.of(context).pop();

      showDialog(
        context: context,
        builder: (context) => InformationDialogBox(
          contentType: ContentType.DONE,
          content: reviewViewModel.data.message,
          actionText: AccordLabels.okay,
        ),
      );
    } else {
      // sets [isLoading] to false
      buttonLoadingProvider.removeIsLoading();
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
