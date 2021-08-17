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

class MultipleOrderResponse {
  MultipleOrderResponse({
    this.success,
    this.message,
    this.result,
  });

  final bool success;
  final String message;
  final List<Order> result;

  factory MultipleOrderResponse.fromJson(Map<String, dynamic> json) =>
      MultipleOrderResponse(
        success: json['success'],
        message: json['message'],
        result: (json['result'] as List)
            .map((order) => Order.fromJson(order))
            .toList(),
      );
}
