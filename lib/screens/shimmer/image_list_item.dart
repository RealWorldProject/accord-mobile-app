import 'package:accord/constant/accord_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageListItem extends StatelessWidget {
  const ImageListItem(
      {Key key, this.index, this.width = 132, this.height = 180, this.margin})
      : super(key: key);
  final int index;
  final double width;
  final double height;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: Container(
        width: width,
        height: height,
        margin: margin,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      baseColor: AccordColors.shimmer_base_color,
      highlightColor: AccordColors.shimmer_highlight_color,
    );
  }
}
