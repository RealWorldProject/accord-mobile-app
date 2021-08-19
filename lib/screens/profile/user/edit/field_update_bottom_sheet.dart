import 'dart:convert';

import 'package:accord/constant/accord_labels.dart';
import 'package:accord/models/user.dart';
import 'package:accord/screens/widgets/custom_button.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/screens/widgets/custom_text_field.dart';
import 'package:accord/screens/widgets/empty_text_field.dart';
import 'package:accord/screens/widgets/information_dialog_box.dart';
import 'package:accord/utils/exposer.dart';
import 'package:accord/viewModel/provider/button_loading_provider.dart';
import 'package:accord/viewModel/provider/text_field_value_change_provider.dart';
import 'package:accord/viewModel/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

class FieldUpdateBottomSheet extends StatefulWidget {
  const FieldUpdateBottomSheet({
    Key key,
    @required this.updateField,
    @required this.bottomSheetTitle,
    @required this.currentValueOfUpdatingField,
    @required this.bottomSheetButtonLabel,
  }) : super(key: key);

  /// determines which field to update
  final UpdateField updateField;

  /// title: denotes the field that is about to be updated.
  final String bottomSheetTitle;

  /// value in effect of the field about to be updated.
  final String currentValueOfUpdatingField;

  /// label to show in bottomsheet button
  final String bottomSheetButtonLabel;

  @override
  _FieldUpdateBottomSheetState createState() => _FieldUpdateBottomSheetState();
}

class _FieldUpdateBottomSheetState extends State<FieldUpdateBottomSheet> {
  // controller for the [TextField] in bottomsheet.
  final TextEditingController _updateFieldController =
      new TextEditingController();
  FocusNode _updateFieldFocusNode;

  @override
  void initState() {
    // initialize both to default
    context.read<ButtonLoadingProvider>().initializer();
    context.read<TextFieldValueChangeProvider>().initializer();

    _updateFieldController.text = widget.currentValueOfUpdatingField;

    UserViewModel userViewModel = context.read<UserViewModel>();

    // value change listener for the given text field.
    // used for validations like, disabling button as long as
    // the current value remains unchanged or the value is empty [""];
    _updateFieldController.addListener(() {
      _updateFieldController.text == ""
          ? context.read<TextFieldValueChangeProvider>().removeValueChange()
          : _updateFieldController.text !=
                  (widget.updateField == UpdateField.FULLNAME
                      ? userViewModel.user.fullName
                      : userViewModel.user.phoneNumber)
              ? context.read<TextFieldValueChangeProvider>().setValueChanged()
              : context
                  .read<TextFieldValueChangeProvider>()
                  .removeValueChange();
    });

    // used for requesting focus.
    _updateFieldFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _updateFieldController.dispose();
    _updateFieldFocusNode.dispose();
    super.dispose();
  }

  // clears textfield associated with the corresponding controller.
  void clearTextField() {
    _updateFieldController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 200,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              textToShow: widget.bottomSheetTitle,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 20,
            ),
            Stack(
              alignment: Alignment.centerRight,
              children: [
                Container(
                  height: 50,
                  child: CustomTextField(
                    designType: DesignType.UNDERLINE,
                    fieldType: widget.updateField == UpdateField.PHONENUMBER
                        ? FieldType.INT_NUMBER
                        : FieldType.TEXT,
                    fieldController: _updateFieldController,
                    fieldValidator: RequiredValidator(
                        errorText:
                            "${widget.bottomSheetTitle} cannot be empty."),
                    fieldFocusNode: _updateFieldFocusNode,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: EmptyTextField(
                    toggleRemoveText: clearTextField,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: CustomButton(
                buttonType: ButtonType.LOADING_FORM_BUTTON,
                buttonLabel: widget.bottomSheetButtonLabel,
                triggerAction: () => _updateFieldValue(
                  updateField: widget.updateField,
                  updatedFieldValue: _updateFieldController.text,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // updates the value present in the textfield according to [UpdateField] type
  void _updateFieldValue({
    @required UpdateField updateField,
    @required String updatedFieldValue,
  }) async {
    // instance of [ButtonLoadingProvider]
    ButtonLoadingProvider buttonLoadingProvider =
        context.read<ButtonLoadingProvider>();

    // sets [isLoading] to true
    buttonLoadingProvider.setIsLoading();

    // variable of type [User] to store updating data.
    User partialUserData;

    // checks if the incoming updated data is [FULLNAME] or [PHONENUMBER]
    if (updateField == UpdateField.FULLNAME) {
      partialUserData = new User(fullName: updatedFieldValue);
    } else {
      partialUserData = new User(phoneNumber: updatedFieldValue);
    }

    // converts the updating user data into json file.
    String partialUserDataJson = jsonEncode(partialUserData);

    // [UserViewModel] instance
    UserViewModel userViewModel = context.read<UserViewModel>();

    // calls function in [UserViewModel] to update user data.
    await userViewModel.updateUserDetails(updatedUser: partialUserDataJson);

    // removes focus from the textfield.
    FocusScope.of(context).unfocus();

    // checks the response status after api call.
    // then shows the an information dialog displaying
    // success message if response status is [COMPLETE].
    // error message if repsonse status is [ERROR].
    // also, sets [isLoading] to false in either case.
    if (userViewModel.data.status == Status.COMPLETE) {
      // sets [isLoading] to false.
      buttonLoadingProvider.removeIsLoading();

      showDialog(
        context: context,
        builder: (context) => InformationDialogBox(
          contentType: ContentType.DONE,
          content: updateField == UpdateField.FULLNAME
              ? AccordLabels.updateSuccessMessage(AccordLabels.fullName)
              : AccordLabels.updateSuccessMessage(AccordLabels.phoneNumber),
          actionText: AccordLabels.okay,
        ),
      );
    } else if (userViewModel.data.status == Status.ERROR) {
      // sets [isLoading] to false.
      buttonLoadingProvider.removeIsLoading();

      // diaplays error dialog
      showDialog(
        context: context,
        builder: (context) => InformationDialogBox(
          contentType: ContentType.ERROR,
          content: userViewModel.data.message,
          actionText: AccordLabels.tryAgain,
        ),
      ).whenComplete(
        () =>
            // if error arises, request focus for the [update textfield]
            _updateFieldFocusNode.requestFocus(),
      );
    }
  }
}

enum UpdateField {
  FULLNAME,
  PHONENUMBER,
}
