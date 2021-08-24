class Notification {
  Notification({
    this.type,
    this.user,
    this.requesterPhoto,
    this.request,
    this.notificationBody,
    this.createdAt,
  });

  final String type;
  final dynamic user;
  final String requesterPhoto;
  final dynamic request;
  final String notificationBody;
  final DateTime createdAt;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        type: json['type'],
        user: json['user'],
        requesterPhoto: json['requesterPhoto'],
        request: json['request'],
        notificationBody: json['notificationBody'],
        createdAt: DateTime.parse(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {};
}
