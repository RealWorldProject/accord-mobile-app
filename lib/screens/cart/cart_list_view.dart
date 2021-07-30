import 'package:accord/models/cart_item.dart';
import 'package:accord/screens/shimmer/cart_shimmer.dart';
import 'package:accord/viewModel/cart_view_model.dart';
import 'package:flutter/material.dart';

class CartListView extends StatefulWidget {
  const CartListView({Key key}) : super(key: key);

  @override
  _CartListViewState createState() => _CartListViewState();
}

class _CartListViewState extends State<CartListView> {
  final double imageHeight = 110.0;
  final double imageWidth = 95.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: FutureBuilder(
          future: CartviewModel().fetchCartItems(),
          builder: (context, cartSnap) {
            if (cartSnap.hasData) {
              // notifying users that there is no books added to the cart.
              if (cartSnap.data.result.length == 0) {
                return Container(
                  padding: EdgeInsets.only(
                    top: 1.5,
                    left: 5,
                    right: 2,
                  ),
                  child: Text(
                    "Your cart list is empty.",
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 18,
                      letterSpacing: -1,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                    itemCount: cartSnap.data.result.length,
                    itemBuilder: (BuildContext context, int index) {
                      CartItem cartItem = cartSnap.data.result[index];
                      return cartItemDesign(cartItem);
                    });
              }
            }
            return CartShimmer();
          }),
    );
  }

  cartItemDesign(CartItem cartItem) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      height: 130,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        cartItem.images,
                        height: imageHeight,
                        width: imageWidth,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          cartItem.name,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[900]),
                          overflow: TextOverflow.ellipsis,
                        ),
                        // Text(
                        //   cartItem.author,
                        //   style: TextStyle(
                        //       fontSize: 14,
                        //       fontWeight: FontWeight.w100,
                        //       color: Colors.grey[700],
                        //       fontStyle: FontStyle.italic),
                        //   overflow: TextOverflow.ellipsis,
                        // ),
                        Text(
                          cartItem.price.toString(),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w100,
                              color: Colors.blue[400],
                              fontStyle: FontStyle.italic),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Colors.blueAccent,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.remove_rounded,
                                    color: Colors.blueAccent,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              cartItem.quantity.toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Colors.blueAccent,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.add_rounded,
                                    color: Colors.blueAccent,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ClipOval(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                              onTap: () {},
                              child: SizedBox(
                                width: 35,
                                height: 35,
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.grey,
                                  size: 24,
                                ),
                              )),
                        ),
                      ),
                      Text(
                        (cartItem.quantity * cartItem.price).toInt().toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Color(0xff247BA0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
