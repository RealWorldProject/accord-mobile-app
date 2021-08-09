import 'package:accord/models/order.dart';

class OrderResponse {
  OrderResponse({
    this.success,
    this.message,
    this.result,
  });

  final bool success;
  final String message;
  final Order result;

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      success: json['success'],
      message: json['message'],
      result: Order.fromJson(json['result']),
    );
  }
}
