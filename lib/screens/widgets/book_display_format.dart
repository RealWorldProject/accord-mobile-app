import 'dart:convert';

import 'package:accord/models/book.dart';
import 'package:accord/models/cart_item.dart';
import 'package:accord/screens/home/book_view/book_screen.dart';
import 'package:accord/screens/home/book_view/rating_stars.dart';
import 'package:accord/utils/exposer.dart';
import 'package:accord/viewModel/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookDisplayFormat extends StatelessWidget {
  const BookDisplayFormat({
    Key key,
    this.book,
    this.index,
  }) : super(key: key);

  final Book book;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          padding: EdgeInsets.all(7.0),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.white60,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookScreen(
                              book: book,
                            )));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 219.0,
                        width: 175.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(book.images[0]),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          height: 219.0,
                          width: 175.0,
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -20,
                        right: 10,
                        child: Container(
                          padding: EdgeInsets.zero,
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: () {},
                            padding: EdgeInsets.only(
                                top: 4, bottom: 0, left: 0, right: 0),
                            alignment: Alignment.center,
                            // icon: book.isLiked == false
                            //     ? Icon(Icons.favorite_outline_rounded)
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            iconSize: 25,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                          alignment: Alignment.center,
                          decoration: book.isNewBook == false
                              ? BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                )
                              : BoxDecoration(
                                  color: Color(0xff009900),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                          child: Text(
                            book.isNewBook ? "New" : "Old",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          book.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[900]),
                        ),
                        Text(
                          book.author,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey[800],
                              fontStyle: FontStyle.italic),
                        ),
                        RatingStars(4.5, 18),
                        Text(
                          "Available for Exchange",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w300,
                              color: book.isAvailableForExchange == true
                                  ? Colors.blue[600]
                                  : Colors.grey[600],
                              decoration: book.isAvailableForExchange == false
                                  ? (TextDecoration.lineThrough)
                                  : (TextDecoration.none),
                              fontStyle: FontStyle.italic),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Rs. ${book.price.toString()}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: Color(0xff247BA0),
                              ),
                            ),
                            AddToCart(bookID: book.id),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AddToCart extends StatelessWidget {
  const AddToCart({Key key, this.bookID}) : super(key: key);

  final String bookID;

  @override
  Widget build(BuildContext context) {
    bool isInCart = context.select<CartviewModel, bool>(
        // listening to changes occured only in [cartItemsID]
        (cvm) =>
            cvm.cartItems.map((book) => book.bookID).toList().contains(bookID));

    return Material(
      color: Color(0xff13293D),
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
      child: InkWell(
        onTap: () {
          context.read<CartviewModel>().data.status == Status.LOADING
              ? null
              : addOrIncreaseItemQuantity(bookID, context);
        },
        child: Container(
          height: 30,
          width: 35,
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.shopping_cart,
                size: 18,
                color: Colors.white,
              ),
              isInCart
                  ? Container(
                      height: 12,
                      width: 12,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: 15, left: 7),
                      decoration: BoxDecoration(
                        color: Color(0xff13293D),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Icon(
                        Icons.add,
                        size: 12,
                        color: Colors.white,
                      ),
                    )
                  : Container(),
            ],
          ),
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
