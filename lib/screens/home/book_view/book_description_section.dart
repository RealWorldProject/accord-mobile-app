import 'package:accord/constant/accord_colors.dart';
import 'package:accord/constant/accord_labels.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/viewModel/book_view_model.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookDescriptionSection extends StatelessWidget {
  const BookDescriptionSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String description = context.read<BookViewModel>().activeBook.description;

    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ExpandablePanel(
        header: CustomText(
          textToShow: AccordLabels.description,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          textColor: AccordColors.semi_dark_blue_color,
        ),
        collapsed: Text(
          description,
          softWrap: true,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: Colors.grey[700]),
        ),
        expanded: Text(
          description,
          softWrap: true,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: Colors.grey[700]),
        ),
      ),
    );
  }
}
