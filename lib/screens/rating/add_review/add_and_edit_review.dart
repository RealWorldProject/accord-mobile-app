import 'package:accord/constant/accord_colors.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/screens/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
class AddAndEditReview extends StatelessWidget {
  const AddAndEditReview({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomText(textToShow: "Write Your Review", textColor: AccordColors.full_dark_blue_color,fontSize: 18,),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin: EdgeInsets.symmetric(vertical: 10),
            child: CustomTextField(
              noOfLines: 12,
              designType: DesignType.BORDER,
              designTypeBorderRadius: 20,
              contentVerticalPadding: 10,
              hintText: "Would you like to write anything about the book?",
            ),

          )


        ],
      ),
    );
  }
}
