class CartItem {
  CartItem({
    this.bookID,
    this.name,
    this.images,
    this.price,
    this.quantity,
    this.totalPrice,
  });

  final String bookID;
  final String name;
  final String images;
  final double price;
  final int quantity;
  final int totalPrice;

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      bookID: json['_id'],
      name: json['name'],
      images: json['images'],
      price: double.parse(json['price'].toString()),
      quantity: json['quantity'],
      totalPrice: json['totalPrice'],
    );
  }

  Map<String, dynamic> toJson() => {
        'bookID': bookID,
        'quantity': quantity,
      };
}
