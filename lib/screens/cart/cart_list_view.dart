import 'package:accord/models/cart_item.dart';
import 'package:accord/screens/shimmer/cart_shimmer.dart';
import 'package:accord/viewModel/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartListView extends StatefulWidget {
  const CartListView({Key key}) : super(key: key);

  @override
  _CartListViewState createState() => _CartListViewState();
}

class _CartListViewState extends State<CartListView> {
  static const double imageHeight = 110.0;
  static const double imageWidth = 95.0;

  @override
  Widget build(BuildContext context) {
    context.read<CartviewModel>().fetchCartItems;
    return RefreshIndicator(
        child: Consumer<CartviewModel>(builder: (context, cartviewModel, _) {
      return cartviewModel.errorMessage == null &&
              cartviewModel.cartItems == null
          ? CartShimmer()
          : cartviewModel.errorMessage != null
              ? Center(
                  child: Text(cartviewModel.errorMessage),
                )
              : ListView.builder(
                  itemCount: cartviewModel.cartItems.isEmpty
                      ? 1
                      : cartviewModel.cartItems.length,
                  itemBuilder: (context, index) {
                    if (cartviewModel.cartItems.isNotEmpty) {
                      CartItem cartItem = cartviewModel.cartItems[index];
                      return cartItemDesign(cartItem);
                    } else {
                      return Container(
                        padding: EdgeInsets.only(top: 20),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "No books added to the cart.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              letterSpacing: -1,
                              fontWeight: FontWeight.w500,
                              color: Colors.black45),
                        ),
                      );
                    }
                  });
    }), onRefresh: () async {
      await context.read<CartviewModel>().fetchCartItems;
    });
  }

  cartItemDesign(CartItem cartItem) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      height: 130,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
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
