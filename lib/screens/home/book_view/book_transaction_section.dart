import 'dart:convert';

import 'package:accord/constant/accord_colors.dart';
import 'package:accord/constant/accord_labels.dart';
import 'package:accord/models/book.dart';
import 'package:accord/models/cart_item.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/viewModel/book_view_model.dart';
import 'package:accord/viewModel/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class BookTransactionSection extends StatelessWidget {
  const BookTransactionSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Book book = context.read<BookViewModel>().activeBook;

    return Container(
      height: 80,
      color: Color(0xFF0E3311).withOpacity(0.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  textToShow: AccordLabels.bookPriceLabel,
                  textColor: AccordColors.primary_blue_color,
                  fontSize: 15,
                ),
                CustomText(
                  textToShow: "Rs. ${book.price}",
                  textColor: AccordColors.semi_dark_blue_color,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ],
            ),
            Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                color: AccordColors.semi_dark_blue_color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.white60,
                  onTap: () {
                    addOrIncreaseItemQuantity(book.id, context);
                    Toast.show(
                      AccordLabels.cartSuccessMessage,
                      context,
                      duration: Toast.LENGTH_SHORT,
                      gravity: Toast.BOTTOM,
                      backgroundColor: AccordColors.full_dark_blue_color,
                      backgroundRadius: 5.0,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_rounded,
                        size: 25,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CustomText(
                          textToShow: AccordLabels.addToCartLabel,
                          textColor: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  addOrIncreaseItemQuantity(String bookID, BuildContext context) {
    List<CartItem> cartItems = context.read<CartviewModel>().cartItems;

    String cartItemJson;

    if (!cartItems.map((book) => book.bookID).contains(bookID)) {
      // checks if the book exists in cart.
      // if not, create the cartItem object(i.e book) with default quantity = 1.
      CartItem cartItem = CartItem(bookID: bookID, quantity: 1);

      // json conversion.
      cartItemJson = jsonEncode(cartItem);
    } else {
      // if book exists in the cart, gets the cart data of the book
      CartItem currentCartItem = cartItems[
          cartItems.indexWhere((cartItem) => cartItem.bookID == bookID)];

      // creates new cartItem object(i.e book) with updated values.
      // i.e, makes addition of 1 to existing quantity of the book.
      CartItem increaseCartItem = CartItem(
          bookID: currentCartItem.bookID,
          quantity: currentCartItem.quantity + 1);
      cartItemJson = jsonEncode(increaseCartItem);
    }

    // calls api to add cartItem(i.e, book) to cart
    context.read<CartviewModel>().addToCart(cartItemJson);
  }
}
