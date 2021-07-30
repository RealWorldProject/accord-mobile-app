import 'package:accord/constant/constant.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class BookDescription extends StatefulWidget {
  const BookDescription({Key key}) : super(key: key);

  @override
  _BookDescriptionState createState() => _BookDescriptionState();
}

class _BookDescriptionState extends State<BookDescription> {
  String desc = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ExpandablePanel(

          header: Text("Description", style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Constant.semi_dark_blue_color),),
        collapsed: Text(desc,softWrap: true,maxLines: 5,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 12,color: Colors.grey[700]),),
        expanded: Text(desc,softWrap: true,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 12,color: Colors.grey[700]),),

      ),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Text("Description",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Constant.semi_dark_blue_color),),
      //         InkWell(
      //           onTap: (){},
      //           child: Text("view more",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.grey[600]),),
      //         )
      //
      //       ],
      //     ),
      //     SizedBox(height: 20,),
      //
      //   ],
      // ),
    );
  }
}
