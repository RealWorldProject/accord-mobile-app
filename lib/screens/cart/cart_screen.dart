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
      extendBody: true,
      appBar: AppBar(
        title: Text(
          "My Cart (1)",
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
          child: Column(
        children: [
          CartListView(),
          CartListView(),
          CartListView(),
          CartListView(),
          CartListView(),
          SizedBox(
            height: 210,
          )
        ],
      )),

      bottomSheet: Container(
        height: 200,
        color: Color(0xFF0E3311).withOpacity(0.0),
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
              // SizedBox(
              //   height: 10,
              // ),
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
                  Text(
                    "Rs. 500",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff006494),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8,),
              Container(
                child: GestureDetector(
                  onTap: () {

                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Center(
                      child: Text(
                        "Confirm Order",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          fontWeight: FontWeight.w500

                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      // bottomSheet: Container(
      //
      //   height: 150,
      //   decoration: BoxDecoration(
      //     color:Colors.transparent,
      //         borderRadius: BorderRadius.only(topLeft: Radius.circular(20),)
      //   ),
      // )
    );
  }
}
