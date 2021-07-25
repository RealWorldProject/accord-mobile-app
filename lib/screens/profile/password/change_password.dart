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
      [RequiredValidator(errorText: "Old Password is required!")]);
  final _requireCmfPassword = MultiValidator(
      [RequiredValidator(errorText: "Old Password is required!")]);

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
      body: Stack(
        children:
        [

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
                                  // Container(
                                  //   child: CustomTextField(
                                  //     fieldController: _oldPasswordController,
                                  //     obscureText: _obscurePassword,
                                  //     hintText: "Email",
                                  //     fieldValidator: _requireOldPassword,
                                  //   ),
                                  // ),
                                  TextFormField(
                                    obscureText: _oldPassword,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,

                                    decoration: InputDecoration(
                                      hintText: "Old Password",
                                      suffixIcon: IconButton(
                                        onPressed: _toggleOld,
                                        icon: _oldPassword
                                            ? Icon(Icons.visibility_off_rounded)
                                            : Icon(Icons.visibility_rounded),
                                      ),
                                    ),
                                    validator: _requireOldPassword,
                                  ),

                                  TextFormField(
                                    obscureText: _newPassword,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,

                                    decoration: InputDecoration(
                                      hintText: "New Password",
                                      suffixIcon: IconButton(
                                        onPressed: _toggleNew,
                                        icon: _newPassword
                                            ? Icon(Icons.visibility_off_rounded)
                                            : Icon(Icons.visibility_rounded),
                                      ),
                                    ),
                                    validator: _requireNewPassword,
                                  ),

                                  TextFormField(
                                    obscureText: _cmfPassword,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,

                                    decoration: InputDecoration(
                                      hintText: "Confirm Password",
                                      suffixIcon: IconButton(
                                        onPressed: _toggleCmf,
                                        icon: _cmfPassword
                                            ? Icon(Icons.visibility_off_rounded)
                                            : Icon(Icons.visibility_rounded),
                                      ),
                                    ),
                                    validator: _requireCmfPassword,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                        CustomText(
                                          holderKey: "ask",
                                          textToShow: "Forgot Password?",
                                          textColor: Colors.grey.shade700,
                                        ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),

                                  CustomButton(
                                    buttonKey: "btnCngPassword",
                                    buttonText: "Change Password",
                                    // triggerAction: _validateLogin,
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
        ]
      ),
    );
  }
}
