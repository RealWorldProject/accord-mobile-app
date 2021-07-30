import 'package:accord/models/cart_item.dart';

class CartResponse {
  CartResponse({
    this.success,
    this.message,
    this.cartID,
    this.result,
  });

  final bool success;
  final String message;
  final String cartID;
  final List<CartItem> result;

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    var rawCartItems = json['result'] as List;
    List<CartItem> cartItems =
        rawCartItems.map((cartItem) => CartItem.fromJson(cartItem)).toList();
    return CartResponse(
      success: json['success'],
      message: json['message'],
      cartID: json['cartId'],
      result: cartItems,
    );
  }
}
