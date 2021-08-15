import 'package:accord/constant/accord_labels.dart';
import 'package:accord/models/cart_item.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/utils/exposer.dart';
import 'package:accord/viewModel/cart_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'order_details.dart';

class ConfirmCartSection extends StatelessWidget {
  const ConfirmCartSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // tracking any change in cartItems of CartViewModel
    List<CartItem> cartItems = context.watch<CartviewModel>().cartItems;

    return Container(
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
            CustomText(
              textToShow: AccordLabels.orderInfoHeader,
              fontWeight: FontWeight.bold,
              textColor: Color(0xff13293d),
              fontSize: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  textToShow: AccordLabels.grandTotal,
                  fontWeight: FontWeight.w500,
                  textColor: Color(0xff626364),
                  fontSize: 16,
                ),
                Consumer<CartviewModel>(
                  builder: (context, cvm, child) => CustomText(
                    textToShow:
                        // set cart's total amount to 0 when cart is loading/has error.
                        cvm.data.status == Status.LOADING ||
                                cvm.data.status == Status.ERROR
                            ? "Rs.0"
                            : "\Rs.${cvm.overallPrice}",
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    textColor: Color(0xff006494),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Material(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(5),
              child: InkWell(
                onTap: () {
                  context.read<CartviewModel>().cartItems.isEmpty
                      ? null
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderDetails()));
                },
                splashFactory:
                    cartItems.isEmpty ? NoSplash.splashFactory : null,
                child: Container(
                  padding: EdgeInsets.all(8),
                  width: double.infinity,
                  decoration: cartItems.isNotEmpty
                      ? null
                      : BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black45,
                        ),
                  child: Center(
                    child: CustomText(
                      textToShow: AccordLabels.proceedToOrder,
                      textColor:
                          cartItems.isNotEmpty ? Colors.white : Colors.white54,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
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
