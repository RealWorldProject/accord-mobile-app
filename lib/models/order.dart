class Order {
  Order({
    this.fullName,
    this.phoneNumber,
    this.state,
    this.city,
    this.area,
    this.address,
    this.coordinates,
    this.paymentGateway,
  });

  final String fullName;
  final String phoneNumber;
  final String state;
  final String city;
  final String area;
  final String address;
  final String coordinates;
  final String paymentGateway;

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      state: json['state'],
      city: json['city'],
      area: json['area'],
      address: json['address'],
      coordinates: json['coordinates'],
      paymentGateway: json['paymentGateway'],
    );
  }

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'state': state,
        'city': city,
        'area': area,
        'address': address,
        'coordinates': coordinates,
        'paymentGateway': paymentGateway,
      };
}
