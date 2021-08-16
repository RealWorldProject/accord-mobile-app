import 'package:accord/constant/accord_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BookFeedShimmer extends StatelessWidget {
  const BookFeedShimmer({Key key}) : super(key: key);

  final double sizeHight = 8;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 8),
            leading: Shimmer.fromColors(
              baseColor: AccordColors.shimmer_base_color,
              highlightColor: AccordColors.shimmer_highlight_color,
              child: CircleAvatar(
                radius: 20.0,
                backgroundColor: Colors.grey[300],
              ),
            ),
            title: Shimmer.fromColors(
              baseColor: AccordColors.shimmer_base_color,
              highlightColor: AccordColors.shimmer_highlight_color,
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: AccordColors.shimmer_base_color,
            highlightColor: AccordColors.shimmer_highlight_color,
            child: Container(
              height: MediaQuery.of(context).size.height / 1.8,
              width: double.infinity,
              color: Colors.grey[500],
              // child: Image.asset(
              //   "assets/images/a1.jpg",
              //   fit: BoxFit.contain,
              // ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Shimmer.fromColors(
                  baseColor: AccordColors.shimmer_base_color,
                  highlightColor: AccordColors.shimmer_highlight_color,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                SizedBox(
                  height: sizeHight,
                ),
                Shimmer.fromColors(
                  baseColor: AccordColors.shimmer_base_color,
                  highlightColor: AccordColors.shimmer_highlight_color,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.2 - 40,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                SizedBox(
                  height: sizeHight,
                ),
                Shimmer.fromColors(
                  baseColor: AccordColors.shimmer_base_color,
                  highlightColor: AccordColors.shimmer_highlight_color,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.2 - 80,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                SizedBox(
                  height: sizeHight,
                ),
                Shimmer.fromColors(
                  baseColor: AccordColors.shimmer_base_color,
                  highlightColor: AccordColors.shimmer_highlight_color,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.2 - 10,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                SizedBox(
                  height: sizeHight,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
