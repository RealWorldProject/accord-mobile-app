import 'dart:convert';
import 'dart:developer';

import 'package:accord/models/review.dart';
import 'package:accord/responses/review_response.dart';
import 'package:accord/services/review_service.dart';
import 'package:accord/utils/current_user.dart';
import 'package:accord/utils/exposer.dart';
import 'package:flutter/foundation.dart';

class ReviewViewModel extends ChangeNotifier {
  List<Review> _currentBookReviews;
  List<Review> get currentBookReviews => _currentBookReviews;

  Review _userReviewOnActiveBook;
  Review get userReviewOnActiveBook => _userReviewOnActiveBook;

  int _totalReviewsOnActiveBook;
  int get totalReviewsOnActiveBook => _totalReviewsOnActiveBook;

  double _overallRatingsOnActiveBook;
  double get overallRatingsOnActiveBook => _overallRatingsOnActiveBook;

  double _userRating;
  double get userRating => _userRating;

  ResponseExposer _data;
  ResponseExposer get data => _data;

  ResponseExposer _fetchReviewData;
  ResponseExposer get fetchReviewData => _fetchReviewData;

  /// sets rating for a book.
  void setUserRating(rating) {
    _userRating = rating;
  }

  /// post reviews
  Future<void> postReview({String bookID, String review}) async {
    // sets status to [LOADING]
    _data = ResponseExposer.loading();

    try {
      // api call to post review
      var res = await ReviewService().postReview(bookID, review);

      // conversion: json response to object response
      var responseObj = ReviewResponse.fromJson(jsonDecode(res));

      // processed and sent [Review] by api is assigned to [userReviewOnActionBook]
      _userReviewOnActiveBook = responseObj.result;
      print(inspect(responseObj));

      print(_overallRatingsOnActiveBook);

      // also, incresing the total review count by 1.
      _totalReviewsOnActiveBook++;

      // calculating the new [overallRatingOnActiveBook] after current user's review.
      _overallRatingsOnActiveBook =
          ((_overallRatingsOnActiveBook * (_totalReviewsOnActiveBook - 1)) +
                  _userReviewOnActiveBook.rating) /
              _totalReviewsOnActiveBook;

      // sets status to [COMPLETE]
      _data = ResponseExposer.complete(responseObj.message);
    } catch (e) {
      // sets status to [ERROR]
      _data = ResponseExposer.error(e.toString());
    }

    notifyListeners();
  }

  /// post reviews
  Future<void> fetchCurrentBookReview({String bookID}) async {
    resetAllValues();

    // sets status to [LOADING]
    _fetchReviewData = ResponseExposer.loading();

    try {
      // api call to fetch given book's reviews
      var res = await ReviewService().fetchCurrentBookReview(bookID);

      // conversion: json response to object response
      var responseObj = MultipleReviewResponse.fromJson(jsonDecode(res));

      // adds [List<Review>] from response obj to [currentBookReviews]
      _currentBookReviews = responseObj.result.reversed.toList();

      // assign overall count of reviews to [totalReviewOnActiveBook]
      _totalReviewsOnActiveBook = responseObj.total;

      // calculating the overall rating for the given book.
      _overallRatingsOnActiveBook = _currentBookReviews.fold(
              0, (previousValue, review) => previousValue + review.rating) /
          _totalReviewsOnActiveBook;

      // if current user has reviewed the book, put them separately.
      String currentUser = await CurrentUser.get();

      // gets the index of the review given by current user.
      int userReviewIndex = _currentBookReviews
          .indexWhere((review) => currentUser == review.user.id);

      if (userReviewIndex != -1) {
        // gets the review given by current user.
        _userReviewOnActiveBook = _currentBookReviews[userReviewIndex];

        // removes the review given by current user from overall reviews list.
        _currentBookReviews.removeAt(userReviewIndex);
      }

      // sets status to [COMPLETE]
      _fetchReviewData = ResponseExposer.complete(responseObj.message);
    } catch (e) {
      // sets status to [ERROR]
      _fetchReviewData = ResponseExposer.error(e.toString());
    }

    notifyListeners();
  }

  /// resets all values to null.
  void resetAllValues() {
    _currentBookReviews = null;
    _userReviewOnActiveBook = null;
    _totalReviewsOnActiveBook = null;
    _userRating = null;
  }
}
