import 'package:accord/constant/accord_colors.dart';
import 'package:accord/constant/accord_labels.dart';
import 'package:accord/screens/cart/cart_screen.dart';
import 'package:flutter/material.dart';

import 'custom_label.dart';
Widget AddtocartSnackbar({
  @required BuildContext context,
}) {
  return SnackBar(
    content: CustomText(
      textToShow: AccordLabels.cartSuccessMessage,
      textColor: Colors.white,
      fontSize: 16,
      fontStyle: FontStyle.italic,
      noOfLines: 3,
    ),
    backgroundColor: AccordColors.snackbar_color,
    action: SnackBarAction(
      label: AccordLabels.viewcart,
      textColor: AccordColors.primary_blue_color,
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CartScreen()));
      },
    ),
  );
}