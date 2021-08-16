import 'package:accord/constant/accord_colors.dart';
import 'package:accord/constant/accord_labels.dart';
import 'package:accord/models/user.dart';
import 'package:accord/screens/widgets/custom_button.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/screens/widgets/exchange_request_dialog_box.dart';
import 'package:accord/utils/text_utils.dart';
import 'package:flutter/material.dart';

class BookOwnerSection extends StatelessWidget {
  const BookOwnerSection({
    Key key,
    this.owner,
    this.exchangable,
  }) : super(key: key);

  final User owner;
  final bool exchangable;

  @override
  Widget build(BuildContext context) {
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
                    Uri.parse(owner.image).isAbsolute
                        ? NetworkImage(owner.image)
                        : AssetImage("assets/images/user2.png"),
                backgroundColor: Colors.black12,
              ),
              SizedBox(
                width: 8,
              ),
              CustomText(
                textToShow: TextUtils().capitalizeAll(owner.fullName),
                fontWeight: FontWeight.bold,
                textColor: AccordColors.full_dark_blue_color,
                fontSize: 16,
                overflow: TextOverflow.visible,
              ),
            ],
          ),
          CustomButton(
            height: 35,
            width: 145,
            buttonLabel: AccordLabels.requestBook,
            buttonType: ButtonType.OUTLINED,
            enable: exchangable,
            triggerAction: exchangable == false
                ? () {}
                : () {
                    final rootContext = context
                        .findRootAncestorStateOfType<NavigatorState>()
                        .context;
                    print("object");
                    showDialog(
                      context: rootContext,
                      builder: (context) => ExchangeRequestDialogBox(),
                    );
                  },
          ),
        ],
      ),
    );
  }
}
