import 'package:accord/screens/dashboard_screen.dart';
import 'package:accord/screens/auth/register_screen.dart';
import 'package:accord/services/login_service.dart';
import 'package:accord/screens/widgets/custom_snackbar.dart';
import 'package:accord/services/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:accord/Animation/FadeAnimation.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var email, password, loginResult;

  final requireEmail = RequiredValidator(errorText: 'Email is required!');
  final requirePassword = RequiredValidator(errorText: 'Password is required!');

  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> validateLogin() async {
    if (formKey.currentState.validate()) {
      // api request
      loginResult = await LoginService().loginUser(email, password);
      if (loginResult['success']) {
        // storing token
        Storage().storeToken(loginResult['token']);
        // navigating to dashboard
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DashboardScreen()));
      } else {
        //else displaying error messages.
        ScaffoldMessenger.of(context).showSnackBar(MessageHolder()
            .popSnackbar(loginResult['message'], 'Try Again', this.context));
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
                            Text(
                              "Welcome Back",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 30),
                            )),
                        FadeAnimation(
                            1.3,
                            Text(
                              "Login to your Account",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 18),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        FadeAnimation(
                            1.4,
                            Container(
                              child: Form(
                                key: formKey,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child: TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        decoration: InputDecoration(
                                          hintText: "Email ",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                          ),
                                        ),
                                        textInputAction: TextInputAction.next,
                                        onChanged: (val) => email = val,
                                        validator: requireEmail,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 8),
                                      child: TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        obscureText: _obscureText,
                                        decoration: InputDecoration(
                                          hintText: "Password",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey)),
                                          suffixIcon: InkWell(
                                              onTap: _toggle,
                                              child: (_obscureText)
                                                  ? Icon(Icons.visibility_off)
                                                  : Icon(Icons.visibility)),
                                        ),
                                        textInputAction: TextInputAction.done,
                                        onChanged: (val) => password = val,
                                        validator: requirePassword,
                                      ),
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
                              Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    color: Colors.grey[900], fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FadeAnimation(
                            1.6,
                            InkWell(
                              onTap: () {
                                validateLogin();
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: Colors.blue),
                                child: Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FadeAnimation(
                                1.7,
                                Text(
                                  "Don't have an account? ",
                                  style: TextStyle(
                                      color: Colors.grey[900], fontSize: 16),
                                )),
                            FadeAnimation(
                                1.8,
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SignupScreen()));
                                    },
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.blue),
                                    )))
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
