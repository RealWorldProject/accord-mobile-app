import 'package:accord/constant/accord_labels.dart';
import 'package:accord/responses/login_response.dart';
import 'package:accord/screens/auth/register_screen.dart';
import 'package:accord/screens/widgets/conceal_password.dart';
import 'package:accord/screens/widgets/custom_button.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/screens/widgets/custom_text_field.dart';
import 'package:accord/screens/bottom_navigation.dart';
import 'package:accord/screens/widgets/custom_snackbar.dart';
import 'package:accord/services/storage.dart';
import 'package:accord/viewModel/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:accord/Animation/FadeAnimation.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordcontroller = TextEditingController();

  // input field validation
  final _requireEmail = MultiValidator([
    RequiredValidator(
        errorText: AccordLabels.requireMessage(AccordLabels.email))
  ]);

  final _requirePassword = MultiValidator([
    RequiredValidator(
        errorText: AccordLabels.requireMessage(AccordLabels.password))
  ]);

  // Toggles the password show status
  bool _obscurePassword = true;
  void _toggle() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordcontroller.dispose();

    super.dispose();
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
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', _loginResponse.token);
        Storage().storeToken("Bearer ${_loginResponse.token}");
        // navigating to dashboard
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => BottomNavigation()));
      } else {
        //else displaying error messages.
        ScaffoldMessenger.of(context).showSnackBar(customSnackbar(
          content: _loginResponse.message,
          context: context,
          actionLabel: AccordLabels.tryAgain,
        ));
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
                            textToShow: AccordLabels.greet,
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        FadeAnimation(
                          1.3,
                          CustomText(
                            textToShow: AccordLabels.loginGuide,
                            textColor: Colors.grey.shade700,
                            fontWeight: FontWeight.w400,
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
                                        designType: DesignType.UNDERLINE,
                                        fieldController: _emailController,
                                        hintText: AccordLabels.email,
                                        fieldValidator: _requireEmail,
                                        fieldType: FieldType.ALL,
                                      ),
                                    ),
                                    Stack(
                                      alignment: Alignment.centerRight,
                                      children: <Widget>[
                                        CustomTextField(
                                          designType: DesignType.UNDERLINE,
                                          obscureText: _obscurePassword,
                                          fieldController: _passwordcontroller,
                                          hintText: AccordLabels.password,
                                          fieldValidator: _requirePassword,
                                          fieldType: FieldType.ALL,
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: ConcealPassword(
                                            obscurePassword: _obscurePassword,
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
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FadeAnimation(
                              1.5,
                              CustomText(
                                textToShow: AccordLabels.forgotPassword,
                                textColor: Colors.grey.shade700,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
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
                            buttonType: ButtonType.OVAL,
                            buttonLabel: AccordLabels.login,
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
                                textToShow: AccordLabels.askRegister,
                                textColor: Colors.grey.shade700,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            FadeAnimation(
                              1.8,
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterScreen()));
                                },
                                child: CustomText(
                                  textToShow: AccordLabels.register,
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
