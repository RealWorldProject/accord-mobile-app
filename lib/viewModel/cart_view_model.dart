import 'dart:convert';
import 'dart:math';

import 'package:accord/models/cart_item.dart';
import 'package:accord/responses/cart_response.dart';
import 'package:accord/services/cart_service.dart';
import 'package:flutter/foundation.dart';

class CartviewModel with ChangeNotifier {
  // ResponseExposer<List<CartItem>> _cartItems;
  // ResponseExposer<List<CartItem>> get cartItems => _cartItems;

  List<CartItem> _cartItems = [];
  List<CartItem> get cartItems => _cartItems;

  int _overallPrice = 0;
  int get overallPrice => _overallPrice;

  List<String> _cartItemsID = [];
  List<String> get cartItemsID => _cartItemsID;

  int _cartLength = 0;
  int get cartLength => _cartLength;

  String _errorMessage;
  String get errorMessage => _errorMessage;

  Future<dynamic> addToCart(String cartItem) async {
    try {
      final apiResponse = await CartService().addToCart(cartItem);
      _cartItems = CartResponse.fromJson(jsonDecode(apiResponse)).result;
      _cartLength = _cartItems.length;
      _cartItemsID = _cartItems.map((e) => e.bookID).toList();
      _overallPrice =
          _cartItems.map((e) => e.totalPrice).fold(0, (x, y) => x + y);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<dynamic> get fetchCartItems async {
    // _cartItems = ResponseExposer.loading();

    try {
      final apiResponse = await CartService().fetchCartItemss();
      _cartItems = CartResponse.fromJson(jsonDecode(apiResponse)).result;
      // print(inspect(apiResponse));
      // _cartItems = ResponseExposer.complete(items);
      _cartLength = _cartItems.length;
      _cartItemsID = _cartItems.map((e) => e.bookID).toList();
      _overallPrice =
          _cartItems.map((e) => e.totalPrice).fold(0, (x, y) => x + y);
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
