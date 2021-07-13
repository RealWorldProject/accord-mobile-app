import 'package:accord/services/registration_service.dart';
import 'package:accord/screens/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:accord/Animation/FadeAnimation.dart';
import 'package:accord/screens/auth/login_screen.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var firstName, lastName, email, password, registrationResult;

  final validateFirstName =
      RequiredValidator(errorText: 'First name is required!');

  final validateLastName =
      RequiredValidator(errorText: 'Last name is required!');

  final validateEmail = MultiValidator([
    RequiredValidator(errorText: 'Email is required!'),
    EmailValidator(
        errorText: 'Invalid email, please update it and check again!')
  ]);

  final validatePassword = MultiValidator([
    RequiredValidator(errorText: 'Password is required!'),
    MinLengthValidator(6, errorText: 'Password must be atleast 6 character!')
  ]);

  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> registerUser() async {
    // connecting and waitng for response from api
    registrationResult = await RegistrationService()
        .registerUser('$firstName $lastName', email, password);

    // checking resoponse and displaing customized error or success message
    if (registrationResult['success']) {
      // snackbar for successful user registration response
      ScaffoldMessenger.of(context).showSnackBar(MessageHolder().popSnackbar(
          registrationResult['message'], 'To Login', this.context));
    } else {
      // snackbar for failed user registration response
      ScaffoldMessenger.of(context).showSnackBar(MessageHolder().popSnackbar(
          registrationResult['message'], 'Try Again', this.context));
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
                                        key:Key("firstName"),
                                          autofocus: true,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          decoration: InputDecoration(
                                            hintText: "First Name",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                          ),
                                          textInputAction: TextInputAction.next,
                                          onChanged: (val) => firstName = val,
                                          validator: validateFirstName),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 5),
                                      child: TextFormField(
                                        key:Key("lastName"),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        decoration: InputDecoration(
                                          hintText: "Last Name",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                          ),
                                        ),
                                        textInputAction: TextInputAction.next,
                                        onChanged: (val) => lastName = val,
                                        validator: validateLastName,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 5),
                                      child: TextFormField(
                                        key:Key("email"),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        decoration: InputDecoration(
                                          hintText: "Email",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                          ),
                                        ),
                                        textInputAction: TextInputAction.next,
                                        onChanged: (val) => email = val,
                                        validator: validateEmail,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 5),
                                      child: TextFormField(
                                        key:Key("password"),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        obscureText: _obscureText,
                                        decoration: InputDecoration(
                                            hintText: "Password",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            suffixIcon: InkWell(
                                                onTap: _toggle,
                                                child: (_obscureText)
                                                    ? Icon(Icons.visibility_off)
                                                    : Icon(Icons.visibility))),
                                        textInputAction: TextInputAction.done,
                                        onChanged: (val) => password = val,
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
                            1.6,
                            InkWell(
                              key: Key("register"),
                              onTap: () {
                                // form validation. if successful proceeds to api connection.
                                if (formKey.currentState.validate()) {
                                  registerUser();
                                }
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: Colors.blue),
                                child: Center(
                                  child: Text(
                                    "Sign up",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
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
                                        builder: (context) => LoginScreen(),
                                      ));
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.blue),
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
