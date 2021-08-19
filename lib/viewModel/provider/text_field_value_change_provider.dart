import 'package:flutter/foundation.dart';

class TextFieldValueChangeProvider extends ChangeNotifier {
  /// denotes if the value has changed in the given [TextField].
  bool get Valuechanged => _valueChanged;
  bool _valueChanged = false;

  /// sets [valueChange] to true
  void setValueChanged() {
    _valueChanged = true;
    notifyListeners();
  }

  /// sets [valueChange] to false
  void removeValueChange() {
    _valueChanged = false;
    notifyListeners();
  }

  /// initialize all the values this provider holds to default.
  void initializer() {
    _valueChanged = false;
  }
}
