import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final String initialValue;
  final Key key;

  CustomTextField({
    this.formType,
    this.fieldController,
    this.obscureText,
    this.hintText,
    this.fieldValidator,
    this.initialValue,
    this.key
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
       key:key,
      controller: fieldController,
      // hiding texts if the text field is any type of password
      obscureText: (hintText.split(" ").contains("Password") ||
              hintText.split(" ").contains("password"))
          ? obscureText
          : false,
      // separately defining number of lines for description
      maxLines: (hintText == "Description") ? 7 : 1,
      // separately defining keyboard type for price
      keyboardType: (hintText == "Price")
          ? TextInputType.numberWithOptions(decimal: true)
          : null,
      // allowing only one dot in price field.
      inputFormatters: (hintText == "Price")
          ? [FilteringTextInputFormatter.allow(RegExp(r"^\d*\.?\d*"))]
          : [],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: fieldValidator,
      decoration: (() {
        // defining separate styles for fields in post book form
        if (formType == "PostBook") {
          return InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            hintText: hintText,
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
      initialValue: initialValue,

    );
  }
}
