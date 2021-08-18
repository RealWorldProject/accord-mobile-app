import 'dart:convert';

import 'package:accord/models/order.dart';
import 'package:accord/responses/order_response.dart';
import 'package:accord/utils/exposer.dart';
import 'package:accord/services/order_service.dart';
import 'package:flutter/foundation.dart';

class OrderViewModel extends ChangeNotifier {
  List<Order> _orders;
  List<Order> get orders => _orders;

  ResponseExposer _data;
  ResponseExposer get data => _data;

  Future<void> checkoutOrder(String orderInfo) async {
    // response status set to loading.
    _data = ResponseExposer.loading();

    try {
      var apiResponse = await OrderService().checkoutOrder(orderInfo);

      // converts plain response to OrderResponse.
      var responseObj = OrderResponse.fromJson(jsonDecode(apiResponse));

      // adds latest order to [orders] if [orders] is not null
      if (_orders != null) {
        _orders.add(responseObj.result);
      }

      // response status set to done.
      _data = ResponseExposer.complete(responseObj.message);
    } catch (e) {
      // response status set to error.
      _data = ResponseExposer.error(e.toString());
    }

    notifyListeners();
  }

  Future<void> fetchOrders() async {
    // status set to loading.
    _data = ResponseExposer.loading();

    try {
      var apiResponse = await OrderService().fetchUserOrders();

      // converts plain response to MultipleOrderResponse.
      var responseObj = MultipleOrderResponse.fromJson(jsonDecode(apiResponse));

      // [List<Order>] from response
      _orders = responseObj.result;

      // status set to done.
      _data = ResponseExposer.complete(responseObj.message);
    } catch (e) {
      // status set to error.
      _data = ResponseExposer.error(e.toString());
    }

    notifyListeners();
  }

  void resetOrders() {
    _orders = [];
    notifyListeners();
  }
}
