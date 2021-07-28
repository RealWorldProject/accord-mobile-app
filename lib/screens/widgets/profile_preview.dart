import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';

class ProfilePreview extends StatefulWidget {
  const ProfilePreview({Key key}) : super(key: key);

  @override
  _ProfilePreviewState createState() => _ProfilePreviewState();
}

class _ProfilePreviewState extends State<ProfilePreview> {
  XFile _image;
  bool _imageChosen;

  Future<void> _getImagefromcamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
      _imageChosen = true;
    });
  }

  Future<void> _getImagefromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      _imageChosen = true;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        height: MediaQuery.of(context).size.height/2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: _image == null ? Container(child: Center(child: Text("No Such files"),),):
          Container(
            child: Image.file(
              File(_image.path),
              height: 200,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
