class User {
  final String id;
  final String fullName;
  final String email;
  final String password;
  final String phoneNumber;
  final String image;

  User({
    this.id,
    this.fullName,
    this.email,
    this.password,
    this.phoneNumber,
    this.image,
  });

  // json file to object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      fullName: json['fullName'],
      email: json['email'],
      // password: json['password'],
      phoneNumber: json['phoneNumber'],
      image: json['image'],
    );
  }

  // object to json file
  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'email': email,
        'password': password,
      };
}
