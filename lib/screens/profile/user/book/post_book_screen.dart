import 'dart:convert';
import 'dart:io';

import 'package:accord/constant/accord_colors.dart';
import 'package:accord/constant/accord_labels.dart';
import 'package:accord/models/book.dart';
import 'package:accord/models/category.dart';
import 'package:accord/screens/widgets/custom_app_bar.dart';
import 'package:accord/screens/widgets/custom_button.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/screens/widgets/custom_radio_button.dart';
import 'package:accord/screens/widgets/custom_snackbar.dart';
import 'package:accord/screens/widgets/custom_text_field.dart';
import 'package:accord/screens/widgets/image_uploader.dart';
import 'package:accord/screens/widgets/information_dialog_box.dart';
import 'package:accord/screens/widgets/loading_indicator.dart';
import 'package:accord/services/cloud_media_service.dart';
import 'package:accord/utils/exposer.dart';
import 'package:accord/viewModel/book_view_model.dart';
import 'package:accord/viewModel/category_view_model.dart';
import 'package:accord/viewModel/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

class PostBookScreen extends StatefulWidget {
  @override
  _PostBookScreenState createState() => _PostBookScreenState();
}

class _PostBookScreenState extends State<PostBookScreen> {
  final _formKey = GlobalKey<FormState>();
  String _chosenValue;
  List<Category> _categories;
  String _conditionValue = AccordLabels.positiveBookConditionValue;
  String _exchangableValue = AccordLabels.negativeBookExchangableValue;
  final _bookNameController = TextEditingController();
  final _authorNameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ImageHelper>().resetAllValues();
    _categories = context.read<CategoryViewModel>().categories;
  }

  @override
  void dispose() {
    _bookNameController.dispose();
    _authorNameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  // field validations
  final _acquireBookName = MultiValidator([
    RequiredValidator(
        errorText: AccordLabels.requireMessage(AccordLabels.bookName))
  ]);

  final _acquireAuthorName = MultiValidator([
    RequiredValidator(
        errorText: AccordLabels.requireMessage(AccordLabels.authorName))
  ]);

  final _acquirePrice = MultiValidator([
    RequiredValidator(
        errorText: AccordLabels.requireMessage(AccordLabels.price))
  ]);

  final _acquireDescription = MultiValidator([
    RequiredValidator(
        errorText: AccordLabels.requireMessage(AccordLabels.description))
  ]);

  // active radio button change handlers.
  ValueChanged<String> _conditionValueChangedHandler() {
    return (value) => setState(() => _conditionValue = value);
  }

  ValueChanged<String> _exchangableValueChangedHandler() {
    return (value) => setState(() => _exchangableValue = value);
  }

  Future<void> _validatePostBook() async {
    // removes focus from textfeilds
    FocusScope.of(context).unfocus();

    BookViewModel bookViewModel = context.read<BookViewModel>();
    ImageHelper imageHelper = context.read<ImageHelper>();
    CloudMediaService cloudMediaService = new CloudMediaService();

    // checks if image is chosen or not in the time of form submission.
    imageHelper.setImageChosen();

    if (_formKey.currentState.validate()) {
      if (imageHelper.imageChosen) {
        // shows loading screen while async image upload takes place
        loadingIndicator(context);
        // checking if the image is chosen and
        // then uploading image to Cloud through a function in CloudMediaService
        // which returns the url of the uploaded image.
        final String imageUrl =
            await cloudMediaService.uploadImage(imageHelper.image.path);

        List<String> imageUrls = [imageUrl];

        Book book = Book(
          name: _bookNameController.text,
          author: _authorNameController.text,
          category: _chosenValue,
          price: double.parse(_priceController.text),
          description: _descriptionController.text,
          images: imageUrls,
          isNewBook:
              (_conditionValue == AccordLabels.positiveBookConditionValue)
                  ? true
                  : false,
          isAvailableForExchange:
              (_exchangableValue == AccordLabels.positiveBookExchangebleValue)
                  ? true
                  : false,
        );

        // converting book object into json file
        String bookJSON = jsonEncode(book);

        // calls api to post book.
        await bookViewModel.postBook(bookJSON);

        if (bookViewModel.data.status == Status.COMPLETE) {
          // closes loading screen when the api request to post book is over.
          // enabling rootNavigator makes this pop the dialog screen,
          // else the screen itself is popped from the navigation tree.
          Navigator.of(context, rootNavigator: true).pop();

          // dialog box to show success message.
          showDialog(
            context: context,
            builder: (context) => InformationDialogBox(
              contentType: ContentType.DONE,
              content: bookViewModel.data.message +
                  "It will be made public if approved.",
              actionText: AccordLabels.okay,
            ),
          );
        } else if (bookViewModel.data.status == Status.ERROR) {
          // closes the loading screen.
          Navigator.of(context, rootNavigator: true).pop();

          // snackbar to show error message.
          ScaffoldMessenger.of(context).showSnackBar(customSnackbar(
            content: bookViewModel.data.message,
            context: context,
            actionLabel: AccordLabels.tryAgain,
          ));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          backButton: true,
          title: AccordLabels.postBookTitle,
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // image selection area
              PostBookImageSelection(),

              // form area
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: CustomText(
                          textToShow: AccordLabels.bookName,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      CustomTextField(
                        fieldController: _bookNameController,
                        hintText: AccordLabels.bookName,
                        fieldValidator: _acquireBookName,
                        fieldType: FieldType.ALL,

                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: CustomText(
                          textToShow: AccordLabels.authorName,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      CustomTextField(
                        fieldController: _authorNameController,
                        hintText: AccordLabels.authorName,
                        fieldValidator: _acquireAuthorName,
                        fieldType: FieldType.TEXT,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: CustomText(
                          textToShow: AccordLabels.category,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 1.0),
                        child: DropdownButtonFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          dropdownColor: Colors.grey[200],
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          hint: Text(
                            _categories.isEmpty
                                ? AccordLabels.ifNoCategory
                                : AccordLabels.ifCategory,
                          ),
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 30,
                          isExpanded: true,
                          value: _chosenValue,
                          onChanged: (newvalue) => setState(() {
                            _chosenValue = newvalue;
                          }),
                          validator: (value) => (value == null)
                              ? AccordLabels.requireMessage(
                                  AccordLabels.category)
                              : null,
                          items: _categories.map((valueItem) {
                            return DropdownMenuItem(
                              value: valueItem.id,
                              child: Text(valueItem.category),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: CustomText(
                          textToShow: AccordLabels.price,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      CustomTextField(
                        fieldController: _priceController,
                        hintText: AccordLabels.price,
                        fieldValidator: _acquirePrice,
                        fieldType: FieldType.NUMBER,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: CustomText(
                          textToShow: AccordLabels.description,

                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      CustomTextField(
                        fieldController: _descriptionController,
                        hintText: AccordLabels.description,
                        fieldValidator: _acquireDescription,
                        noOfLines: 7,
                        fieldType: FieldType.ALL,

                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: CustomText(
                          textToShow: AccordLabels.condition,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomRadioButton<String>(
                            value: AccordLabels.positiveBookConditionValue,
                            groupValue: _conditionValue,
                            onChanged: _conditionValueChangedHandler(),
                            text: AccordLabels.positiveBookConditionValue,
                          ),
                          CustomRadioButton<String>(
                            value: AccordLabels.negativeBookConditionValue,
                            groupValue: _conditionValue,
                            onChanged: _conditionValueChangedHandler(),
                            text: AccordLabels.negativeBookConditionValue,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: CustomText(
                          textToShow: AccordLabels.exhangable,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomRadioButton<String>(
                            value: AccordLabels.positiveBookExchangebleValue,
                            groupValue: _exchangableValue,
                            onChanged: _exchangableValueChangedHandler(),
                            text: AccordLabels.positiveBookExchangebleValue,
                          ),
                          CustomRadioButton<String>(
                            value: AccordLabels.negativeBookExchangableValue,
                            groupValue: _exchangableValue,
                            onChanged: _exchangableValueChangedHandler(),
                            text: AccordLabels.negativeBookExchangableValue,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        buttonType: ButtonType.ROUNDED_EDGE,
                        buttonLabel: AccordLabels.postBook,
                        triggerAction: _validatePostBook,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PostBookImageSelection extends StatelessWidget {
  const PostBookImageSelection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 6.0),
          child: Container(
            margin: EdgeInsets.only(top: 20.0),
            padding: EdgeInsets.symmetric(vertical: 10.0),
            height: 200.0,
            child: ListView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    height: 200,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => ImageUploader(
                            galleryOption:
                                context.read<ImageHelper>().getImageFromGallery,
                            cameraOption:
                                context.read<ImageHelper>().getImageFromCamera,
                          ),
                        );
                      },
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_circle,
                              color: Colors.grey[800],
                              size: 50,
                            ),
                            Text(AccordLabels.addImage),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Consumer<ImageHelper>(
                    builder: (context, imageHelper, child) {
                      return Stack(
                        children: <Widget>[
                          imageHelper.image == null
                              ? Container()
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.file(
                                    File(imageHelper.image.path),
                                    height: 200,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                          Positioned(
                            top: 1,
                            right: 1,
                            child: Container(
                              height: 25,
                              width: 25,
                              child: InkWell(
                                onTap: () {
                                  context.read<ImageHelper>().removeImage();
                                },
                                child: Icon(
                                  Icons.close,
                                  color: Colors.grey[800],
                                  size: 15,
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: context.watch<ImageHelper>().imageChosen == null
              ? false
              : !context.watch<ImageHelper>().imageChosen,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              AccordLabels.requireMessage(AccordLabels.image),
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 13,
                color: AccordColors.error_text_color,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
