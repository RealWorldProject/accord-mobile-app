import 'dart:convert';

import 'package:accord/constant/accord_colors.dart';
import 'package:accord/constant/accord_labels.dart';
import 'package:accord/models/book.dart';
import 'package:accord/models/request.dart';
import 'package:accord/screens/widgets/custom_button.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/utils/exposer.dart';
import 'package:accord/viewModel/book_view_model.dart';
import 'package:accord/viewModel/provider/button_loading_provider.dart';
import 'package:accord/viewModel/request_view_model.dart';
import 'package:direct_select/direct_select.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'information_dialog_box.dart';

enum RequestType {
  /// denotes the call is for creating new book exchange request
  POST,

  /// denotes the call is for updating existing book exchnage request
  UPDATE,
}

class ExchangeRequestDialogBox extends StatelessWidget {
  const ExchangeRequestDialogBox({
    Key key,
    this.requestType = RequestType.POST,
    @required this.requestedBookName,
    @required this.requestedBookID,
    this.requestID,
    this.currentProposedExchangeBookID,
  }) : super(key: key);

  /// denotes whether to create or update book exchnage request
  final RequestType requestType;

  /// name of the book being requested.
  final String requestedBookName;

  /// id of the book being requested.
  final String requestedBookID;

  /// request id. required while updating existing request
  final String requestID;

  /// pre-displays specific book from user owned books
  ///
  /// required while updating existing request
  final String currentProposedExchangeBookID;

