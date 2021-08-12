import 'package:accord/constant/constant.dart';
import 'package:accord/screens/widgets/custom_label.dart';
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
        title: Text("My Orders",style: TextStyle(color: Constant.primary_blue_color),),


      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Text("wat"),
      ),
    );
  }
}
