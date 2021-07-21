import 'dart:convert';
import 'dart:io';

import 'package:accord/models/book.dart';
import 'package:accord/models/category.dart';
import 'package:accord/responses/book_post_response.dart';
import 'package:accord/responses/fetch_category_response.dart';
import 'package:accord/screens/widgets/custom_button.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/screens/widgets/custom_radio_button.dart';
import 'package:accord/screens/widgets/custom_snackbar.dart';
import 'package:accord/screens/widgets/custom_text_field.dart';
import 'package:accord/screens/widgets/image_uploader.dart';
import 'package:accord/screens/widgets/loading_indicator.dart';
import 'package:accord/services/cloud_media_service.dart';
import 'package:accord/viewModel/book_view_model.dart';
import 'package:accord/viewModel/category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';

class PostBook extends StatefulWidget {
  @override
  _PostBookState createState() => _PostBookState();
}

class _PostBookState extends State<PostBook> {
  final _formKey = GlobalKey<FormState>();
  XFile _image;
  bool _imageChosen;
  String _chosenValue;
  List<Category> _category = [];
  String _conditionValue = "New";
  String _exchangableValue = "No";
  final _bookNameController = TextEditingController();
  final _authorNameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCategories().then((categories) => setState(() {
          _category = categories;
        }));
  }

  // field validations
  final _acquireBookName =
      MultiValidator([RequiredValidator(errorText: "Book Name is required!")]);

  final _acquireAuthorName = MultiValidator(
      [RequiredValidator(errorText: "Author Name is required!")]);

  final _acquirePrice =
      MultiValidator([RequiredValidator(errorText: "Price is required!")]);

  final _acquireDescription = MultiValidator(
      [RequiredValidator(errorText: "Description is required!")]);

  // active radio button change handlers.
  ValueChanged<String> _conditionValueChangedHandler() {
    return (value) => setState(() => _conditionValue = value);
  }

  ValueChanged<String> _exchangableValueChangedHandler() {
    return (value) => setState(() => _exchangableValue = value);
  }

  // image upload options.

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

  Future<List<Category>> _getCategories() async {
    CategoryViewModel categoryViewModel = new CategoryViewModel();
    FetchCategoryResponse fetchCategoryResponse =
        await categoryViewModel.fetchCategories();
    if (fetchCategoryResponse.success) {
      return fetchCategoryResponse.result;
    }
    return fetchCategoryResponse.result;
  }

  Future<void> _validatePostBook() async {
    BookViewModel bookViewModel = new BookViewModel();
    BookPostResponse bookPostResponse;
    CloudMediaService cloudMediaService = new CloudMediaService();
    setState(() {
      _imageChosen = _image == null ? false : true;
    });

    if (_formKey.currentState.validate()) {
      if (_imageChosen) {
        loadingIndicator(context);
        // checking if the image is chosen and
        // then uploading image to Cloud through a function in CloudMediaService
        // which returns the url of the uploaded image.
        final String imageUrl =
            await cloudMediaService.uploadImage(_image.path);

        Book book = Book(
          name: _bookNameController.text,
          author: _authorNameController.text,
          category: _chosenValue,
          price: double.parse(_priceController.text),
          description: _descriptionController.text,
          images: imageUrl,
          isNEW: (_conditionValue == "New") ? true : false,
          isAvailableForExchange: (_exchangableValue == "Yes") ? true : false,
        );

        // converting book object into json file
        String bookJSON = jsonEncode(book);

        // connecting and waiting for response from api through bookViewModel.
        // response will be object of BookPostResponse.
        bookPostResponse = await bookViewModel
            .postBook(bookJSON)
            .whenComplete(() => Navigator.of(context).pop());
      }

      // displaying success or error message depending on response.
      if (bookPostResponse.success) {
        ScaffoldMessenger.of(context).showSnackBar(MessageHolder()
            .popSnackbar(bookPostResponse.message, "Okay", this.context));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(MessageHolder()
            .popSnackbar(bookPostResponse.message, "Try Again", this.context));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: CustomText(
          textToShow: "Add a Book",
          textColor: Colors.blue,
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // image selection area
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
                                  galleryOption: _getImagefromGallery,
                                  cameraOption: _getImagefromcamera,
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
                                  Text("Add Image"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: _image == null
                            ? Container()
                            : Stack(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.file(
                                      File(_image.path),
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
                                          setState(() {
                                            _image = null;
                                            _imageChosen = false;
                                          });
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
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                  visible: _imageChosen == null ? false : !_imageChosen,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      "Image is required!",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.red.shade800,
                      ),
                    ),
                  )),

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
                          textToShow: "Book Name",
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      CustomTextField(
                        formType: "PostBook",
                        fieldController: _bookNameController,
                        hintText: "Book Name",
                        fieldValidator: _acquireBookName,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: CustomText(
                          textToShow: "Author`s Name",
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      CustomTextField(
                        formType: "PostBook",
                        fieldController: _authorNameController,
                        hintText: "Author's Name",
                        fieldValidator: _acquireAuthorName,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: CustomText(
                          textToShow: "Category",
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
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          hint: Text(
                            _category.isEmpty
                                ? "No categories available!"
                                : "Select Category",
                          ),
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 30,
                          isExpanded: true,
                          value: _chosenValue,
                          onChanged: (newvalue) => setState(() {
                            _chosenValue = newvalue;
                          }),
                          validator: (value) =>
                              (value == null) ? "Category is required!" : null,
                          items: _category.map((valueItem) {
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
                          textToShow: "Price",
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      CustomTextField(
                        formType: "PostBook",
                        fieldController: _priceController,
                        hintText: "Price",
                        fieldValidator: _acquirePrice,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: CustomText(
                          textToShow: "Description",
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      CustomTextField(
                        formType: "PostBook",
                        fieldController: _descriptionController,
                        hintText: "Description",
                        fieldValidator: _acquireDescription,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: CustomText(
                          textToShow: "Condition",
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomRadioButton<String>(
                            value: "New",
                            groupValue: _conditionValue,
                            onChanged: _conditionValueChangedHandler(),
                            text: "New",
                          ),
                          CustomRadioButton<String>(
                            value: "Old",
                            groupValue: _conditionValue,
                            onChanged: _conditionValueChangedHandler(),
                            text: "Old",
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: CustomText(
                          textToShow: "Exchangable",
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomRadioButton<String>(
                            value: "Yes",
                            groupValue: _exchangableValue,
                            onChanged: _exchangableValueChangedHandler(),
                            text: "Yes",
                          ),
                          CustomRadioButton<String>(
                            value: "No",
                            groupValue: _exchangableValue,
                            onChanged: _exchangableValueChangedHandler(),
                            text: "No",
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        buttonKey: "btnPostBook",
                        buttonText: "Post Book",
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
