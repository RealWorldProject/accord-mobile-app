import 'dart:convert';
import 'dart:io';

import 'package:accord/models/book.dart';
import 'package:accord/models/category.dart';
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
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class EditBookScreen extends StatefulWidget {
  const EditBookScreen({Key key, this.book}) : super(key: key);

  final Book book;

  @override
  _EditBookScreenState createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  final _formKey = GlobalKey<FormState>();
  XFile _image;
  bool _imageChosen;
  String _chosenValue;
  String _initialImageHolder;
  List<Category> _category = [];
  String _conditionValue;
  String _exchangableValue;
  final _bookNameController = TextEditingController();
  final _authorNameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bookDetailsAssigner(widget.book);
    _getCategories().then((categories) => setState(
          () {
            _category = categories;
          },
        ));
  }

  // value initializations for the selected book.
  void bookDetailsAssigner(Book book) {
    setState(() {
      urlToFile(imageName: book.images[0].split("/").last, ext: ".jpg")
          .then((value) => setState(
                () {
                  _initialImageHolder = value.path;
                  _image = XFile(_initialImageHolder);
                },
              ));
      _bookNameController.text = book.name;
      _authorNameController.text = book.author;
      _priceController.text = book.price.toString();
      _descriptionController.text = book.description;
      _chosenValue = book.category;
      _conditionValue = book.isNewBook ? "New" : "Old";
      _exchangableValue = book.isAvailableForExchange ? "Yes" : "No";
    });
  }

  // converting network image into file.
  Future<File> urlToFile({String imageName, String ext}) async {
    await deleteCache();

    var bytes =
        await NetworkAssetBundle(Uri.parse(widget.book.images[0])).load("");
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/$imageName.png');
    await file.writeAsBytes(
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
    return file;
  }

  // deletes cache stored through downloaded images.
  Future<void> deleteCache() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
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

  Future<void> _getImagefromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image != null ? image : _image;
      _imageChosen = _image != null ? true : false;
    });
  }

  Future<void> _getImagefromcamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _image = image != null ? image : _image;
      _imageChosen = _image != null ? true : false;
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

  Future<void> _validateEditBook() async {
    // removes focus from textfeilds
    FocusScope.of(context).unfocus();

    BookViewModel bookViewModel = new BookViewModel();
    CloudMediaService cloudMediaService = new CloudMediaService();

    // checks if image is chosen or not in the time of form submission.
    setState(() {
      _imageChosen = _image == null ? false : true;
    });

    if (_formKey.currentState.validate()) {
      // checking if the image is chosen and
      if (_imageChosen) {
        // shows loading screen while async image upload takes place
        loadingIndicator(context);
        // uploading image to Cloud through a function in CloudMediaService
        // which returns the url of the uploaded image.
        List<String> imageUrls = [];
        // uploading image only if the image has been altered.
        if (isImageAltered()) {
          imageUrls.add(await cloudMediaService.uploadImage(_image.path));
        } else {
          imageUrls.add(widget.book.images[0]);
        }

        Book book = Book(
          name: _bookNameController.text,
          author: _authorNameController.text,
          category: _chosenValue,
          price: double.parse(_priceController.text),
          description: _descriptionController.text,
          images: imageUrls,
          isNewBook: (_conditionValue == "New") ? true : false,
          isAvailableForExchange: (_exchangableValue == "Yes") ? true : false,
        );

        // converting book object into json file
        String updatedBookJSON = jsonEncode(book);

        // connecting and waiting for response from api through bookViewModel.
        // response will be object of BookResponse.
        bool updateResult = await bookViewModel
            .updateBook(updatedBookJSON, widget.book.id)
            .then(
          (updateResponse) {
            if (updateResponse.success) {
              // deleting the previous image if user has altered the book image
              if (isImageAltered()) {
                cloudMediaService.deleteImage(widget.book.images[0]);
              }
              ScaffoldMessenger.of(context).showSnackBar(MessageHolder()
                  .popSnackbar(updateResponse.message, "", this.context));
            } else {
              // in case of error, deleting the current image if user has altered the book image
              if (isImageAltered()) {
                cloudMediaService.deleteImage(imageUrls[0]);
              }
              ScaffoldMessenger.of(context).showSnackBar(MessageHolder()
                  .popSnackbar(
                      updateResponse.message, "Try Again", this.context));
            }
            return updateResponse.success;
          },
        ).whenComplete(
          () =>
              // closes loading screen when the api request to book update is over.
              Navigator.of(context).pop(),
        );

        // navigates to previous page if update is successful.
        if (updateResult) {
          Navigator.pop(context);
        }
      }
    }
  }

  bool isImageAltered() {
    if (_initialImageHolder != _image.path) {
      return true;
    } else {
      return false;
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
          textToShow: "Update your Book",
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
                        buttonText: "Update Book",
                        triggerAction: _validateEditBook,
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
