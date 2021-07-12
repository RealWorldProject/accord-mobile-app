import 'package:accord/models/user.dart';

class UserViewModel {
  final User user;

  UserViewModel({this.user});

  String get firstName {
    return this.user.firstName;
  }

  String get lastName {
    return this.user.lastName;
  }

  String get email {
    return this.user.email;
  }

  String get password {
    return this.user.password;
  }
}
