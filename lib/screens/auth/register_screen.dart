import 'dart:convert';

import 'package:accord/models/user.dart';
import 'package:accord/responses/register_response.dart';
import 'package:accord/screens/widgets/conceal_password.dart';
import 'package:accord/screens/widgets/custom_button.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/screens/widgets/custom_snackbar.dart';
import 'package:accord/screens/widgets/custom_text_field.dart';
import 'package:accord/viewModel/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:accord/Animation/FadeAnimation.dart';
import 'package:accord/screens/auth/login_screen.dart';
import 'package:form_field_validator/form_field_validator.dart';

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
  final _validateFirstName =
      MultiValidator([RequiredValidator(errorText: "First name is required!")]);

  final _validateLastName =
      MultiValidator([RequiredValidator(errorText: "Last name is required!")]);

  final _validateEmail = MultiValidator([
    RequiredValidator(errorText: "Email is required!"),
    EmailValidator(
        errorText: "Invalid email, please update it and check again!")
  ]);

  final _validatePassword = MultiValidator([
    RequiredValidator(errorText: "Password is required!"),
    MinLengthValidator(6, errorText: "Password must be atleast 6 character!")
  ]);

  // Toggles the password show status
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> _registerUser() async {
    UserViewModel _userViewModel = new UserViewModel();
    RegisterResponse _registerResponse;

    if (_formKey.currentState.validate()) {
      // user object
      User user = User(
        fullName: "${_firstNameController.text} ${_lastNameController.text}",
        email: _emailController.text,
        password: _passwordController.text,
      );

      // user object to json file conversion
      String userJSON = jsonEncode(user);

      // connecting and waitng for response from api through viewModel,
      //also returns response of type `RegisterResponse`
      _registerResponse = await _userViewModel.registerUser(userJSON);

      // checking resoponse and displaing customized error or success message
      if (_registerResponse.success) {
        // snackbar for successful user registration response
        ScaffoldMessenger.of(context).showSnackBar(MessageHolder()
            .popSnackbar(_registerResponse.message, "Okay", this.context));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        // snackbar for failed user registration response
        ScaffoldMessenger.of(context).showSnackBar(MessageHolder()
            .popSnackbar(_registerResponse.message, "Try Again", this.context));
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
                      holderKey: "ttlRegister",
                      textToShow: "Register",
                      textColor: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                    1.2,
                    CustomText(
                      holderKey: "tagRegister",
                      textToShow: "Get yourself a new Account.",
                      textColor: Colors.grey.shade50,
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
                                        fieldController: _firstNameController,
                                        obscureText: _obscureText,
                                        hintText: "First Name",
                                        fieldValidator: _validateFirstName,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 5),
                                      child: CustomTextField(
                                        fieldController: _lastNameController,
                                        obscureText: _obscureText,
                                        hintText: "Last Name",
                                        fieldValidator: _validateLastName,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 5),
                                      child: CustomTextField(
                                        fieldController: _emailController,
                                        obscureText: _obscureText,
                                        hintText: "Email",
                                        fieldValidator: _validateEmail,
                                      ),
                                    ),
                                    Stack(
                                      alignment: Alignment.centerRight,
                                      children: <Widget>[
                                        CustomTextField(
                                          fieldController: _passwordController,
                                          obscureText: _obscureText,
                                          hintText: "Password",
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
                            buttonKey: "btnRegister",
                            buttonText: "Register",
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
                                holderKey: "askLogin",
                                textToShow: "Already have an account? ",
                                textColor: Colors.grey.shade700,
                              ),
                            ),
                            FadeAnimation(
                              1.8,
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ));
                                },
                                child: CustomText(
                                  holderKey: "lnkLogin",
                                  textToShow: "Login",
                                  textColor: Colors.blue,
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
