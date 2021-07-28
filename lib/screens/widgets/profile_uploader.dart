import 'package:accord/screens/widgets/profile_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'dart:io';
import 'custom_label.dart';
import 'package:image_picker/image_picker.dart';

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
                        // widget.galleryOption();
                        // Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePreview()));
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
                        // _getImagefromcamera();
                        widget.cameraOption();
                        Navigator.of(context).pop();
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>ProfilePreview()));
                        // Navigator.push(context, MaterialPageRoute(builder: (context) =>ProfilePreview() ));
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
        // : Container(
        //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        //     height: MediaQuery.of(context).size.height / 1.5,
        //     color: Colors.white,
        //     child: Column(
        //       children: [
        //         Text(
        //           "Image Preview",
        //           style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        //         ),
        //         SizedBox(
        //           height: 20,
        //         ),
        //         CircleAvatar(
        //           radius: 120.0,
        //           backgroundColor: Colors.white,
        //           child: CircleAvatar(
        //             radius: 120.0,
        //             backgroundImage: _image == null
        //                 ? AssetImage("assets/images/user2.png")
        //                 : FileImage(File(_image.path)),
        //             backgroundColor: Colors.transparent,
        //           ),
        //         ),
        //         Expanded(
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceAround,
        //             crossAxisAlignment: CrossAxisAlignment.end,
        //             children: [
        //               Container(
        //                 width: 150,
        //                 height: 40,
        //                 alignment: Alignment.center,
        //                 decoration: BoxDecoration(
        //                   color: Colors.red,
        //                   borderRadius: BorderRadius.circular(5),
        //                 ),
        //                 child: GestureDetector(
        //                   onTap: (){
        //                     _image=null;
        //                   },
        //                   child: Text(
        //                     "Close",
        //                     style: TextStyle(
        //                         fontSize: 20,
        //                         fontWeight: FontWeight.w500,
        //                         color: Colors.white),
        //                   ),
        //                 ),
        //               ),
        //               Container(
        //                 width: 150,
        //                 height: 40,
        //                 alignment: Alignment.center,
        //                 decoration: BoxDecoration(
        //                   color: Colors.blue,
        //                   borderRadius: BorderRadius.circular(5),
        //                 ),
        //                 child: GestureDetector(
        //
        //                   child: Text(
        //                     "Save",
        //                     style: TextStyle(
        //                         fontSize: 20,
        //                         fontWeight: FontWeight.w500,
        //                         color: Colors.white),
        //                   ),
        //                 ),
        //               )
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   );
  }
}
