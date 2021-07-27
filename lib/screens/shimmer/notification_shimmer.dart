import 'package:accord/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class NotificationShimmer extends StatelessWidget {
  const NotificationShimmer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color:  Colors.white,
      padding: EdgeInsets.symmetric( vertical: 10),
      margin: EdgeInsets.only(top: 8),
      child: ListTile(
        leading: Shimmer.fromColors(
          baseColor: Constant.shimmer_base_color,
          highlightColor: Constant.shimmer_highlight_color,
          child: CircleAvatar(
            radius: 30.0,
            backgroundColor: Colors.grey[300],
          ),
        ),
        title: Shimmer.fromColors(
          baseColor: Constant.shimmer_base_color,
          highlightColor: Constant.shimmer_highlight_color,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width/1.5,
                height: 12,

                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width/3,
                height: 12,

                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
