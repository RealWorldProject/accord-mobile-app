import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  final tokenStorage = FlutterSecureStorage();

  // functions to store, track & remove user sessions
  Future<void> storeToken(myToken) async {
    await tokenStorage.write(key: 'userToken', value: myToken);
  }

  Future<String> fetchToken() async {
    return await tokenStorage.read(key: 'userToken');
  }

  Future<void> deleteToken() async {
    await tokenStorage.delete(key: 'userToken');
  }
}
