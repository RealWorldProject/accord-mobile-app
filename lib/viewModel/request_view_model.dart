import 'dart:convert';

import 'package:accord/models/book.dart';
import 'package:accord/models/request.dart';
import 'package:accord/responses/request_response.dart';
import 'package:accord/services/request_service.dart';
import 'package:accord/utils/exposer.dart';
import 'package:flutter/foundation.dart';

class RequestViewModel extends ChangeNotifier {
  List<Request> _requests;
  List<Request> get request => _requests;

  /// bookID of the requested book.
  Book _requestedBook;
  Book get requestedBook => _requestedBook;

  /// bookID of user's book that will be offered to the owner to requested book
  Book _offeredBook;
  Book get offeredBook => _offeredBook;

  List<Book> _userOwnedBooks;
  List<Book> get userOwnedBooks => _userOwnedBooks;

  /// selected book index
  int _currentBookIndex = 0;
  int get currentBookIndex => _currentBookIndex;

  /// response handler
  ResponseExposer _data;
  ResponseExposer get data => _data;

  /// sets books index when changed.
  void setIndex(int selectedIndex) {
    if (_currentBookIndex != selectedIndex) {
      _currentBookIndex = selectedIndex;
    }
    notifyListeners();
  }

  Future<void> requestBook(String requestInfo) async {
    _data = ResponseExposer.loading();

    try {
      var apiResponse = await RequestService().requestBook(requestInfo);

      var responseObj = RequestResponse.fromJson(jsonDecode(apiResponse));

      _data = ResponseExposer.complete(responseObj.message);
    } catch (e) {
      _data = ResponseExposer.error(e.toString());
    }

    notifyListeners();
  }
}
