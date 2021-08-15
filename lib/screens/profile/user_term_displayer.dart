import 'package:accord/constant/accord_labels.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/utils/exposer.dart';
import 'package:accord/utils/text_utils.dart';
import 'package:accord/viewModel/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserTermDisplayer extends StatelessWidget {
  const UserTermDisplayer({
    Key key,
    @required this.termColor,
  }) : super(key: key);

  final Color termColor;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, userViewModel, child) {
        if (userViewModel.data.status == Status.COMPLETE) {
          return Column(
            children: [
              userViewModel.user.fullName == null
                  ? CustomText(
                      textToShow: AccordLabels.fullName,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      textColor: termColor,
                      textDecoration: TextDecoration.lineThrough,
                    )
                  : CustomText(
                      textToShow: TextUtils()
                          .capitalizeAll(userViewModel.user.fullName),
                      textColor: termColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
              userViewModel.user.email == null
                  ? Container()
                  : CustomText(
                      textToShow: userViewModel.user.email,
                      textColor: termColor,
                      fontSize: 16,
                    ),
            ],
          );
        } else {
          return CustomText(
            textToShow: AccordLabels.fullName,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            textColor: termColor,
            textDecoration: TextDecoration.lineThrough,
          );
        }
      },
    );
  }
}
