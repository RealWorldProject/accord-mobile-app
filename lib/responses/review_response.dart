import 'package:accord/models/review.dart';

class ReviewResponse {
  ReviewResponse({
    this.success,
    this.message,
    this.result,
  });

  final bool success;
  final String message;
  final Review result;

  factory ReviewResponse.fromJson(Map<String, dynamic> json) => ReviewResponse(
        success: json['success'],
        message: json['message'],
        result: Review.fromJson(json['result']),
      );
}

class MultipleReviewResponse {
  MultipleReviewResponse({
    this.success,
    this.message,
    this.total,
    this.result,
  });

  final bool success;
  final String message;
  final int total;
  final List<Review> result;

  factory MultipleReviewResponse.fromJson(Map<String, dynamic> json) =>
      MultipleReviewResponse(
        success: json['success'],
        message: json['message'],
        total: json['total'],
        result: (json['result'] as List)
            .map((review) => Review.fromJson(review))
            .toList(),
      );
}
