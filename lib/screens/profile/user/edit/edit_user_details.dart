import 'package:accord/constant/accord_colors.dart';
import 'package:accord/constant/accord_labels.dart';
import 'package:accord/screens/widgets/custom_app_bar.dart';
import 'package:accord/viewModel/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'field_update_bottom_sheet.dart';

class EditUserDetails extends StatelessWidget {
  const EditUserDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = context.watch<UserViewModel>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          title: AccordLabels.editDetails,
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                key: Key("editfullname"),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      final String currentFullName =
                          userViewModel.user.fullName;

                      return FieldUpdateBottomSheet(
                        updateField: UpdateField.FULLNAME,
                        bottomSheetTitle: AccordLabels.fullName,
                        currentValueOfUpdatingField: currentFullName,
                        bottomSheetButtonLabel:
                            AccordLabels.changeFullNameButtonLabel,
                      );
                    },
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(12),
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          AccordLabels.fullName,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AccordColors.full_dark_blue_color),
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            userViewModel.user.fullName != null
                                ? Text(
                                    userViewModel.user.fullName,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[800]),
                                  )
                                : Container(),
                            SizedBox(
                              width: 6,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      String currentPhoneNumber =
                          userViewModel.user.phoneNumber;
                      return FieldUpdateBottomSheet(
                        updateField: UpdateField.PHONENUMBER,
                        bottomSheetTitle: AccordLabels.phoneNumber,
                        currentValueOfUpdatingField: currentPhoneNumber,
                        bottomSheetButtonLabel:
                            AccordLabels.changePhoneNumberButtonLabel,
                      );
                    },
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(12),
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          AccordLabels.phoneNumber,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AccordColors.full_dark_blue_color),
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            userViewModel.user.phoneNumber != null
                                ? Text(
                                    userViewModel.user.phoneNumber,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[800]),
                                  )
                                : Container(),
                            SizedBox(
                              width: 6,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
