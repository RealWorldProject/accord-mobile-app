import 'package:accord/screens/widgets/custom_label.dart';
import 'package:flutter/material.dart';

class AddAndEditBookDetail extends StatelessWidget {
  const AddAndEditBookDetail({Key key}) : super(key: key);
  static const double imageHeight = 120.0;
  static const double imageWidth = 110.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: InkWell(
        onTap: (){print("go to book detail page");},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.network(
                          'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcR7IcZHkFtiEEEF20_gIMTSFWLqJyD70W4TQ2r1Gf71IKVn1bRb',
                          height: imageHeight,
                          width: imageWidth,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomText(
                            textToShow: "Godard the image book",
                            fontSize: 18,
                          ),
                          CustomText(
                            textToShow: "William Di Vanci",
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            textColor: Colors.grey[500],
                            fontStyle: FontStyle.italic,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomText(
                            textToShow:
                                "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
                            noOfLines: 4,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            textColor: Colors.grey[700],
                            overflow: TextOverflow.ellipsis,
                          )
                          // Text(
                          //   "Godard the image book",
                          //   style: TextStyle(
                          //       fontSize: 15,
                          //       fontWeight: FontWeight.bold,
                          //       color: Colors.grey[900]),
                          //   overflow: TextOverflow.ellipsis,
                          // ),
                          // Text(
                          //   "William Di Vanci",
                          //   style: TextStyle(
                          //       fontSize: 12,
                          //       fontWeight: FontWeight.w600,
                          //       color: Colors.grey[600],
                          //       fontStyle: FontStyle.italic),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
