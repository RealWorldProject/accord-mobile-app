
import 'package:flutter/material.dart';
import 'custom_label.dart';

class ProfileUploader extends StatefulWidget {
  final VoidCallback galleryOption;
  final VoidCallback cameraOption;

  ProfileUploader({
    this.galleryOption,
    this.cameraOption,
  });

  @override
  _ProfileUploaderState createState() => _ProfileUploaderState();
}

class _ProfileUploaderState extends State<ProfileUploader> {


  @override
  Widget build(BuildContext context) {
    return
         Wrap(children: [
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
                        widget.galleryOption();
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
                        widget.cameraOption();
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
