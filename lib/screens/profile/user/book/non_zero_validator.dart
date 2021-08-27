import 'package:flutter/cupertino.dart';
import 'package:form_field_validator/form_field_validator.dart';

class NonZeroValidator extends TextFieldValidator {
  NonZeroValidator({@required String errorText}) : super(errorText);

  @override
  bool get ignoreEmptyValues => true;

  @override
  bool isValid(String value) {
    return double.parse(value) > 0;
  }
}
