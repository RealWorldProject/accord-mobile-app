import 'dart:convert';

import 'package:accord/responses/cart_response.dart';
import 'package:accord/services/cart_service.dart';
import 'package:flutter/foundation.dart';

class CartviewModel with ChangeNotifier {
  Future<CartResponse> addToCart(String cartItem) async {
    final apiResponse = await CartService().addToCart(cartItem);
    notifyListeners();
    return CartResponse.fromJson(jsonDecode(apiResponse));
  }

  Future<CartResponse> fetchCartItems() async {
    final apiResponse = await CartService().fetchCartItemss();
    notifyListeners();
    return CartResponse.fromJson(jsonDecode(apiResponse));
  }
}
