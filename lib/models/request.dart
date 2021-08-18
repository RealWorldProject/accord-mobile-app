import 'package:accord/models/book.dart';
import 'package:accord/models/user.dart';

class Request {
  Request({
    this.id,
    this.status,
    this.proposedExchangeBook,
    this.user,
    this.requestedBook,
    this.requestedBookOwner,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String status;
  final dynamic proposedExchangeBook;
  final dynamic user;
  final dynamic requestedBook;
  final dynamic requestedBookOwner;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      id: json['_id'],
      status: json['status'],
      proposedExchangeBook: Book.fromJson(json['proposedExchangeBook']),
      user: User.fromJson(json['user']),
      requestedBook: Book.fromJson(json['requestedBook']),
      requestedBookOwner: User.fromJson(json['requestedBookOwner']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() => {
        'proposedExchangeBook': proposedExchangeBook,
        'requestedBook': requestedBook,
      };
}
