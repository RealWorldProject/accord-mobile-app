import 'dart:convert';

import 'package:accord/models/cart_item.dart';
import 'package:accord/responses/cart_response.dart';
import 'package:accord/services/cart_service.dart';
import 'package:flutter/foundation.dart';

class CartviewModel with ChangeNotifier {
  // ResponseExposer<List<CartItem>> _cartItems;
  // ResponseExposer<List<CartItem>> get cartItems => _cartItems;

  List<CartItem> _cartItems;
  List<CartItem> get cartItems => _cartItems;

  int _cartLength = 0;
  int get cartLength {
    print(_cartLength);
    // notifyListeners();
    return _cartLength;
  }

  String _errorMessage;
  String get errorMessage => _errorMessage;

  Future<CartResponse> addToCart(String cartItem) async {
    final apiResponse = await CartService().addToCart(cartItem);
    _cartLength++;
    notifyListeners();
    return CartResponse.fromJson(jsonDecode(apiResponse));
  }

  Future<void> get fetchCartItems async {
    // _cartItems = ResponseExposer.loading();

    try {
      final apiResponse = await CartService().fetchCartItemss();
      _cartItems = CartResponse.fromJson(jsonDecode(apiResponse)).result;
      // print(inspect(apiResponse));
      // _cartItems = ResponseExposer.complete(items);
      _cartLength = _cartItems.length;
      _errorMessage = null;
    } catch (e) {
      // _cartItems = ResponseExposer.error(e.toString());
      _cartLength = 0;
      _errorMessage = e.toString();
      // print(e.toString());
    }
    notifyListeners();
  }
}
