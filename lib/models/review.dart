import 'package:accord/models/user.dart';

class Review {
  Review({
    this.review,
    this.rating,
    this.book,
    this.user,
    this.createdAt,
  });

  final String review;
  final double rating;
  final String book;
  final dynamic user;
  final DateTime createdAt;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        review: json['review'],
        rating: double.parse(json['rating'].toString()),
        book: json['book'],
        user: User.fromJson(json['user']),
        createdAt: DateTime.parse(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'review': review,
        'rating': rating,
      };
}
