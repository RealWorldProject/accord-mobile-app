import 'package:accord/constant/accord_labels.dart';
import 'package:accord/models/book.dart';
import 'package:accord/screens/rating/add_review/add_rating_and_review.dart';
import 'package:accord/screens/rating/rating_view_section.dart';
import 'package:accord/screens/rating/review_bottom_sheet.dart';
import 'package:accord/screens/rating/review_view_section.dart';
import 'package:accord/screens/widgets/custom_app_bar.dart';
import 'package:accord/screens/widgets/custom_button.dart';
import 'package:accord/screens/widgets/error_displayer.dart';
import 'package:accord/utils/exposer.dart';
import 'package:accord/viewModel/book_view_model.dart';
import 'package:accord/viewModel/review_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewRatingsAndReviewsScreen extends StatefulWidget {
  const ViewRatingsAndReviewsScreen({Key key}) : super(key: key);

  @override
  _ViewRatingsAndReviewsScreenState createState() =>
      _ViewRatingsAndReviewsScreenState();
}

class _ViewRatingsAndReviewsScreenState
    extends State<ViewRatingsAndReviewsScreen> {
  ReviewViewModel reviewViewModel;
  Book book;

  @override
  void initState() {
    reviewViewModel = context.read<ReviewViewModel>();
    book = context.read<BookViewModel>().activeBook;

    reviewViewModel.fetchCurrentBookReview(bookID: book.id);
    super.initState();
  }

  bool isEditable = true;

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).padding;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          title: AccordLabels.ratingAndReviewTitle,
          backButton: true,
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.only(bottom: 80),
          child: Consumer<ReviewViewModel>(
            builder: (context, reviewViewModel, child) {
              switch (reviewViewModel.fetchReviewData.status) {
                case Status.LOADING:
                  return Container(
                    height: MediaQuery.of(context).size.height -
                        padding.top -
                        padding.bottom -
                        kToolbarHeight -
                        kBottomNavigationBarHeight,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.grey,
                      ),
                    ),
                  );
                case Status.COMPLETE:
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RatingSection(),
                      ReviewViewSection(),
                    ],
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
                  return Container();
              }
            },
          ),
        ),
      ),
      bottomSheet: ReviewBottomSheet(
        buttonText: !isEditable
            ? AccordLabels.addReviewLabel
            : AccordLabels.editReviewLabel,
        buttonType: ButtonType.OUTLINED,
        buttonAction: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => PostRatingAndReview())),
      ),
    );
  }
}
