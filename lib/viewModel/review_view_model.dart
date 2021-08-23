import 'dart:convert';
import 'dart:developer';

import 'package:accord/models/review.dart';
import 'package:accord/responses/review_response.dart';
import 'package:accord/services/review_service.dart';
import 'package:accord/utils/current_user.dart';
import 'package:accord/utils/exposer.dart';
import 'package:flutter/foundation.dart';

class ReviewViewModel extends ChangeNotifier {
  /// holds the [List<Review>] associated with the active book.
  List<Review> get currentBookReviews => _currentBookReviews;
  List<Review> _currentBookReviews;

  /// holds a [Review] given by the active user on active book.
  Review get userReviewOnActiveBook => _userReviewOnActiveBook;
  Review _userReviewOnActiveBook;

  /// holds the total number of reviews received by the active book.
  int get totalReviewsOnActiveBook => _totalReviewsOnActiveBook;
  int _totalReviewsOnActiveBook;

  /// holds the overall ratings received by the active book.
  double get overallRatingsOnActiveBook => _overallRatingsOnActiveBook;
  double _overallRatingsOnActiveBook;

  /// holds the rating given by active user on active book.
  double _userRating;
  double get userRating => _userRating;

  /// holds response status for post api calls
  ResponseExposer _data;
  ResponseExposer get data => _data;

  /// holds response status for fetch api calls
  ResponseExposer _fetchReviewData;
  ResponseExposer get fetchReviewData => _fetchReviewData;

  /// sets rating for a book and notify its listeners to update.
  void setUserRating(rating) {
    _userRating = rating;
    notifyListeners();
  }

  /// just initialize rating when updating.
  void initializeUserRating(rating) {
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

  /// fetch reviews for the given book.
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
      _totalReviewsOnActiveBook = responseObj.total ?? 0;

      if (_currentBookReviews.isNotEmpty) {
        // calculating the overall rating for the given book.
        _overallRatingsOnActiveBook = _currentBookReviews.fold(
                0, (previousValue, review) => previousValue + review.rating) /
            _totalReviewsOnActiveBook;
      } else if (_currentBookReviews.isEmpty) {
        _overallRatingsOnActiveBook = 0;
      }

      // if current user has reviewed the book, put them separately.
      String currentUser = await CurrentUser.get();

      // gets the index of the review given by current user.
      int userReviewIndex = _currentBookReviews
          .indexWhere((review) => currentUser == review.user.id);

      if (userReviewIndex != -1) {
        // gets the review given by current user.
        _userReviewOnActiveBook = _currentBookReviews[userReviewIndex];

        _userRating = _userReviewOnActiveBook.rating;

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

  /// edit user's review
  Future<void> editReview({String reviewID, String updatedReview}) async {
    // sets status to [LOADING]
    _data = ResponseExposer.loading();

    try {
      // api call to edit review
      var res = await ReviewService().editReview(reviewID, updatedReview);

      // conversion: json response to object response
      var responseObj = ReviewResponse.fromJson(jsonDecode(res));

      // saves the old rating before updating [userReviewOnActiveBook].
      var oldRating = _userReviewOnActiveBook.rating;

      // updated [Review] from api is assigned to [userReviewOnActionBook]
      _userReviewOnActiveBook = responseObj.result;

      // calculating the new [overallRatingOnActiveBook] after updating review.
      _overallRatingsOnActiveBook =
          (((_overallRatingsOnActiveBook * _totalReviewsOnActiveBook) -
                      oldRating) +
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

  /// delete user's review
  Future<void> deleteReview({String reviewID}) async {
    // sets status to [LOADING]
    _data = ResponseExposer.loading();

    try {
      // api call to delete review
      var res = await ReviewService().deleteReview(reviewID);

      // conversion: json response to object response
      var responseObj = ReviewResponse.fromJson(jsonDecode(res));

      // subtracts user's rating from overallRating
      // then, calculated new overall rating.
      _overallRatingsOnActiveBook = ((_overallRatingsOnActiveBook *
                  _totalReviewsOnActiveBook) -
              _userReviewOnActiveBook.rating) /
          (_totalReviewsOnActiveBook > 1 ? (_totalReviewsOnActiveBook - 1) : 1);

      // decrease total number of review by 1
      _totalReviewsOnActiveBook--;

      // empty variable that was holding the user's review.
      // i.e deletes user's review that was cached by provider.
      _userReviewOnActiveBook = null;

      // sets status to [COMPLETE]
      _data = ResponseExposer.complete(responseObj.message);
    } catch (e) {
      // sets status to [ERROR]
      _data = ResponseExposer.error(e.toString());
    }

    notifyListeners();
  }

  /// resets all values to null.
  void resetAllValues() {
    _currentBookReviews = null;
    _userReviewOnActiveBook = null;
    _totalReviewsOnActiveBook = null;
  }
}
