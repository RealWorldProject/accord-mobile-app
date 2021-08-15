import 'package:accord/constant/constant.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:flutter/material.dart';

class CloudMediaService {
  final cloudinary = Cloudinary(
    Constant.apiKey,
    Constant.apiSecret,
    Constant.cloudName,
  );

  Future<String> uploadImage(String imagePath) async {
    try {
      CloudinaryResponse response =
          await cloudinary.uploadResource(CloudinaryUploadResource(
        filePath: imagePath,
        resourceType: CloudinaryResourceType.image,
        folder: Constant.bookImageFolder,
      ));
      if (response.isSuccessful) {
        return response.secureUrl;
      }
    } catch (e) {
      return e.toString();
    }
    return null;
  }

  Future<Image> loadImage(String cloudImageUrl) async {
    try {
      final cloudinaryImage = CloudinaryImage(cloudImageUrl);
      String transformedUrl =
          cloudinaryImage.transform().width(132).height(180).generate();
      return Image.network(cloudImageUrl);
    } catch (e) {
      return e.response;
    }
  }

  Future<void> deleteImage(String cloudImageUrl) async {
    final res = await cloudinary.deleteFile(
      url: cloudImageUrl,
      resourceType: CloudinaryResourceType.image,
      invalidate: false,
    );
    if (res.isSuccessful ?? false) {}
  }
}
