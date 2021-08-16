import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';

class CustomTextField extends StatelessWidget {
  // takes four parameter and return a workable TextFormField object
  // these parameter consists of a controller, obscureText,
  // hint text and validator.
  // formType, distinctly, is used to unify the design for post book form

  // define either the field should be underlined or bordered.
  // default set for BORDER field.
  final DesignType designType;

  // define the content the field is for i.e, text, password, number
  // default set for TEXT type.
  final FieldType fieldType;

  // controller for the field
  final TextEditingController fieldController;

  // if the content needs to be hide.
  // default value set to false.
  // set to true to hide the field contents.
  final bool obscureText;

  // placeholder for the given field
  final String hintText;

  // maximum number of lines. default set to 1.
  final int noOfLines;

  // validation, if required, for the field.
  final FieldValidator fieldValidator;
  final String initialValue;

  CustomTextField({
    this.designType = DesignType.BORDER,
    this.fieldType = FieldType.TEXT,
    @required this.fieldController,
    this.obscureText = false,
    this.hintText = "",
    this.noOfLines = 1,
    this.fieldValidator,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: fieldController,
      obscureText: obscureText,
      maxLines: noOfLines,
      keyboardType: fieldType == FieldType.NUMBER
          ? TextInputType.numberWithOptions(decimal: true)
          : null,
      inputFormatters: fieldType == FieldType.NUMBER
          ? [FilteringTextInputFormatter.allow(RegExp(r"^\d*\.?\d*"))]
          : [],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: fieldValidator,
      decoration: designType == DesignType.BORDER
          ? InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
            )
          : InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
      textInputAction: TextInputAction.next,
      initialValue: initialValue,

    );

    // return TextFormField(
    //   controller: fieldController,
    //   // hiding texts if the text field is any type of password
    //   obscureText: (hintText.split(" ").contains("Password") ||
    //           hintText.split(" ").contains("password"))
    //       ? obscureText
    //       : false,
    //   // separately defining number of lines for description
    //   maxLines: (hintText == "Description") ? 7 : 1,
    //   // separately defining keyboard type for price
    //   keyboardType: (hintText == "Price")
    //       ? TextInputType.numberWithOptions(decimal: true)
    //       : null,
    //   // allowing only one dot in price field.
    //   inputFormatters: (hintText == "Price")
    //       ? [FilteringTextInputFormatter.allow(RegExp(r"^\d*\.?\d*"))]
    //       : [],
    //   autovalidateMode: AutovalidateMode.onUserInteraction,
    //   validator: fieldValidator,
    //   decoration: (() {
    //     // defining separate styles for fields in post book form
    //     if (formType == "PostBook") {
    //       return InputDecoration(
    //         contentPadding: EdgeInsets.symmetric(horizontal: 10),
    //         hintText: hintText,
    //         hintStyle: TextStyle(color: Colors.grey),
    //         border: OutlineInputBorder(
    //           borderSide: BorderSide(color: Colors.grey),
    //           borderRadius: BorderRadius.circular(8),
    //         ),
    //       );
    //     } else {
    //       return InputDecoration(
    //         hintText: hintText,
    //         hintStyle: TextStyle(color: Colors.grey),
    //         border: UnderlineInputBorder(
    //           borderSide: BorderSide(
    //             color: Colors.grey,
    //           ),
    //         ),
    //       );
    //     }
    //   }()),
    //   textInputAction: TextInputAction.next,
    // );
  }
}

enum DesignType {
  UNDERLINE,
  BORDER,
}

enum FieldType {
  TEXT,
  NUMBER,
}
