import 'dart:convert';

import 'package:accord/models/book.dart';
import 'package:accord/models/request.dart';
import 'package:accord/responses/request_response.dart';
import 'package:accord/services/request_service.dart';
import 'package:accord/utils/exposer.dart';
import 'package:flutter/foundation.dart';

class RequestViewModel extends ChangeNotifier {
  List<Request> _incomingRequests;
  List<Request> get incomingRequests => _incomingRequests;

  List<Request> _outgoingRequests;
  List<Request> get outgoingRequests => _outgoingRequests;

  /// bookID of the requested book.
  Book _requestedBook;
  Book get requestedBook => _requestedBook;

  /// bookID of user's book that will be offered to the owner to requested book
  Book _offeredBook;
  Book get offeredBook => _offeredBook;

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

  /// calls api to post the request.
  Future<void> requestBook(String requestInfo) async {
    // just sets [data] to [LOADING]
    _data = ResponseExposer.loading();

    try {
      var apiResponse = await RequestService().requestBook(requestInfo);

      // conversion: json to object.
      var responseObj = RequestResponse.fromJson(jsonDecode(apiResponse));

      // adds latest request to [outgoingRequest]
      // if [outgoingRequest] is not null
      if (_outgoingRequests != null) {
        _outgoingRequests.add(responseObj.result);
      }

      // sets [data] to [COMPLETE] with success message send by api
      _data = ResponseExposer.complete(responseObj.message);
    } catch (e) {
      // sets [data] to [ERROR] with error message send by api
      _data = ResponseExposer.error(e.toString());
    }

    notifyListeners();
  }

  /// calls api to fetch incoming requests.
  Future<void> fetchIncomingRequests() async {
    // just sets [data] to [LOADING]
    _data = ResponseExposer.loading();

    try {
      var apiResponse = await RequestService().fetchIncomingRequests();

      // conversion: json to object.
      var responseObj =
          MultipleRequestResponse.fromJson(jsonDecode(apiResponse));

      // assinging result sent by api to [incomingRequests]
      _incomingRequests = responseObj.result;

      // sets [data] to [COMPLETE] with success message send by api
      _data = ResponseExposer.complete(responseObj.message);
    } catch (e) {
      // sets [data] to [ERROR] with error message send by api
      _data = ResponseExposer.error(e.toString());
    }

    notifyListeners();
  }

  /// calls api to fetch outgoing requests.
  Future<void> fetchOutgoingRequests() async {
    // just sets [data] to [LOADING]
    _data = ResponseExposer.loading();

    try {
      var apiResponse = await RequestService().fetchOutgoingRequests();

      // conversion: json to object.
      var responseObj =
          MultipleRequestResponse.fromJson(jsonDecode(apiResponse));

      // assinging result sent by api to [outgoingRequests]
      _outgoingRequests = responseObj.result;

      // sets [data] to [COMPLETE] with success message send by api
      _data = ResponseExposer.complete(responseObj.message);
    } catch (e) {
      // sets [data] to [ERROR] with error message send by api
      _data = ResponseExposer.error(e.toString());
    }

    notifyListeners();
  }

  void resetOutgoingRequests() {
    _outgoingRequests = [];
    notifyListeners();
  }

  void resetIncomingRequests() {
    _incomingRequests = [];
    notifyListeners();
  }
}
