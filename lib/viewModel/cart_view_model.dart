import 'dart:convert';

import 'package:accord/models/cart_item.dart';
import 'package:accord/responses/cart_response.dart';
import 'package:accord/services/cart_service.dart';
import 'package:accord/services/handlers/exposer.dart';
import 'package:flutter/foundation.dart';

class CartviewModel with ChangeNotifier {
  List<CartItem> _cartItems = [];
  List<CartItem> get cartItems => _cartItems;

  ResponseExposer _data;
  ResponseExposer get data => _data;

  // calculate the overall price of the books available in the cart.
  int get overallPrice =>
      cartItems.fold(0, (total, cartItem) => total + cartItem.totalPrice);

  // create the [String] containing bookIDs. used to track book in cart.
  List<String> get cartItemsID => cartItems.map((e) => e.bookID).toList();

  Future<dynamic> addToCart(String cartItem) async {
    // set response status to LOADING.
    _data = ResponseExposer.loading();

    try {
      final apiResponse = await CartService().addToCart(cartItem);

      // json to object conversion. then, object's result is placed in _cartItems.
      _cartItems = CartResponse.fromJson(jsonDecode(apiResponse)).result;

      // set response status to COMPLETE.
      _data = ResponseExposer.complete();
    } catch (e) {
      // set response status to ERROR.
      _data = ResponseExposer.error(e.toString());
    }
    notifyListeners();
  }

  Future<dynamic> get fetchCartItems async {
    _data = ResponseExposer.loading();

    try {
      final apiResponse = await CartService().fetchCartItems();
      _cartItems = CartResponse.fromJson(jsonDecode(apiResponse)).result;
      _data = ResponseExposer.complete();
    } catch (e) {
      // resets [cartItems] in case of error.
      _cartItems = [];
      _data = ResponseExposer.error(e.toString());
    }
    notifyListeners();
  }

  Future<dynamic> deleteCartItem(String cartItem) async {
    _data = ResponseExposer.loading();

    try {
      final apiResponse = await CartService().deleteCartItem(cartItem);
      _cartItems = CartResponse.fromJson(jsonDecode(apiResponse)).result;
      _data = ResponseExposer.complete();
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
