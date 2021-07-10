import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  final tokenStorage = FlutterSecureStorage();

  void storeToken(myToken) async {
    await tokenStorage.write(key: 'userToken', value: myToken);
  }
}
