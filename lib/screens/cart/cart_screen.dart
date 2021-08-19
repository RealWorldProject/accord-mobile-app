import 'package:accord/constant/accord_labels.dart';
import 'package:accord/screens/widgets/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:accord/viewModel/cart_view_model.dart';
import 'package:provider/provider.dart';
import 'package:accord/models/cart_item.dart';
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
    List<CartItem> cartItems = context.watch<CartviewModel>().cartItems;

    return Scaffold(
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          title: AccordLabels.cartScreenTitle,
          backButton: false,
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: Container(
        margin: EdgeInsets.only(bottom: 185),
        child: CartListView(),
      ),
      bottomSheet: cartItems.isNotEmpty ? ConfirmCartSection() : null,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
