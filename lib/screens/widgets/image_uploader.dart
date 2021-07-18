import 'package:accord/screens/widgets/custom_label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageUploader extends StatelessWidget {
  // opens bottomsheet showing the options available for uploading image.
  //
  final VoidCallback galleryOption;
  final VoidCallback cameraOption;

  ImageUploader({
    this.galleryOption,
    this.cameraOption,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      Container(
        color: Color(0xFF737373),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              ListTile(
                leading: Icon(
                  Icons.photo_library,
                ),
                title: CustomText(
                  textToShow: "Choose from Gallery",
                  textColor: Colors.grey.shade700,
                ),
                onTap: () {
                  galleryOption();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.photo_camera,
                ),
                title: CustomText(
                  textToShow: "Open Camera",
                  textColor: Colors.grey.shade700,
                ),
                onTap: () {
                  cameraOption();
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
