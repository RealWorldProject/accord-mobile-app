
import 'package:accord/screens/widgets/image_uploader.dart';
import 'package:accord/screens/widgets/profile_uploader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:line_icons/line_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';

class ViewProfileTop extends StatefulWidget {
  const ViewProfileTop({Key key}) : super(key: key);

  @override
  _ViewProfileTopState createState() => _ViewProfileTopState();
}

class _ViewProfileTopState extends State<ViewProfileTop> {

  XFile _image;
  bool _isSave=false;

  Future<void> _getImagefromcamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    showModalBottomSheet(context: context, builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        height: MediaQuery.of(context).size.height / 1.5,
        color: Colors.white,
        child: Column(
          children: [
            Text(
              "Image Preview",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 120.0,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 120.0,
                backgroundImage: FileImage(File(image.path)),
                backgroundColor: Colors.transparent,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 150,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: GestureDetector(
                      onTap: (){
                        // image=null;
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Close",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: GestureDetector(
                      onTap: (){
                        print("Save");
                        setState(() {
                          _image = image;
                        });
                        Navigator.pop(context);
                      },

                      child: Text(
                        "Save",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });


  }

  Future<void> _getImagefromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      // _imageChosen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              height: MediaQuery.of(context).size.height / 3.8,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xff1b98e0),
                // image: DecorationImage(
                //   image: AssetImage("assets/images/profileBG.png"),
                //   fit: BoxFit.cover,
                //
                //   // image: Image.asset("assets/images/profileBG.png",height: MediaQuery.of(context).size.height,fit: BoxFit.cover,),
                // ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 5.8,
          ),
          child: Column(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 4, color: Colors.black38, spreadRadius: 2)
                    ],
                  ),
                  child: Stack(children: [
                    CircleAvatar(
                      radius: 60.0,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 56.0,

                        backgroundImage: _image==null?AssetImage("assets/images/user2.png"):FileImage(File(_image.path)),

                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 4, color: Colors.black26, spreadRadius: 0.5)
                          ],
                        ),

                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white,

                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(Icons.camera_alt_sharp,color: Colors.grey[900],),
                            iconSize: 20,
                            onPressed: (){
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => ProfileUploader(
                                  galleryOption: _getImagefromGallery,
                                  cameraOption: _getImagefromcamera,
                                ),
                              );
                            },


                          ),
                        ),
                      ),
                    )
                  ]),
                ),
              ),
              Text(
                "John Doe",
                style: TextStyle(
                    color: Color(0xff13293d),
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "johndoe@gmail.com",
                style: TextStyle(color: Colors.blueGrey, fontSize: 14),
              ),
            ],
          ),
        ),
        Positioned(
          top: 85,
          left: 15,
          child: Container(
            padding: EdgeInsets.zero,
            height: 26,
            width: 26,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1.2),
                borderRadius: BorderRadius.circular(5)),
            child: IconButton(
              padding: EdgeInsets.only(left: 5),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
