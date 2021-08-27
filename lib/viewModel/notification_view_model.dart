import 'dart:convert';

import 'package:accord/models/notification.dart';
import 'package:accord/responses/notifications_response.dart';
import 'package:accord/services/notification_service.dart';
import 'package:accord/utils/exposer.dart';
import 'package:flutter/foundation.dart';

class NotificationViewModel extends ChangeNotifier {
  List<Notification> _notifications;
  List<Notification> get notifications => _notifications;

  ResponseExposer _data;
  ResponseExposer get data => _data;

  bool _isNotificationSeen = false;
  bool get isNotificationSeen => _isNotificationSeen;

  Future<void> fetchNotifications() async {
    // sets status to [LOADING]
    _data = ResponseExposer.loading();

    try {
      // api call to fetch notification.
      var res = await NotificationService().fetchNotifications();

      // conversion: json response to object
      var responseObj = NotificationsResponse.fromJson(jsonDecode(res));

      // assinging result from response to [notifications]
      _notifications = responseObj.result;

      // sets status to [COMPLETE]
      _data = ResponseExposer.complete();
    } catch (e) {
      _notifications = [];
      // sets status to [ERROR]
      _data = ResponseExposer.error(e.toString());
    }

    notifyListeners();
  }

  void resetNotifications() {
    _notifications = [];
    notifyListeners();
  }
}
