import 'package:accord/constant/accord_colors.dart';
import 'package:accord/constant/accord_labels.dart';
import 'package:accord/models/book.dart';
import 'package:accord/screens/widgets/custom_button.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/screens/widgets/exchange_request_dialog_box.dart';
import 'package:accord/utils/text_utils.dart';
import 'package:accord/viewModel/book_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookOwnerSection extends StatelessWidget {
  const BookOwnerSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Book book = context.read<BookViewModel>().activeBook;
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage:
                    // checks if the given image url is valid.
                    Uri.parse(book.userId.image).isAbsolute
                        ? NetworkImage(book.userId.image)
                        : AssetImage("assets/images/user2.png"),
                backgroundColor: Colors.black12,
              ),
              SizedBox(
                width: 8,
              ),
              CustomText(
                textToShow: TextUtils().capitalizeAll(book.userId.fullName),
                fontWeight: FontWeight.bold,
                textColor: AccordColors.full_dark_blue_color,
                fontSize: 16,
                overflow: TextOverflow.visible,
              ),
            ],
          ),
          CustomButton(
            height: 35,
            width: 165,
            buttonLabel: AccordLabels.requestExchangeBook,
            textSize: 12,
            buttonType: ButtonType.OUTLINED,
            enable: book.isAvailableForExchange,
            triggerAction: book.isAvailableForExchange == false
                ? () {}
                : () {
                    showDialog(
                      context: context,
                      useRootNavigator: false,
                      builder: (context) {
                        return ExchangeRequestDialogBox(
                          requestedBookName: book.name,
                          requestedBookID: book.id,
                        );
                      },
                    );
                  },
          ),
        ],
      ),
    );
  }
}
