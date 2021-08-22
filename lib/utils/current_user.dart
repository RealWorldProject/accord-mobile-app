import 'package:accord/services/storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class CurrentUser {
  static Future<String> get() async {
    final Map<String, dynamic> currentUser =
        JwtDecoder.decode(await Storage().fetchToken());
    return currentUser['id'];
  }
}
