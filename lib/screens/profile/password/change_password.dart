import 'package:accord/screens/widgets/conceal_password.dart';
import 'package:accord/screens/widgets/custom_button.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/screens/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _cmfPasswordController = TextEditingController();

  final _requireOldPassword = MultiValidator(
      [RequiredValidator(errorText: "Old Password is required!")]);
  final _requireNewPassword = MultiValidator(
      [RequiredValidator(errorText: "Please insert your new Password!")]);
  final _requireCmfPassword = MultiValidator(
      [RequiredValidator(errorText: "Please confirm your new Password!")]);

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _cmfPasswordController.dispose();

    super.dispose();
  }

  Future<void> changePassword() async {}

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
                            "Change Password",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 28,
                                color: Color(0xff13293d)),
                          ),
                          SizedBox(
                            height: 10,
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
                                        fieldController: _oldPasswordController,
                                        obscureText: _oldPassword,
                                        hintText: "Old Password",
                                        fieldValidator: _requireOldPassword,
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
                                  Stack(
                                    alignment: Alignment.centerRight,
                                    children: <Widget>[
                                      CustomTextField(
                                        fieldController: _newPasswordController,
                                        obscureText: _newPassword,
                                        hintText: "New Password",
                                        fieldValidator: _requireNewPassword,
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
                                  Stack(
                                    alignment: Alignment.centerRight,
                                    children: <Widget>[
                                      CustomTextField(
                                        fieldController: _cmfPasswordController,
                                        obscureText: _cmfPassword,
                                        hintText: "Confirm Password",
                                        fieldValidator: _requireCmfPassword,
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
                                        textToShow: "Forgot Password?",
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
                                    buttonLabel: "Change Password",
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
}
