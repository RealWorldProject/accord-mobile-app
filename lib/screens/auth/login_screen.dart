import 'package:accord/constant/accord_labels.dart';
import 'package:accord/screens/auth/register_screen.dart';
import 'package:accord/screens/widgets/conceal_password.dart';
import 'package:accord/screens/widgets/custom_button.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/screens/widgets/custom_text_field.dart';
import 'package:accord/screens/bottom_navigation.dart';
import 'package:accord/screens/widgets/custom_snackbar.dart';
import 'package:accord/screens/widgets/information_dialog_box.dart';
import 'package:accord/screens/widgets/loading_indicator.dart';
import 'package:accord/services/storage.dart';
import 'package:accord/utils/exposer.dart';
import 'package:accord/viewModel/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:accord/Animation/FadeAnimation.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

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
    if (_formKey.currentState.validate()) {
      // pops loading screen.
      loadingIndicator(context);

      String email = _emailController.text;
      String password = _passwordcontroller.text;

      // [UserViewModel] provider instance
      UserViewModel userViewModel = context.read<UserViewModel>();

      // viewModel makes api request and returns response
      await userViewModel.loginUser(email, password);

      // closes loading screen
      Navigator.of(context).pop();

      // checks response status and perform action accordingly.
      if (userViewModel.data.status == Status.COMPLETE) {
        // storing token to local storage
        Storage().storeToken("Bearer ${userViewModel.userToken}");

        // navigating to dashboard
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => BottomNavigation()));

        // clearing token from viewModel
        userViewModel.clearToken();
      } else {
        //else displaying error messages.
        userViewModel.data.message.split("\n").first == "Unauthorized:"
            ? showDialog(
                context: context,
                useRootNavigator: false,
                builder: (context) => InformationDialogBox(
                    contentType: ContentType.INFORMATION,
                    title: "Account Suspended!!!",
                    content:
                        "Suspension Cause: \n${userViewModel.data.message.split("\n").last == "null" ? "Unknown reason. Please report this problem." : userViewModel.data.message.split("\n").last}",
                    actionText: AccordLabels.okay))
            : ScaffoldMessenger.of(context).showSnackBar(customSnackbar(
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
