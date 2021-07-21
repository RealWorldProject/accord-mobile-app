import 'package:cloudinary_sdk/cloudinary_sdk.dart';

class CloudMediaService {
  static const String apiKey = "864233231861498";
  static const String apiSecret = "2j-cNb3rdXELlBz4km2tYYJDpIU";
  static const String cloudName = "accord";
  static const String bookImageFolder = "accord/book_image_gallery";

  final cloudinary = Cloudinary(
    apiKey,
    apiSecret,
    cloudName,
  );

  Future<String> uploadImage(String imagePath) async {
    try {
      CloudinaryResponse response =
          await cloudinary.uploadResource(CloudinaryUploadResource(
        filePath: imagePath,
        resourceType: CloudinaryResourceType.image,
        folder: bookImageFolder,
      ));
      if (response.isSuccessful) {
        return response.secureUrl;
      }
    } catch (e) {
      return e.response;
    }
  }
}
