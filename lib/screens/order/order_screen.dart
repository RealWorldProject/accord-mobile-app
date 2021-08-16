import 'package:accord/constant/accord_colors.dart';
import 'package:accord/screens/order/order_list_view.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "My Orders",
          style: TextStyle(color: AccordColors.primary_blue_color),
        ),
        bottom: PreferredSize(
          child: Container(
            color: Colors.blue,
            height: 1.0,
          ),
          preferredSize: Size.fromHeight(0.0),
        ),
        elevation: 0,
      ),
      body: Container(
        color: Colors.grey[300],
        child: OrderListView(),
      ),
    );
  }
}
