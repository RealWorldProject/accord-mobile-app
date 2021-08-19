import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';

class CustomTextField extends StatelessWidget {
  /// define either the field should be underlined or bordered.
  /// default set for BORDER field.
  final DesignType designType;

  /// define the content the field is for i.e, text, number, decimal_number
  /// default set for TEXT type.
  final FieldType fieldType;

  /// controller for the field
  final TextEditingController fieldController;

  /// defines if the content needs to be hide.
  /// default value set to false.
  /// set value true to hide the field contents.
  final bool obscureText;

  /// placeholder for the given field
  final String hintText;

  /// maximum number of lines. default set to 1.
  final int noOfLines;

  /// validation, if required, for the field.
  final FieldValidator fieldValidator;

  final FocusNode fieldFocusNode;

  /// starting value to be displayed in the field
  final String initialValue;

  final double designTypeBorderRadius;
  final double contentHorizontalPadding;
  final double contentVerticalPadding;

  CustomTextField({
    this.designType = DesignType.BORDER,
    this.fieldType = FieldType.ALL,
    @required this.fieldController,
    this.obscureText = false,
    this.hintText = "",
    this.noOfLines = 1,
    this.fieldValidator,
    this.fieldFocusNode,
    this.initialValue,
    this.designTypeBorderRadius = 8,
    this.contentHorizontalPadding = 10,
    this.contentVerticalPadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: fieldController,
      obscureText: obscureText,
      maxLines: noOfLines,
      keyboardType:
          fieldType == FieldType.NUMBER || fieldType == FieldType.NUMBER_ONLY
              ? TextInputType.numberWithOptions(decimal: true)
              : null,
      inputFormatters: fieldType == FieldType.NUMBER
          ? [FilteringTextInputFormatter.allow(RegExp(r"^\d*\.?\d*"))]
          : fieldType == FieldType.TEXT
              ? [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))]
              : fieldType == FieldType.NUMBER_ONLY
                  ? [FilteringTextInputFormatter.digitsOnly]
                  : fieldType == FieldType.TEXT_SPACE
                      ? [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]"))]
                      : [],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: fieldValidator,
      decoration: designType == DesignType.BORDER
          ? InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: contentHorizontalPadding,
                  vertical: contentVerticalPadding),
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(designTypeBorderRadius),
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
      focusNode: fieldFocusNode,
      textInputAction: TextInputAction.next,
      initialValue: initialValue,
    );
  }
}

enum DesignType {
  UNDERLINE,
  BORDER,
}

enum FieldType {
  /// accept all values
  TEXT,

  /// accepts text and space
  TEXT_SPACE,

  /// accept all values
  ALL,

  /// accept numbers along with one dot. i.e, [234125.34]
  NUMBER,

  /// accept numbers only
  NUMBER_ONLY,
}
