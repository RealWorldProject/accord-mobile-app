import 'dart:convert';

import 'package:accord/models/cart_item.dart';
import 'package:accord/responses/cart_response.dart';
import 'package:accord/services/cart_service.dart';
import 'package:accord/utils/exposer.dart';
import 'package:flutter/foundation.dart';

class CartviewModel with ChangeNotifier {
  List<CartItem> _cartItems = [];
  List<CartItem> get cartItems => _cartItems;

  ResponseExposer _data;
  ResponseExposer get data => _data;

  // calculate the overall price of the books available in the cart.
  int get overallPrice =>
      cartItems.fold(0, (total, cartItem) => total + cartItem.totalPrice);

  // add to cart
  Future<dynamic> addToCart(String cartItem) async {
    // set response status to LOADING.
    _data = ResponseExposer.loading();

    try {
      final apiResponse = await CartService().addToCart(cartItem);

      // json to object conversion. then, object's result is placed in _cartItems.
      var responseObj = CartResponse.fromJson(jsonDecode(apiResponse));
      _cartItems = responseObj.result;

      // set response status to COMPLETE.
      _data = ResponseExposer.complete(responseObj.message);
    } catch (e) {
      // set response status to ERROR.
      _data = ResponseExposer.error(e.toString());
    }
    notifyListeners();
  }

  // fetch cart items
  Future<dynamic> get fetchCartItems async {
    _data = ResponseExposer.loading();

    try {
      final apiResponse = await CartService().fetchCartItems();

      var responseObj = CartResponse.fromJson(jsonDecode(apiResponse));
      _cartItems = responseObj.result;

      _data = ResponseExposer.complete(responseObj.message);
    } catch (e) {
      // resets [cartItems] in case of error.
      _cartItems = [];
      _data = ResponseExposer.error(e.toString());
    }
    notifyListeners();
  }

  // delete cart item
  Future<dynamic> deleteCartItem(String cartItem) async {
    _data = ResponseExposer.loading();

    try {
      final apiResponse = await CartService().deleteCartItem(cartItem);

      var responseObj = CartResponse.fromJson(jsonDecode(apiResponse));
      _cartItems = responseObj.result;

      _data = ResponseExposer.complete(responseObj.message);
    } catch (e) {
      _data = ResponseExposer.error(e.toString());
    }
    notifyListeners();
  }

  // to reset when the screen.
  void resetCartItems() {
    _cartItems = [];
    notifyListeners();
  }
}
