import 'dart:convert';

import 'package:accord/models/request.dart';
import 'package:accord/responses/request_response.dart';
import 'package:accord/services/request_service.dart';
import 'package:accord/utils/exposer.dart';
import 'package:flutter/foundation.dart';

class RequestViewModel extends ChangeNotifier {
  Request _request;
  Request get request => _request;

  ResponseExposer _data;
  ResponseExposer get data => _data;

  Future<void> requestBook(String requestInfo) async {
    _data = ResponseExposer.loading();
    try {
      var apiResponse = await RequestService().requestBook(requestInfo);

      var responseObj = RequestResponse.fromJson(jsonDecode(apiResponse));

      _data = ResponseExposer.complete(responseObj.message);
    } catch (e) {
      _data = ResponseExposer.error(e.toString());
    }
  }
}
