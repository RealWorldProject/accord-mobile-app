import 'package:flutter/material.dart';
import 'package:accord/Animation/FadeAnimation.dart';
import 'package:accord/screen/LoginScreen.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void validate() {
    if (formKey.currentState.validate()) {
      print("Validated");
    } else {
      print("Not Validated");
    }
  }

  String validatePassword(value) {
    if (value.isEmpty) {
      return "Password is required";
    } else if (value.length < 6) {
      return "Should be at least 6 characters";
    } else {
      return null;
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
                      Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                      1.2,
                      Text(
                        "Create an Account",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
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

                                key: formKey,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child: TextFormField(
                                        autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                        decoration: InputDecoration(
                                          hintText: "First Name",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                          ),
                                        ),
                                        validator: RequiredValidator(
                                            errorText:
                                                "First Name is required"),
                                      ),
                                    ),
                                    Container(
                                      autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                      padding: EdgeInsets.only(top: 5),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          hintText: "Last Name",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                          ),
                                        ),
                                        validator: RequiredValidator(
                                            errorText: "Last Name is required"),
                                      ),
                                    ),
                                    Container(
                                      autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                      padding: EdgeInsets.only(top: 5),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          hintText: "Email",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                          ),
                                        ),
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: "Email is required"),
                                          EmailValidator(
                                              errorText: "Not a valid Email")
                                        ]),
                                      ),
                                    ),
                                    Container(
                                      autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                      padding: EdgeInsets.only(top: 5),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          hintText: "Password",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                          ),
                                          suffixIcon:
                                              Icon(Icons.remove_red_eye),
                                        ),
                                        validator: validatePassword,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        FadeAnimation(
                            1.5,
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.blue),
                              child: Center(
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FadeAnimation(
                                1.7,
                                Text(
                                  "Already have an account? ",
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
                                                  LoginScreen()));
                                    },
                                    child: Text(
                                      "Login",
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
