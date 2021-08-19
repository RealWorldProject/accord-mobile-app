import 'package:accord/constant/accord_colors.dart';
import 'package:accord/constant/accord_labels.dart';
import 'package:accord/screens/widgets/custom_app_bar.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:flutter/material.dart';

import 'order_list_view.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          title: AccordLabels.myorderScreenTitle,
          backButton: false,
        ),
      ),
      body: Container(
        color: Colors.grey[300],
        child: OrderListView(),
      ),
    );
  }
}
