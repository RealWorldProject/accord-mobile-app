import 'package:accord/constant/accord_labels.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cart_list_view.dart';
import 'confirm_cart_section.dart';

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
        title: CustomText(
          textToShow: AccordLabels.cartScreenTitle,
          textColor: Colors.blue,
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
      bottomSheet: ConfirmCartSection(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
