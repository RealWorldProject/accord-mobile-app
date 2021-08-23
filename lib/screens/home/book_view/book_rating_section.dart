import 'package:accord/constant/accord_colors.dart';
import 'package:accord/constant/accord_labels.dart';
import 'package:accord/models/review.dart';
import 'package:accord/screens/rating/review_view_section.dart';
import 'package:accord/screens/rating/view_ratings_and_reviews_screen.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/screens/widgets/error_displayer.dart';
import 'package:accord/utils/exposer.dart';
import 'package:accord/viewModel/book_view_model.dart';
import 'package:accord/viewModel/review_view_model.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class BookRatingSection extends StatelessWidget {
  const BookRatingSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ReviewViewModel reviewViewModel = context.read<ReviewViewModel>();

    reviewViewModel.fetchCurrentBookReview(
        bookID: context.read<BookViewModel>().activeBook.id);

    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                textToShow: AccordLabels.ratingAndReviewTitle,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                textColor: AccordColors.semi_dark_blue_color,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ViewRatingsAndReviewsScreen(),
                    ));
                  },
                  icon: Icon(LineIcons.arrowRight))
            ],
          ),
          Consumer<ReviewViewModel>(
            builder: (context, reviewViewModel, child) {
              switch (reviewViewModel.fetchReviewData.status) {
                case Status.LOADING:
                  return Container();
                case Status.COMPLETE:
                  List<Review> partialReviews =
                      reviewViewModel.currentBookReviews.take(3).toList();
                  return ListView.builder(
                    padding: EdgeInsets.only(top: 10, left: 0, right: 0),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                        partialReviews.isEmpty ? 1 : partialReviews.length,
                    itemBuilder: (context, index) => partialReviews.isEmpty
                        ? Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            child: CustomText(
                              textToShow:
                                  "This book has not received any review yet.",
                              fontSize: 16,
                              letterSpacing: -1,
                              fontWeight: FontWeight.w500,
                              textColor: Colors.black45,
                            ),
                          )
                        : ReviewDisplayFormat(
                            review: partialReviews[index],
                            isActiveUserReview: false,
                          ),
                  );
                case Status.ERROR:
                  return ErrorDisplayer(
                    error: reviewViewModel.fetchReviewData.message,
                    retryOption: () {
                      reviewViewModel.resetAllValues();
                      reviewViewModel.fetchCurrentBookReview();
                    },
                  );
                default:
                  return null;
              }
            },
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewRatingsAndReviewsScreen(),
                  ));
            },
            child: Consumer<ReviewViewModel>(
              builder: (context, reviewViewModel, child) {
                return reviewViewModel.currentBookReviews != null
                    ? reviewViewModel.currentBookReviews.length >= 3
                        ? CustomText(
                            textToShow: AccordLabels.viewMore,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            textColor: Colors.blue,
                          )
                        : Container()
                    : Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
