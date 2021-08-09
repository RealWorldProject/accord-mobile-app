import 'dart:async';

import 'package:accord/screens/cart/order_details.dart';
import 'package:accord/screens/cart/cart_list_view.dart';
import 'package:accord/viewModel/cart_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with AutomaticKeepAliveClientMixin<CartScreen> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(
          "My Cart",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        bottom: PreferredSize(
          child: Container(
            color: Colors.blue,
            height: 1.0,
          ),
          preferredSize: Size.fromHeight(0.0),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: Container(
        margin: EdgeInsets.only(bottom: 185),
        child: CartListView(),
      ),
      bottomSheet: ConfirmCartSection(
        cartReloader: reloadCart,
      ),
    );
  }

  @override
  bool get wantKeepAlive => false;

  FutureOr<dynamic> reloadCart(dynamic value) async {
    await context.read<CartviewModel>().fetchCartItems;
    setState(() {});
  }
}

class ConfirmCartSection extends StatelessWidget {
  const ConfirmCartSection({Key key, this.cartReloader}) : super(key: key);

  final FutureOr cartReloader;

  @override
  Widget build(BuildContext context) {
    context.read<CartviewModel>().fetchCartItems;
    return Container(
      height: 200,
      color: Color(0xFF0E3311).withOpacity(0.0),
      // color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order Info",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff13293d),
                  fontSize: 18),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Grand Total",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xff626364),
                      fontSize: 16),
                ),
                Consumer<CartviewModel>(
                  builder: (context, cvm, child) => Text(
                    "\Rs.${cvm.overallPrice}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff006494),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddLocationDetail()))
                      .then(cartReloader);
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      "Confirm Order",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
