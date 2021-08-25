import 'package:accord/constant/accord_colors.dart';
import 'package:accord/constant/accord_labels.dart';
import 'package:accord/models/request.dart';
import 'package:accord/screens/widgets/custom_bottom_sheet.dart';
import 'package:accord/screens/widgets/custom_dialog_box.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/screens/widgets/error_displayer.dart';
import 'package:accord/screens/widgets/exchange_request_dialog_box.dart';
import 'package:accord/screens/widgets/information_dialog_box.dart';
import 'package:accord/utils/exposer.dart';
import 'package:accord/utils/text_utils.dart';
import 'package:accord/utils/time_calculator.dart';
import 'package:accord/viewModel/provider/button_loading_provider.dart';
import 'package:accord/viewModel/request_view_model.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class OutgoingRequest extends StatefulWidget {
  const OutgoingRequest({Key key}) : super(key: key);

  @override
  _OutgoingRequestState createState() => _OutgoingRequestState();
}

class _OutgoingRequestState extends State<OutgoingRequest> {
  _outgoingBuilder({Request request}) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: request.user.image != null
                      ? Uri.parse(request.user.image).isAbsolute
                          ? NetworkImage(request.user.image)
                          : AssetImage("assets/images/user2.png")
                      : AssetImage("assets/images/user2.png"),
                  backgroundColor: Colors.black12,
                  radius: 30,
                )
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Exchange request sent to, ",
                        ),
                        TextSpan(
                          text:
                              "${request.requestedBookOwner.fullName} (${request.requestedBookOwner.email})",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff13293d),
                          ),
                        ),
                        TextSpan(
                          text: ", to exchange their book, ",
                        ),
                        TextSpan(
                          text: TextUtils()
                              .capitalizeAll(request.requestedBook.name),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff13293d),
                          ),
                        ),
                        TextSpan(
                          text: ", with your book, ",
                        ),
                        TextSpan(
                          text: TextUtils()
                              .capitalizeAll(request.proposedExchangeBook.name),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff13293d),
                          ),
                        ),
                      ],
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff606060),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.8,
                  ),
                  CustomText(
                    textToShow:
                        TimeCalculator.getTimeDifference(request.createdAt),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    textColor: Color(0xff1b98e0),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  SizedBox(
                    width: 95,
                    child: Badge(
                      badgeColor: request.status == "REJECTED"
                          ? Colors.red
                          : request.status == "ACCEPTED"
                              ? Colors.green
                              : AccordColors.full_dark_blue_color,
                      toAnimate: false,
                      shape: BadgeShape.square,
                      elevation: 0,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                      borderRadius: BorderRadius.circular(10),
                      badgeContent: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        children: [
                          Icon(
                            request.status == "REJECTED"
                                ? Icons.clear
                                : request.status == "ACCEPTED"
                                ? Icons.check
                                : Icons.hourglass_empty,
                            color: Colors.white,
                            size: 14,
                          ),
                          CustomText(
                            textToShow: " ${request.status}".toLowerCase(),
                            fontSize: 12,
                            textColor: Colors.white,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          ClipOval(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  request.status != "PENDING"
                      ? Toast.show(
                          "Request already ${request.status}. Can't perform any action.",
                          context,
                          duration: Toast.LENGTH_LONG,
                          gravity: Toast.BOTTOM,
                          backgroundColor: AccordColors.snackbar_color,
                          backgroundRadius: 5.0,
                        )
                      : showModalBottomSheet(
                          context: context,
                          builder: (context) => CustomBottomSheet(
                            // option 1
                            option1: AccordLabels.editRequestLabel,
                            iconOpt1: Icons.edit_rounded,
                            action1: () {
                              showDialog(
                                context: context,
                                useRootNavigator: false,
                                builder: (context) {
                                  return ExchangeRequestDialogBox(
                                    requestedBookName:
                                        request.requestedBook.name,
                                    requestedBookID: request.requestedBook.id,
                                    requestID: request.id,
                                    requestType: RequestType.UPDATE,
                                    currentProposedExchangeBookID:
                                        request.proposedExchangeBook.id,
                                  );
                                },
                              );
                            },

                            //option 2
                            option2: AccordLabels.deleteRequestLabel,
                            iconOpt2: Icons.delete_forever_rounded,
                            action2: () {
                              showDialog(
                                context: context,
                                useRootNavigator: false,
                                builder: (context) => CustomDialogBox(
                                  title: "Exchange Request Deletion!!!",
                                  content:
                                      "Delete book exchange request send to ${request.requestedBookOwner.fullName}?",
                                  neglectLabel: AccordLabels.keep,
                                  neglectAction: () =>
                                      Navigator.of(context).pop(),
                                  performLabel: AccordLabels.delete,
                                  performAction: () =>
                                      deleteExchangeRequest(request.id),
                                ),
                              );
                            },
                          ),
                        );
                },
                child: SizedBox(
                  width: 35,
                  height: 35,
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> deleteExchangeRequest(String requestID) async {
    // instance of [ButtonLoadingProvider]
    ButtonLoadingProvider buttonLoadingProvider =
        context.read<ButtonLoadingProvider>();

    // sets [isLoading] to true;
    buttonLoadingProvider.setIsLoading();

    // instance of [RequestViewModel]
    RequestViewModel requestViewModel = context.read<RequestViewModel>();

    // api call to delete book exchange request.
    await requestViewModel.deleteOutgoingExchangeRequest(requestID);

    // if success, displays success dialog
    // else displays error dialog
    if (requestViewModel.data.status == Status.COMPLETE) {
      // sets [isLoading] to false
      buttonLoadingProvider.removeIsLoading();

      // success dialog
      Toast.show(
        requestViewModel.data.message,
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        backgroundColor: AccordColors.snackbar_color,
        backgroundRadius: 5.0,
      );
    } else {
      // sets [isLoading] to false
      buttonLoadingProvider.removeIsLoading();

      // error dialog
      showDialog(
        context: context,
        builder: (context) => InformationDialogBox(
          contentType: ContentType.ERROR,
          content: requestViewModel.data.message,
          actionText: AccordLabels.tryAgain,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final RequestViewModel requestViewModel = context.read<RequestViewModel>();

    return Container(
      child: RefreshIndicator(
        onRefresh: () => requestViewModel.fetchOutgoingRequests(),
        child: Consumer<RequestViewModel>(
          builder: (context, requestViewModel, _) {
            final List<Request> outgoingRequests =
                requestViewModel.outgoingRequests;
            switch (requestViewModel.data.status) {
              case Status.LOADING:
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                );
              case Status.COMPLETE:
                return ListView.builder(
                  itemCount:
                      outgoingRequests.isEmpty ? 1 : outgoingRequests.length,
                  itemBuilder: (context, index) {
                    if (outgoingRequests.isNotEmpty) {
                      // each requests
                      Request request = outgoingRequests[index];

                      // [Dismissible] iterative requests
                      return Dismissible(
                        key: UniqueKey(),
                        child: _outgoingBuilder(
                          request: request,
                        ),
                        onDismissed: (direction) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Removed request'),
                              action: SnackBarAction(
                                label: "UNDO",
                                onPressed: () {},
                              ),
                            ),
                          );
                        },
                        background: Container(color: Colors.red),
                      );
                    } else {
                      return Container(
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
                      );
                    }
                  },
                );
              case Status.ERROR:
                return ErrorDisplayer(
                  error: requestViewModel.data.message,
                  retryOption: () {
                    requestViewModel.resetOutgoingRequests();
                    requestViewModel.fetchOutgoingRequests();
                  },
                );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
