import 'package:accord/models/notification.dart';

class NotificationsResponse {
  NotificationsResponse({
    this.success,
    this.message,
    this.result,
  });

  final bool success;
  final String message;
  final List<Notification> result;

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) =>
      NotificationsResponse(
        success: json['success'],
        message: json['message'],
        result: (json['result'] as List)
            .map((notification) => Notification.fromJson(notification))
            .toList(),
      );
}