  @override
  Widget build(BuildContext context) {
    final BookViewModel bookViewModel = context.read<BookViewModel>();

    bookViewModel.userOwnedBooks ?? bookViewModel.fetchUserPostedBooks();

    List<Book> userOwnedBooks;

    // sets [isLoading] value to default
    context.read<ButtonLoadingProvider>().initializer();

    return AlertDialog(
      content: context.watch<BookViewModel>().userOwnedBooks == null
          ? Container(
              height: 130,
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            )
          : context.watch<BookViewModel>().userOwnedBooks.length > 0
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AccordLabels.requestedBookLabel,
                      style: TextStyle(fontSize: 13),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomText(
                      textToShow: requestedBookName,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      AccordLabels.bookInOffer,
                      style: TextStyle(fontSize: 13),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Consumer<BookViewModel>(
                      builder: (context, bookViewModel, child) {
                        if (bookViewModel.data.status == Status.COMPLETE) {
                          // get user owned books data if the data status in
                          //[BookViewModel] is [COMPLETE]
                          userOwnedBooks = bookViewModel.userOwnedBooks;

                          int currentProposedExchangeBookIDIndex =
                              userOwnedBooks.indexWhere((ownedBook) =>
                                  ownedBook.id ==
                                  currentProposedExchangeBookID);

                          requestType == RequestType.UPDATE
                              ? context
                                  .read<RequestViewModel>()
                                  .initializeIndexWhenEditing(
                                      currentProposedExchangeBookIDIndex)
                              : null;

                          return Consumer<RequestViewModel>(
                            builder: (context, requestViewModel, child) {
                              // list of books imposed to [DirectSelect] format styles
                              final selectMenuItems = context
                                  .read<BookViewModel>()
                                  .userOwnedBooks
                                  .map((book) => MySelectionItem(
                                        title: book.name,
                                      ))
                                  .toList();

                              // current selected index in the [List<Book>]
                              final currenBookIndex =
                                  requestViewModel.currentBookIndex;

                              return DirectSelect(
                                itemExtent: 35.0,
                                backgroundColor: Colors.white,
                                selectedIndex: currenBookIndex,
                                child: Container(
                                  child: MySelectionItem(
                                    isForList: false,
                                    title: userOwnedBooks[currenBookIndex].name,
                                  ),
                                ),
                                onSelectedItemChanged: (selectedIndex) {
                                  requestViewModel.setIndex(selectedIndex);
                                },
                                items: selectMenuItems,
                              );
                            },
                          );
                        } else {
                          return Container(
                            height: 45,
                            padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey[100],
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                          );
                        }
                      },
                    )
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      textToShow:
                          "Sorry! you don't have any book for exchange.",
                      noOfLines: 2,
                      fontWeight: FontWeight.w500,
                      textColor: Colors.grey[800],
                    ),
                  ],
                ),
      actions: context.watch<BookViewModel>().userOwnedBooks == null
          ? []
          : context.watch<BookViewModel>().userOwnedBooks.length > 0
              ? [
                  SizedBox(
                    height: 30,
                    width: 80,
                    child: TextButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(0),
                        ),
                      ),
                      child: CustomText(
                        textToShow: AccordLabels.cancel,
                        textColor: Colors.grey,
                        fontSize: 16,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: 80,
                    child: CustomButton(
                      buttonType: ButtonType.LOADING_BUTTON,
                      buttonLabel: AccordLabels.confirm,
                      buttonColor: AccordColors.default_button_color,
                      buttonColorWhileLoading:
                          AccordColors.loading_button_color,
                      triggerAction: () {
                        // gets selected book's id.
                        final String offeredBookID = bookViewModel
                            .userOwnedBooks[context
                                .read<RequestViewModel>()
                                .currentBookIndex]
                            .id;

                        // function to request book.
                        requestType == RequestType.POST
                            ? sendExchangeRequest(
                                context,
                                requestedBookID,
                                offeredBookID,
                              )
                            : updateExchangeRequest(
                                context,
                                requestID,
                                offeredBookID,
                              );
                      },
                    ),
                  )
                ]
              : [
                  SizedBox(
                    height: 30,
                    width: 80,
                    child: CustomButton(
                        buttonLabel: AccordLabels.close,
                        buttonColor: Colors.grey[600],
                        textSize: 16,
                        triggerAction: () {
                          Navigator.pop(context);
                        }),
                  ),
                ],
    );
  }

  // function to create new exchnage request
  Future<void> sendExchangeRequest(
    BuildContext context,
    String requestedBookID,
    String offeredBookID,
  ) async {
    // instance of [ButtonLoadingProvider]
    ButtonLoadingProvider buttonLoadingProvider =
        context.read<ButtonLoadingProvider>();

    // sets [isLoading] to true;
    buttonLoadingProvider.setIsLoading();

    // instance of [RequestViewModel]
    RequestViewModel requestViewModel = context.read<RequestViewModel>();

    // [Request] object
    final Request request = new Request(
      requestedBook: requestedBookID,
      proposedExchangeBook: offeredBookID,
    );

    // json conversion to [Request] object
    final String requestJson = jsonEncode(request);

    // api call to request exchange book.
    await requestViewModel.requestBook(requestJson);

    // if success, displays success dialog
    // else displays error dialog
    if (requestViewModel.data.status == Status.COMPLETE) {
      // sets [isLoading] to false
      buttonLoadingProvider.removeIsLoading();

      // success dialog
      showDialog(
        context: context,
        builder: (context) => InformationDialogBox(
          contentType: ContentType.DONE,
          content: requestViewModel.data.message,
          actionText: AccordLabels.okay,
        ),
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

  // function to update existing book exchange request.
  Future<void> updateExchangeRequest(
    BuildContext context,
    String requestID,
    String updatedOfferedBookID,
  ) async {
    // instance of [ButtonLoadingProvider]
    ButtonLoadingProvider buttonLoadingProvider =
        context.read<ButtonLoadingProvider>();

    // sets [isLoading] to true;
    buttonLoadingProvider.setIsLoading();

    // instance of [RequestViewModel]
    RequestViewModel requestViewModel = context.read<RequestViewModel>();

    // updated [Request] object : offered book only
    final Request updatedRequest = new Request(
      proposedExchangeBook: updatedOfferedBookID,
    );

    // json conversion to [Request] object
    final String updatedRequestJson = jsonEncode(updatedRequest);

    // api call to update book exchange request.
    await requestViewModel.editOutgoingExchangeRequest(
      requestID,
      updatedRequestJson,
    );

    // if success, displays success dialog
    // else displays error dialog
    if (requestViewModel.data.status == Status.COMPLETE) {
      // sets [isLoading] to false
      buttonLoadingProvider.removeIsLoading();

      Navigator.of(context).pop();

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
}

class MySelectionItem extends StatelessWidget {
  final String title;
  final bool isForList;

  const MySelectionItem({
    Key key,
    this.title,
    this.isForList = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        height: 45.0,
        child: isForList
            ? Padding(
                padding: EdgeInsets.all(10.0),
                child: _buildItem(context),
              )
            : Card(
                color: Colors.grey[100],
                child: Stack(
                  children: <Widget>[
                    _buildItem(context),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.arrow_drop_down),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  _buildItem(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.only(left: 5, right: 18),
        child: CustomText(
          textToShow: title,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
