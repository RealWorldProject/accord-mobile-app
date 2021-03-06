import 'dart:convert';

import 'package:accord/constant/accord_labels.dart';
import 'package:accord/models/user.dart';
import 'package:accord/screens/widgets/conceal_password.dart';
import 'package:accord/screens/widgets/custom_button.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/screens/widgets/custom_snackbar.dart';
import 'package:accord/screens/widgets/custom_text_field.dart';
import 'package:accord/screens/widgets/information_dialog_box.dart';
import 'package:accord/screens/widgets/loading_indicator.dart';
import 'package:accord/utils/exposer.dart';
import 'package:accord/viewModel/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:accord/Animation/FadeAnimation.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // input field validations
  final _validateFirstName = MultiValidator([
    RequiredValidator(
        errorText: AccordLabels.requireMessage(AccordLabels.firstName)),
  ]);

  final _validateLastName = MultiValidator([
    RequiredValidator(
        errorText: AccordLabels.requireMessage(AccordLabels.lastName))
  ]);

  final _validateEmail = MultiValidator([
    RequiredValidator(
        errorText: AccordLabels.requireMessage(AccordLabels.email)),
    EmailValidator(errorText: AccordLabels.invalidMessage(AccordLabels.email))
  ]);

  final _validatePassword = MultiValidator([
    RequiredValidator(
        errorText: AccordLabels.requireMessage(AccordLabels.password)),
    MinLengthValidator(6, errorText: AccordLabels.passwordLengthMessage),
  ]);

  // Toggles the password show status
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  Future<void> _registerUser() async {
    if (_formKey.currentState.validate()) {
      // pops loading screen.
      loadingIndicator(context);

      // user object
      User user = User(
        fullName: "${_firstNameController.text} ${_lastNameController.text}",
        email: _emailController.text,
        password: _passwordController.text,
      );

      // user object to json file conversion
      String userJSON = jsonEncode(user);

      // [UserViewModel] instance
      UserViewModel userViewModel = context.read<UserViewModel>();

      // calls api to register user.
      await userViewModel.registerUser(userJSON);

      // closes loading screen.
      Navigator.of(context).pop();

      // checking resoponse and displaing customized error or success message
      if (userViewModel.data.status == Status.COMPLETE) {
        // returns to login screen
        Navigator.of(context).pop();

        // snackbar for successful user registration response
        showDialog(
          context: context,
          builder: (context) => InformationDialogBox(
            contentType: ContentType.DONE,
            content: userViewModel.data.message,
            actionText: AccordLabels.okay,
          ),
        );
      } else if (userViewModel.data.status == Status.ERROR) {
        // snackbar for failed user registration response
        ScaffoldMessenger.of(context).showSnackBar(customSnackbar(
          context: context,
          content: userViewModel.data.message.split("\n").last,
          actionLabel: AccordLabels.tryAgain,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.blueAccent[400],
          Colors.blue[400],
          Colors.blue[200]
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                    1,
                    CustomText(
                      textToShow: AccordLabels.register,
                      textColor: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                    1.2,
                    CustomText(
                      textToShow: AccordLabels.registerTag,
                      textColor: Colors.grey.shade50,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        FadeAnimation(
                            1.3,
                            Container(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child: CustomTextField(
                                        key:Key("firstName"),
                                        designType: DesignType.UNDERLINE,
                                        fieldType: FieldType.TEXT,
                                        fieldController: _firstNameController,
                                        hintText: AccordLabels.firstName,
                                        fieldValidator: _validateFirstName,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 5),
                                      child: CustomTextField(
                                        key:Key("lastName"),
                                        designType: DesignType.UNDERLINE,
                                        fieldType: FieldType.TEXT,
                                        fieldController: _lastNameController,
                                        hintText: AccordLabels.lastName,
                                        fieldValidator: _validateLastName,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 5),
                                      child: CustomTextField(
                                        key:Key("email"),
                                        designType: DesignType.UNDERLINE,
                                        fieldController: _emailController,
                                        hintText: AccordLabels.email,
                                        fieldValidator: _validateEmail,
                                      ),
                                    ),
                                    Stack(
                                      alignment: Alignment.centerRight,
                                      children: <Widget>[
                                        CustomTextField(
                                          key:Key("password"),
                                          designType: DesignType.UNDERLINE,
                                          obscureText: _obscureText,
                                          fieldController: _passwordController,
                                          hintText: AccordLabels.password,
                                          fieldValidator: _validatePassword,
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: ConcealPassword(
                                            obscurePassword: _obscureText,
                                            toggleConceal: _toggle,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        FadeAnimation(
                          1.6,
                          CustomButton(
                            key:Key("register"),
                            buttonType: ButtonType.OVAL,
                            buttonLabel: AccordLabels.register,
                            triggerAction: _registerUser,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FadeAnimation(
                              1.7,
                              CustomText(
                                textToShow: AccordLabels.askLogin,
                                textColor: Colors.grey.shade700,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            FadeAnimation(
                              1.8,
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: CustomText(
                                  textToShow: AccordLabels.login,
                                  textColor: Colors.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
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
