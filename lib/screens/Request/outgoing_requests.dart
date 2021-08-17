import 'package:accord/constant/accord_labels.dart';
import 'package:accord/models/request.dart';
import 'package:accord/screens/widgets/error_displayer.dart';
import 'package:accord/utils/exposer.dart';
import 'package:accord/viewModel/book_view_model.dart';
import 'package:accord/viewModel/request_view_model.dart';
import 'package:accord/viewModel/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OutgoingRequest extends StatefulWidget {
  const OutgoingRequest({Key key}) : super(key: key);

  @override
  _OutgoingRequestState createState() => _OutgoingRequestState();
}

class _OutgoingRequestState extends State<OutgoingRequest> {
  _outgoingBuilder({String userImage, Request request}) {
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
                  backgroundImage: userImage != null
                      ? Uri.parse(userImage).isAbsolute
                          ? NetworkImage(userImage)
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
                          text: "Exchange request sent to ",
                        ),
                        TextSpan(
                          text: request.requestedBookOwner.email,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff13293d),
                          ),
                        ),
                        TextSpan(
                          text: " to exchange book ",
                        ),
                        TextSpan(
                          text: request.requestedBook.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff13293d),
                          ),
                        ),
                        TextSpan(
                          text: " for ",
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
                    "12 hour ago",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1b98e0),
                    ),
                  ),
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
    final UserViewModel userViewModel = context.read<UserViewModel>();

    final RequestViewModel requestViewModel = context.read<RequestViewModel>();
    requestViewModel.fetchOutgoingRequests();

    return Container(
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
                        userImage: userViewModel.user.image,
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
                      padding: EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        AccordLabels.emptyRequestMessage(
                          AccordLabels.outgoingRequestLabel,
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            letterSpacing: -1,
                            fontWeight: FontWeight.w500,
                            color: Colors.black45),
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
    );
  }
}
