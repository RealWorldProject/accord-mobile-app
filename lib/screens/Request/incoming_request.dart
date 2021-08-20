import 'package:accord/constant/accord_labels.dart';
import 'package:accord/models/request.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/screens/widgets/error_displayer.dart';
import 'package:accord/screens/widgets/information_dialog_box.dart';
import 'package:accord/utils/exposer.dart';
import 'package:accord/utils/time_calculator.dart';
import 'package:accord/viewModel/request_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncomingRequest extends StatefulWidget {
  const IncomingRequest({Key key}) : super(key: key);

  @override
  _IncomingRequestState createState() => _IncomingRequestState();
}

class _IncomingRequestState extends State<IncomingRequest> {
  _incomingRequestBuilder({Request request}) {
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
                          text: request.user.email,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff13293d),
                          ),
                        ),
                        TextSpan(
                          text: " sent you a request to exchange your book, ",
                        ),
                        TextSpan(
                          text: request.requestedBook.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff13293d),
                          ),
                        ),
                        TextSpan(
                          text: ", for their book,",
                        ),
                        TextSpan(
                          text: request.proposedExchangeBook.name,
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
                  Text(
                    TimeCalculator.getTimeDifference(request.createdAt),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1b98e0),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 120,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5)),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
                              RequestViewModel requestViewModel =
                                  context.read<RequestViewModel>();
                              await requestViewModel
                                  .acceptExchangeRequest(request.id);

                              if (requestViewModel.data.status ==
                                  Status.COMPLETE) {
                                showDialog(
                                  context: context,
                                  builder: (context) => InformationDialogBox(
                                    contentType: ContentType.DONE,
                                    content: requestViewModel.data.message,
                                    actionText: AccordLabels.okay,
                                  ),
                                );
                              } else if (requestViewModel.data.status ==
                                  Status.ERROR) {
                                showDialog(
                                  context: context,
                                  builder: (context) => InformationDialogBox(
                                      contentType: ContentType.ERROR,
                                      content: requestViewModel.data.message,
                                      actionText: AccordLabels.tryAgain),
                                );
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Center(
                                child: Text(
                                  "Accept",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 120,
                        decoration: BoxDecoration(
                            color: Color(0xff13293d),
                            borderRadius: BorderRadius.circular(5)),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(5),
                            onTap: () {
                              print("decline");
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Center(
                                child: Text(
                                  "Decline",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          ClipOval(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
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

  @override
  Widget build(BuildContext context) {
    final RequestViewModel requestViewModel = context.read<RequestViewModel>();

    return Container(
      child: RefreshIndicator(
        onRefresh: () => requestViewModel.fetchIncomingRequests(),
        child: Consumer<RequestViewModel>(
          builder: (context, requestViewModel, _) {
            final List<Request> incomingRequests =
                requestViewModel.incomingRequests;
            switch (requestViewModel.incomingRequestData.status) {
              case Status.LOADING:
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                );
              case Status.COMPLETE:
                return ListView.builder(
                  itemCount:
                      incomingRequests.isEmpty ? 1 : incomingRequests.length,
                  itemBuilder: (context, index) {
                    if (incomingRequests.isNotEmpty) {
                      // each requests
                      Request request = incomingRequests[index];

                      // [Dismissible] iterative requests
                      return Dismissible(
                        key: UniqueKey(),
                        child: _incomingRequestBuilder(
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
                    requestViewModel.resetIncomingRequests();
                    requestViewModel.fetchIncomingRequests();
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
