import 'package:accord/screens/cart/cart_list_view.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart (1)",style: TextStyle(color: Colors.black),),
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
      backgroundColor: Colors.grey[100],
      body: CartListView(),
    );
  }
}
