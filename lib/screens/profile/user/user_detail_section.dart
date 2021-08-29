import 'dart:convert';

import 'package:accord/constant/accord_colors.dart';
import 'package:accord/constant/accord_labels.dart';
import 'package:accord/models/user.dart';
import 'package:accord/screens/widgets/custom_button.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/screens/widgets/image_uploader.dart';
import 'package:accord/screens/widgets/information_dialog_box.dart';
import 'package:accord/services/cloud_media_service.dart';
import 'package:accord/utils/exposer.dart';
import 'package:accord/viewModel/image_helper.dart';
import 'package:accord/viewModel/provider/button_loading_provider.dart';
import 'package:accord/viewModel/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import '../user_avatar_displayer.dart';
import '../user_term_displayer.dart';

class UserDetailSection extends StatefulWidget {
  const UserDetailSection({Key key}) : super(key: key);

  @override
  _UserDetailSectionState createState() => _UserDetailSectionState();
}

class _UserDetailSectionState extends State<UserDetailSection> {
  // pops a bottom sheet to confirm the profile picture.
  _previewImage(XFile image) {
    final double _buttonWidth = MediaQuery.of(context).size.width / 2.5;
    const double _buttonHeight = 40;

    showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          height: MediaQuery.of(context).size.height / 1.5,
          color: Colors.white,
          child: Column(
            children: [
              CustomText(
                textToShow: AccordLabels.imagePrieviewLabel,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 20,
              ),
              CircleAvatar(
                radius: 120.0,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 120.0,
                  backgroundImage:
                      image != null ? FileImage(File(image.path)) : null,
                  backgroundColor: AccordColors.loading_background,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomButton(
                      width: _buttonWidth,
                      height: _buttonHeight,
                      buttonType: ButtonType.ROUNDED_EDGE,
                      buttonLabel: AccordLabels.cancel,
                      buttonColor: Colors.red,
                      triggerAction: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(
                      width: _buttonWidth,
                      height: _buttonHeight,
                      child: CustomButton(
                        buttonType: ButtonType.LOADING_BUTTON,
                        buttonColor: AccordColors.default_button_color,
                        buttonColorWhileLoading:
                            AccordColors.loading_button_color,
                        buttonLabel: AccordLabels.save,
                        triggerAction: () => updateProfile(image: image),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // if image is null, preview section won't be opened.
  void openPreviewSection(XFile image) {
    image != null ? _previewImage(image) : null;
    context.read<ButtonLoadingProvider>().removeIsLoading();
  }

  void updateProfile({XFile image}) async {
    // [ButtonLoadingProvider] instance
    var buttonLoadingProvider = context.read<ButtonLoadingProvider>();

    // sets [isLoading] to true
    buttonLoadingProvider.setIsLoading();

    // [UserViewModel] instance
    var userViewModel = context.read<UserViewModel>();

    // uploads new image to cloud.
    String profileImageUrl =
        await CloudMediaService().uploadProfileImage(image.path);

    // stores link of old profile image
    String oldProfileImage = userViewModel.user.image;

    // [User] object with updated profile image
    User partialUserData = new User(image: profileImageUrl);

    // json conversion of [User] object
    String partialUserDataJson = jsonEncode(partialUserData);

    // api call to update profile image.
    await userViewModel.updateUserDetails(updatedUser: partialUserDataJson);

    // checks the response status of api and performs task accordingly
    if (userViewModel.data.status == Status.COMPLETE) {
      // after successful update of profile, deletes old profile image.
      Uri.parse(oldProfileImage).isAbsolute
          ? await CloudMediaService().deleteImage(oldProfileImage)
          : null;

      // sets [isLoading] to false
      buttonLoadingProvider.removeIsLoading();

      // closes bottomsheet.
      Navigator.of(context).pop();
    } else if (userViewModel.data.status == Status.ERROR) {
      // sets [isLoading] to false
      buttonLoadingProvider.removeIsLoading();

      // error message
      showDialog(
        context: context,
        builder: (context) => InformationDialogBox(
          contentType: ContentType.ERROR,
          content: userViewModel.data.message,
          actionText: AccordLabels.tryAgain,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // [ImageHelper] instance
    final ImageHelper imageHelper = context.read<ImageHelper>();

    return Column(
      children: [
        Stack(
          children: [
            Container(
              child: ClipPath(
                clipper: OvalBottomBorderClipper(),
                child: Container(
                  height: MediaQuery.of(context).size.height / 3.5,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xff1b98e0),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 5.4,
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
                              blurRadius: 4,
                              color: Colors.black38,
                              spreadRadius: 2)
                        ],
                      ),
                      child: Stack(children: [
                        UserAvatarDisplayer(
                          outerRadius: 74,
                          innerRadius: 70,
                          outerColor: Colors.white70,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 4,
                                    color: Colors.black26,
                                    spreadRadius: 0.5)
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.white,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  Icons.camera_alt_sharp,
                                  color: Colors.grey[900],
                                ),
                                iconSize: 22,
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) =>
                                        ImageUploader(galleryOption: () {
                                      imageHelper.resetAllValues();
                                      imageHelper
                                          .getImageFromGallery()
                                          .whenComplete(() =>
                                              openPreviewSection(
                                                  imageHelper.image));
                                    }, cameraOption: () {
                                      imageHelper.resetAllValues();
                                      imageHelper
                                          .getImageFromCamera()
                                          .whenComplete(
                                            () => openPreviewSection(
                                                imageHelper.image),
                                          );
                                    }),
                                  );
                                },
                              ),
                            ),
                          ),
                        )
                      ]),
                    ),
                  ),
                  UserTermDisplayer(
                    termColor: Color(0xff13293d),
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
                    Navigator.of(context, rootNavigator: false).pop();
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
        ),
      ],
    );
  }
}
