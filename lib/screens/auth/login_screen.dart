import 'package:accord/responses/login_response.dart';
import 'package:accord/screens/auth/register_screen.dart';
import 'package:accord/screens/widgets/conceal_password.dart';
import 'package:accord/screens/widgets/custom_button.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/screens/widgets/custom_text_field.dart';
import 'package:accord/screens/widgets/navigation_bar.dart';
import 'package:accord/screens/widgets/custom_snackbar.dart';
import 'package:accord/services/storage.dart';
import 'package:accord/viewModel/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:accord/Animation/FadeAnimation.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordcontroller = TextEditingController();

  // input field validation
  final _requireEmail =
      MultiValidator([RequiredValidator(errorText: "Email is required!")]);

  final _requirePassword =
      MultiValidator([RequiredValidator(errorText: "Password is required!")]);

  // Toggles the password show status
  bool _obscurePassword = true;
  void _toggle() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  Future<void> _validateLogin() async {
    String _email = _emailController.text;
    String _password = _passwordcontroller.text;
    UserViewModel _userViewModel = new UserViewModel();
    LoginResponse _loginResponse;
    if (_formKey.currentState.validate()) {
      // viewModel makes api request and returns response
      _loginResponse = await _userViewModel.loginUser(_email, _password);

      if (_loginResponse.success) {
        // storing token
        Storage().storeToken("Bearer ${_loginResponse.token}");
        // navigating to dashboard
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => NavigationBar()));
      } else {
        //else displaying error messages.
        ScaffoldMessenger.of(context).showSnackBar(MessageHolder()
            .popSnackbar(_loginResponse.message, "Try Again", this.context));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
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
                    )),
                child: SingleChildScrollView(
                  reverse: false,
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FadeAnimation(
                          1,
                          CustomText(
                            holderKey: "grtUser",
                            textToShow: "Welcome Back!",
                          ),
                        ),
                        FadeAnimation(
                          1.3,
                          CustomText(
                            holderKey: "gidLogin",
                            textToShow: "Login to the Accord!",
                            textColor: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FadeAnimation(
                            1.4,
                            Container(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child: CustomTextField(
                                        fieldController: _emailController,
                                        obscureText: _obscurePassword,
                                        hintText: "Email",
                                        fieldValidator: _requireEmail,
                                      ),
                                    ),
                                    Stack(
                                      alignment: Alignment.centerRight,
                                      children: <Widget>[
                                        CustomTextField(
                                          fieldController: _passwordcontroller,
                                          obscureText: _obscurePassword,
                                          hintText: "Password",
                                          fieldValidator: _requirePassword,
                                        ),
                                        ConcealPassword(
                                          obscurePassword: _obscurePassword,
                                          toggleConceal: _toggle,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FadeAnimation(
                              1.5,
                              CustomText(
                                holderKey: "ask",
                                textToShow: "Forgot Password?",
                                textColor: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FadeAnimation(
                          1.6,
                          CustomButton(
                            buttonKey: "btnLogin",
                            buttonText: "Login",
                            triggerAction: _validateLogin,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FadeAnimation(
                              1.7,
                              CustomText(
                                holderKey: "askRegister",
                                textToShow: "Don't have an account? ",
                                textColor: Colors.grey.shade700,
                              ),
                            ),
                            FadeAnimation(
                              1.8,
                              GestureDetector(
                                key: Key("lnkRegister"),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterScreen()));
                                },
                                child: CustomText(
                                  holderKey: "lnkRegister",
                                  textToShow: "Register",
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
