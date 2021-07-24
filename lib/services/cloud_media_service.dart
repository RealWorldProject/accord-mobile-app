import 'package:accord/constant/constant.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';

class CloudMediaService {
  final cloudinary = Cloudinary(
    Constant.apiKey,
    Constant.apiSecret,
    Constant.cloudName,
  );

  Future<List<String>> uploadImage(String imagePath) async {
    try {
      CloudinaryResponse response =
          await cloudinary.uploadResource(CloudinaryUploadResource(
        filePath: imagePath,
        resourceType: CloudinaryResourceType.image,
        folder: Constant.bookImageFolder,
      ));
      if (response.isSuccessful) {
        return response.secureUrl as List;
      }
    } catch (e) {
      return e.response;
    }
    return null;
  }

  // Future<String> loadImage(String cloudImageUrl) async {
  //   try {
  //     final cloudinaryImage = CloudinaryImage(cloudImageUrl);
  //     String transformedUrl =
  //         cloudinaryImage.transform().width(132).height(180).generate();
  //     return transformedUrl;
  //   } catch (e) {
  //     return e.response;
  //   }
  // }
}
