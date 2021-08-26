class Order {
  Order({
    this.id,
    this.orderID,
    this.fullName,
    this.phoneNumber,
    this.state,
    this.city,
    this.area,
    this.address,
    this.coordinates,
    this.paymentGateway,
    this.orderItems,
    this.status,
    this.createAt,
  });

  final String id;
  final String orderID;
  final String fullName;
  final String phoneNumber;
  final String state;
  final String city;
  final String area;
  final String address;
  final String coordinates;
  final String paymentGateway;
  final List<OrderItem> orderItems;
  final String status;
  final DateTime createAt;

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'],
      orderID: json['orderID'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      state: json['state'],
      city: json['city'],
      area: json['area'],
      address: json['address'],
      coordinates: json['coordinates'],
      paymentGateway: json['paymentGateway'],
      orderItems: (json['orderItems'] as List)
          .map((cartItem) => OrderItem.fromJson(cartItem))
          .toList(),
      status: json['status'],
      createAt: DateTime.parse(json['createdAt']),
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

// partial book/cartItem item as orderitem.
class OrderItem {
  OrderItem({
    this.bookName,
    this.bookPrice,
    this.bookAuthor,
    this.bookImage,
    this.quantity,
    this.totalPrice,
  });

  final String bookName;
  final String bookPrice;
  final String bookAuthor;
  final String bookImage;
  final String quantity;
  final String totalPrice;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        bookName: json['bookName'],
        bookPrice: json['bookPrice'].toString(),
        bookAuthor: json['bookAuthor'],
        bookImage: json['bookImage'],
        quantity: json['quantity'].toString(),
        totalPrice: json['totalPrice'].toString(),
      );
}
