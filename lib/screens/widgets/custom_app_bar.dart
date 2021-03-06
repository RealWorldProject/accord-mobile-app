import 'package:accord/constant/accord_colors.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool backButton;

  const CustomAppBar({
    Key key,
    this.title,
    this.backButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: AccordColors.default_appbar_color),
      centerTitle: true,
      backgroundColor: Colors.white,
      leading: backButton
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 20,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              splashRadius: 20,
            )
          : null,
      title: CustomText(
        textToShow: title,
        textColor: AccordColors.default_appbar_color,
      ),
      bottom: PreferredSize(
        child: Container(
          color: Colors.blue,
          height: 1.0,
        ),
        preferredSize: Size.fromHeight(0.0),
      ),
      elevation: 0,
    );
  }
}
