import 'package:flutter/foundation.dart';

class ButtonLoadingProvider with ChangeNotifier {
  /// denotes if the [button click action] is in progress.
  bool get isLoading => _isLoading;
  bool _isLoading = false;

  /// sets [isLoading] to true
  void setIsLoading() {
    _isLoading = true;
    notifyListeners();
  }

  /// sets [isLoading] to false
  void removeIsLoading() {
    _isLoading = false;
    notifyListeners();
  }

  /// initialize all the values this provider holds to default.
  void initializer() {
    _isLoading = false;
  }
}
