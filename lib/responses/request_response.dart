import 'package:accord/models/request.dart';

class RequestResponse {
  RequestResponse({
    this.success,
    this.message,
    this.result,
  });

  final bool success;
  final String message;
  final Request result;

  factory RequestResponse.fromJson(Map<String, dynamic> json) {
    return RequestResponse(
      success: json['success'],
      message: json['message'],
      result: Request.fromJson(json['result']),
    );
  }
}

class MultipleRequestResponse {
  MultipleRequestResponse({
    this.success,
    this.message,
    this.result,
  });

  final bool success;
  final String message;
  final List<Request> result;

  factory MultipleRequestResponse.fromJson(Map<String, dynamic> json) {
    // converting plain result from json into [List<Request>].
    var rawRequestList = json['result'] as List;
    List<Request> filteredRequestList =
        rawRequestList.map((request) => Request.fromJson(request)).toList();

    return MultipleRequestResponse(
      success: json['success'],
      message: json['message'],
      result: filteredRequestList,
    );
  }
}
