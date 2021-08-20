import 'package:accord/constant/accord_labels.dart';
import 'package:accord/screens/auth/login_screen.dart';
import 'package:accord/screens/widgets/conceal_password.dart';
import 'package:accord/screens/widgets/custom_button.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/screens/widgets/custom_text_field.dart';
import 'package:accord/screens/widgets/information_dialog_box.dart';
import 'package:accord/screens/widgets/loading_indicator.dart';
import 'package:accord/utils/exposer.dart';
import 'package:accord/viewModel/screen_view_model.dart';
import 'package:accord/viewModel/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _cmfPasswordController = TextEditingController();

  final FocusNode _oldPasswordFocusNode = FocusNode();
  final FocusNode _newPasswordFocusNode = FocusNode();
  final FocusNode _confirmNewPasswordFocusNode = FocusNode();

  final _requireOldPassword = MultiValidator([
    RequiredValidator(
        errorText: AccordLabels.requireMessage(AccordLabels.oldPassword))
  ]);
  final _requireNewPassword = MultiValidator([
    RequiredValidator(
        errorText: AccordLabels.requireMessage(AccordLabels.newPassword)),
    MinLengthValidator(6, errorText: "Password must be atleast 6 character!")
  ]);

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _cmfPasswordController.dispose();

    super.dispose();
  }

  bool _oldPassword = true;
  bool _newPassword = true;
  bool _cmfPassword = true;

  void _toggleOld() {
    setState(() {
      _oldPassword = !_oldPassword;
    });
  }

  void _toggleNew() {
    setState(() {
      _newPassword = !_newPassword;
    });
  }

  void _toggleCmf() {
    setState(() {
      _cmfPassword = !_cmfPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 260,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  width: double.infinity,
                  child: SingleChildScrollView(
                    reverse: false,
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AccordLabels.changePassword,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 28,
                                color: Color(0xff13293d)),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  Stack(
                                    alignment: Alignment.centerRight,
                                    children: <Widget>[
                                      CustomTextField(
                                        designType: DesignType.UNDERLINE,
                                        fieldController: _oldPasswordController,
                                        obscureText: _oldPassword,
                                        hintText: AccordLabels.oldPassword,
                                        fieldValidator: _requireOldPassword,
                                        fieldFocusNode: _oldPasswordFocusNode,
                                        onEditComplete: () =>
                                            FocusScope.of(context).requestFocus(
                                                _newPasswordFocusNode),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: ConcealPassword(
                                          obscurePassword: _oldPassword,
                                          toggleConceal: _toggleOld,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Stack(
                                    alignment: Alignment.centerRight,
                                    children: <Widget>[
                                      CustomTextField(
                                        designType: DesignType.UNDERLINE,
                                        fieldController: _newPasswordController,
                                        obscureText: _newPassword,
                                        hintText: AccordLabels.newPassword,
                                        fieldValidator: _requireNewPassword,
                                        fieldFocusNode: _newPasswordFocusNode,
                                        onEditComplete: () =>
                                            FocusScope.of(context).requestFocus(
                                                _confirmNewPasswordFocusNode),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: ConcealPassword(
                                          obscurePassword: _newPassword,
                                          toggleConceal: _toggleNew,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Stack(
                                    alignment: Alignment.centerRight,
                                    children: <Widget>[
                                      TextFormField(
                                        controller: _cmfPasswordController,
                                        obscureText: _cmfPassword,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (val) => MatchValidator(
                                                errorText:
                                                    "Does not match with above password!")
                                            .validateMatch(val,
                                                _newPasswordController.text),
                                        decoration: InputDecoration(
                                          hintText:
                                              AccordLabels.confirmNewPassword,
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        focusNode: _confirmNewPasswordFocusNode,
                                        textInputAction: TextInputAction.next,
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: ConcealPassword(
                                          obscurePassword: _cmfPassword,
                                          toggleConceal: _toggleCmf,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      CustomText(
                                        textToShow: AccordLabels.forgotPassword,
                                        textColor: Colors.grey.shade700,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  CustomButton(
                                    buttonType: ButtonType.OVAL,
                                    buttonLabel: AccordLabels.changePassword,
                                    triggerAction: changePassword,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 85,
          left: 15,
          child: Container(
            padding: EdgeInsets.zero,
            height: 26,
            width: 26,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1.2),
                borderRadius: BorderRadius.circular(5)),
            child: IconButton(
              padding: EdgeInsets.only(left: 5),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Future<void> changePassword() async {
    FocusScope.of(context).unfocus();
    final String currentPassword = _oldPasswordController.text;
    final String newPassword = _newPasswordController.text;

    if (_formKey.currentState.validate()) {
      if (currentPassword != newPassword) {
        // pops loading screen.
        loadingIndicator(context);

        // [UserViewModel] provider instance
        UserViewModel userViewModel = context.read<UserViewModel>();

        // api call to update user password
        await userViewModel.updateUserPassword(
            currentPassword: currentPassword, newPassword: newPassword);

        // closes loading screen.
        Navigator.of(context, rootNavigator: true).pop();

        // check response status and perform action accordingly
        if (userViewModel.data.status == Status.COMPLETE) {
          // pops information dialog encouraging user to login again.
          showDialog(
            context: context,
            builder: (context) => InformationDialogBox(
              contentType: ContentType.DONE,
              content: "${userViewModel.data.message} \nPlease login again!!!",
              actionText: AccordLabels.login,
            ),
          ).whenComplete(() {
            // logs out user when dialog is closed.
            Navigator.of(context, rootNavigator: true).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );

            // sets tab to HOME_SCREEN after logout.
            context.read<ScreenViewModel>().restoreInitialTab(HOME_SCREEN);
          });
        } else if (userViewModel.data.status == Status.ERROR) {
          // displays error message in dialog box.
          showDialog(
            context: context,
            builder: (context) => InformationDialogBox(
              contentType: ContentType.ERROR,
              content: userViewModel.data.message,
              actionText: AccordLabels.tryAgain,
            ),
          );
        }
      } else {
        // shows information dialog if old & new password are same.
        showDialog(
          context: context,
          builder: (context) => InformationDialogBox(
            contentType: ContentType.INFORMATION,
            content: "New password cannot be same as old password",
            actionText: AccordLabels.okay,
          ),
        );
      }
    }
  }
}
