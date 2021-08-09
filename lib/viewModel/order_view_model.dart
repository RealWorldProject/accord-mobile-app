import 'dart:convert';

import 'package:accord/models/order.dart';
import 'package:accord/responses/order_response.dart';
import 'package:accord/services/handlers/exposer.dart';
import 'package:accord/services/order_service.dart';
import 'package:flutter/foundation.dart';

class OrderViewModel extends ChangeNotifier {
  Order _orderDetails;
  Order get orderDetails => _orderDetails;

  ResponseExposer _data;
  ResponseExposer get data => _data;

  Future<void> checkoutOrder(String orderInfo) async {
    // response status set to loading.
    _data = ResponseExposer.loading();

    try {
      var res = await OrderService().checkoutOrder(orderInfo);

      // converts plain response to OrderResponse.
      var responseObj = OrderResponse.fromJson(jsonDecode(res));
      _orderDetails = responseObj.result;

      // response status set to done.
      _data = ResponseExposer.complete(responseObj.message);
    } catch (e) {
      // response status set to error.
      _data = ResponseExposer.error(e.toString());
    }

    notifyListeners();
  }
}
