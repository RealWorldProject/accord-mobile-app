import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class CustomTextField<T> extends StatelessWidget {
  // takes four parameter and return a workable TextFormField object
  // these parameter consists of a controller, obscureText,
  // hint text and validator.
  // formType, distinctly, is used to unify the design for post book form
  final String formType;
  final TextEditingController fieldController;
  final bool obscureText;
  final String hintText;
  final FieldValidator fieldValidator;

  CustomTextField({
    this.formType,
    this.fieldController,
    this.obscureText,
    this.hintText,
    this.fieldValidator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: fieldController,
      // hiding texts if the text field is password
      obscureText: (() {
        if (hintText == "Password") {
          return obscureText;
        } else {
          return false;
        }
      }()),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: fieldValidator,
      decoration: (() {
        if (formType == "PostBook") {
          return InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            hintText: "Book's Name",
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
          );
        } else {
          return InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
          );
        }
      }()),
      textInputAction: TextInputAction.next,
    );
  }
}
