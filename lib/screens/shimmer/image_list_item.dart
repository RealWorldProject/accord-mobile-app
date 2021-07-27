import 'package:flutter/material.dart';

class ImageListItem extends StatelessWidget {
  const ImageListItem(
      {Key key, this.index, this.width = 132, this.height = 180})
      : super(key: key);
  final int index;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
        ),
        // child: ClipRRect(
        //   borderRadius: BorderRadius.circular(16),
        //   child: Image.network(
        //     "https://res.cloudinary.com/accord/image/upload/v1627126976/accord/category_image_gallery/su3uroie7oicztygacqg.jpg",
        //     fit: BoxFit.cover,
        //   ),
        // ),
      ),
    );
  }
}
