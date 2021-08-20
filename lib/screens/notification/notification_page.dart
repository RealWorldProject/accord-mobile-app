import 'package:accord/constant/accord_labels.dart';
import 'package:accord/models/notification.dart' as accord;
import 'package:accord/screens/notification/info_type_notification.dart';
import 'package:accord/screens/notification/request_type_notification.dart';
import 'package:accord/screens/shimmer/notification_shimmer.dart';
import 'package:accord/screens/widgets/custom_app_bar.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/screens/widgets/error_displayer.dart';
import 'package:accord/utils/exposer.dart';
import 'package:accord/viewModel/notification_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with AutomaticKeepAliveClientMixin<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    // [NotificationViewModel] provider instance.
    NotificationViewModel notificationViewModel =
        context.read<NotificationViewModel>();

    // fetch notifications only if [notifications] is null.
    // auto fetch is triggered only one time whole app's in-effect lifecycle.
    notificationViewModel.notifications ??
        notificationViewModel.fetchNotifications();

    super.build(context);
    return RefreshIndicator(
      onRefresh: () => notificationViewModel.fetchNotifications(),
      child: Scaffold(
        extendBody: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
            title: AccordLabels.notificationScreenTitle,
            backButton: false,
          ),
        ),
        backgroundColor: Colors.grey[200],
        body: Container(child: Consumer<NotificationViewModel>(
          builder: (context, notificationViewModel, child) {
            switch (notificationViewModel.data.status) {
              case Status.LOADING:
                return NotificationShimmer();
              case Status.COMPLETE:
                final List<accord.Notification> notifications =
                    notificationViewModel.notifications;
                return ListView.builder(
                  itemCount: notifications.isEmpty ? 1 : notifications.length,
                  itemBuilder: (context, index) {
                    return notifications.isEmpty
                        ? Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(top: 20),
                            width: MediaQuery.of(context).size.width,
                            child: CustomText(
                              textToShow: AccordLabels.emptyRequestMessage(
                                AccordLabels.incomingRequestLabel,
                              ),
                              fontSize: 18,
                              letterSpacing: -1,
                              fontWeight: FontWeight.w500,
                              textColor: Colors.black45,
                            ),
                          )
                        : notifications[index].type == "INCOMING_REQUEST"
                            ? RequestTypeNotification(
                                notification: notifications[index],
                              )
                            : InfoTypeNotification(
                                notification: notifications[index],
                              );
                  },
                );
              case Status.ERROR:
                return ErrorDisplayer(
                  error: notificationViewModel.data.message,
                  retryOption: () {
                    notificationViewModel.resetNotifications();
                    notificationViewModel.fetchNotifications();
                  },
                );
              default:
                return Container();
            }
          },
        )),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
