import 'dart:io';

import 'package:accord/services/cloud_media_service.dart';
import 'package:accord/utils/image_exposer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageHelper extends ChangeNotifier {
  XFile _image;
  XFile get image => _image;

  String _initialImageHolder;

  bool _imageChosen;
  bool get imageChosen => _imageChosen;

  ImageExposer _imageData;
  ImageExposer get imageData => _imageData;

  void resetAllValues() {
    _image = null;
    _initialImageHolder = null;
    _imageChosen = null;
    _imageData = null;
  }

  void setImage(XFile imageFile) {
    _image = imageFile ?? _image;
    _imageData =
        _image == null ? ImageExposer.noImage() : ImageExposer.complete();
    setImageChosen();
  }

  void removeImage() {
    _image = null;
    _imageData = ImageExposer.noImage();
    setImageChosen();
  }

  void setImageChosen() {
    _imageChosen = _image != null ? true : false;
    notifyListeners();
  }

  // converting network image into file.
  void urlToXFile({String imageUrl}) async {
    // check if the incoming image is null or not.
    if (imageUrl != null) {
      _imageData = ImageExposer.loading();
    } else {
      _imageData = ImageExposer.error();
      return;
    }
    await deleteCache();

    try {
      // gets the imageId used in cloudinary, it's unique.
      String imageName = imageUrl.split("/").last;

      // creates byte data from the given network url.
      var bytes = await NetworkAssetBundle(Uri.parse(imageUrl)).load("");

      // creates temporary path in the system.
      String tempPath = (await getTemporaryDirectory()).path;

      // creates and assign a file to the temporary path.
      File file = File('$tempPath/$imageName.png');

      // writes list of 8-bit unsigned integers into the 'file' and saves it.
      await file.writeAsBytes(
          bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));

      // saves the original path of the image,
      //can be used to check if image is altered.
      _initialImageHolder = file.path;

      // XFile conversion
      setImage(XFile(_initialImageHolder));
    } catch (e) {
      _imageData = ImageExposer.error();
    }
  }

  // deletes cache stored through downloaded images.
  Future<void> deleteCache() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  bool isImageAltered() {
    if (_initialImageHolder != _image.path) {
      return true;
    } else {
      return false;
    }
  }

// gallery option
  void getImageFromGallery() async {
    XFile imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setImage(imageFile);
  }

// camera option
  void getImageFromCamera() async {
    XFile imageFile = await ImagePicker().pickImage(source: ImageSource.camera);
    setImage(imageFile);
  }

  Future<void> uploadImage(String imageFile) {
    var cloudResponse = CloudMediaService().uploadImage(imageFile);
  }

  Future<void> loadImage(String cloudImageUrl) {
    var cloudResponse = CloudMediaService().loadImage(cloudImageUrl);
  }
}
