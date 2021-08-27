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

  ResponseExposer _incomingRequestData;
  ResponseExposer get incomingRequestData => _incomingRequestData;

  /// sets books index when changed.
  void setIndex(int selectedIndex) {
    if (_currentBookIndex != selectedIndex) {
      _currentBookIndex = selectedIndex;
    }
    notifyListeners();
  }

  /// sets books index when changed.
  void initializeIndexWhenEditing(int selectedIndex) {
    if (_currentBookIndex != selectedIndex) {
      _currentBookIndex = selectedIndex;
    }
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
        _outgoingRequests.insert(0, responseObj.result);
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
    _incomingRequestData = ResponseExposer.loading();

    try {
      var apiResponse = await RequestService().fetchIncomingRequests();

      // conversion: json to object.
      var responseObj =
          MultipleRequestResponse.fromJson(jsonDecode(apiResponse));

      // assinging result sent by api to [incomingRequests]
      _incomingRequests = responseObj.result;

      // sets [data] to [COMPLETE] with success message send by api
      _incomingRequestData = ResponseExposer.complete(responseObj.message);
    } catch (e) {
      // sets [data] to [ERROR] with error message send by api
      _incomingRequestData = ResponseExposer.error(e.toString());
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

  /// accept book exchange request
  Future<void> acceptExchangeRequest(
    String requestID, {
    ActionPlace actionPlace = ActionPlace.REQUEST_BODY,
  }) async {
    // just sets [data] to [LOADING]
    _data = ResponseExposer.loading();

    try {
      var apiResponse = await RequestService().acceptExchangeRequest(requestID);

      // conversion: json to object.
      var responseObj = RequestResponse.fromJson(jsonDecode(apiResponse));

      // since this function is used for two different purpose,
      // [actionPlace] will restrict the updating of given request only when
      // the function is called from [REQUEST_BODY] & [incomingRequests] is not null.
      if (actionPlace == ActionPlace.REQUEST_BODY &&
          _incomingRequests != null) {
        int currentRequestIndex =
            _incomingRequests.indexWhere((request) => request.id == requestID);

        _incomingRequests[currentRequestIndex] = responseObj.result;
      }

      // sets [data] to [COMPLETE] with success message send by api
      _data = ResponseExposer.complete(responseObj.message);
    } catch (e) {
      // sets [data] to [ERROR] with error message send by api
      _data = ResponseExposer.error(e.toString());
    }

    notifyListeners();
  }

  /// reject/decline book exchange request
  Future<void> rejectExchangeRequest(
    String requestID, {
    ActionPlace actionPlace = ActionPlace.REQUEST_BODY,
  }) async {
    // just sets [data] to [LOADING]
    _data = ResponseExposer.loading();

    try {
      var apiResponse = await RequestService().rejectExchangeRequest(requestID);

      // conversion: json to object.
      var responseObj = RequestResponse.fromJson(jsonDecode(apiResponse));

      // since this function is used for two different purpose,
      // [actionPlace] will restrict the updating of given request only when
      // the function is called from [REQUEST_BODY] & [incomingRequests] is not null.
      if (actionPlace == ActionPlace.REQUEST_BODY &&
          _incomingRequests != null) {
        int currentRequestIndex =
            _incomingRequests.indexWhere((request) => request.id == requestID);

        _incomingRequests[currentRequestIndex] = responseObj.result;
      }

      // sets [data] to [COMPLETE] with success message send by api
      _data = ResponseExposer.complete(responseObj.message);
    } catch (e) {
      // sets [data] to [ERROR] with error message send by api
      _data = ResponseExposer.error(e.toString());
    }

    notifyListeners();
  }

  // edit user's exchange request sent to other users.
  Future<void> editOutgoingExchangeRequest(
      String requestID, String updatedExchangeRequest) async {
    // sets [data] to [LOADING]
    _data = ResponseExposer.loading();

    try {
      // api call to update PENDING given exchange request.
      var apiResponse = await RequestService()
          .editOutgoingExchangeRequest(requestID, updatedExchangeRequest);

      // conversion: json response into response object.
      var responseObj = RequestResponse.fromJson(jsonDecode(apiResponse));

      // index of the updated outgoing exchnage request.
      int editedExchangeRequestIndex =
          _outgoingRequests.indexWhere((request) => requestID == request.id);

      // replacing given exchange request with updated exchange request in [outgoingRequest]
      _outgoingRequests[editedExchangeRequestIndex] = responseObj.result;

      // sets status to [COMPLETE]
      _data = ResponseExposer.complete(responseObj.message);
    } catch (e) {
      // sets status to [ERROR]
      _data = ResponseExposer.error(e.toString());
    }

    notifyListeners();
  }

  // delete user's exchange request sent to other users.
  Future<void> deleteOutgoingExchangeRequest(String requestID) async {
    // sets [data] to [LOADING]
    _data = ResponseExposer.loading();

    try {
      // api call to delete PENDING given exchange request.
      var apiResponse =
          await RequestService().deleteOutgoingExchangeRequest(requestID);

      // conversion: json response into response object.
      var responseObj = RequestResponse.fromJson(jsonDecode(apiResponse));

      // index of the deleted outgoing exchnage request.
      int deletedExchangeRequestIndex =
          _outgoingRequests.indexWhere((request) => requestID == request.id);

      // removes exchange request from [outgoingRequest]
      _outgoingRequests.removeAt(deletedExchangeRequestIndex);

      // sets status to [COMPLETE]
      _data = ResponseExposer.complete(responseObj.message);
    } catch (e) {
      // sets status to [ERROR]
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

/// defines where the function is being called from
enum ActionPlace {
  REQUEST_BODY,
  NOTIFICATION_BODY,
}
