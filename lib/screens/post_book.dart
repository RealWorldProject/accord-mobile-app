import 'dart:io';

import 'package:accord/models/book.dart';
import 'package:accord/responses/book_post_response.dart';
import 'package:accord/screens/widgets/custom_button.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/screens/widgets/custom_radio_button.dart';
import 'package:accord/screens/widgets/custom_text_field.dart';
import 'package:accord/viewModel/book_view_model.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';

class PostBook extends StatefulWidget {
  @override
  _PostBookState createState() => _PostBookState();
}

class _PostBookState extends State<PostBook> {
  final _formKey = GlobalKey<FormState>();
  File _image;
  String _conditionValue;
  String _exchangableValue;
  final _bookNameController = TextEditingController();
  final _authorNameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  // field validations
  final _acquireBookName =
      MultiValidator([RequiredValidator(errorText: "Book Name is required!")]);

  final _acquireAuthorName = MultiValidator(
      [RequiredValidator(errorText: "Author Name is required!")]);

  final _acquirePrice =
      MultiValidator([RequiredValidator(errorText: "Price is required!")]);

  final _acquireDescription = MultiValidator(
      [RequiredValidator(errorText: "Description is required!")]);

  ValueChanged<String> _conditionValueChangedHandler() {
    return (value) => setState(() => _conditionValue = value);
  }

  ValueChanged<String> _exchangableValueChangedHandler() {
    return (value) => setState(() => _exchangableValue = value);
  }

  Future getImagefromcamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  Future getImagefromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(children: [
            Container(
              color: Color(0xFF737373),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    ListTile(
                        leading: Icon(
                          Icons.photo_library,
                        ),
                        title: CustomText(
                          textToShow: "Choose from Gallery",
                          textColor: Colors.grey.shade700,
                        ),
                        onTap: () {
                          getImagefromGallery();
                          Navigator.of(context).pop();
                        }),
                    ListTile(
                      leading: Icon(
                        Icons.photo_camera,
                      ),
                      title: CustomText(
                        textToShow: "Open Camera",
                        textColor: Colors.grey.shade700,
                      ),
                      onTap: () {
                        getImagefromcamera();
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ]);
        });
  }

  Future<void> validatePostBook() async {
    BookViewModel _bookViewModel = new BookViewModel();
    BookPostResponse _bookPostResponse;

    if (_formKey.currentState.validate()) {
      // Book book = Book(name: _bookNameController, author: _authorNameController, category: )
    }

    await print('posting book');
  }

  String valueChoose;
  List category = ["Cat 1", "Cat 2", "Cat 3", "Cat 4"];

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
                  margin: EdgeInsets.symmetric(vertical: 20.0),
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
                              _showPicker(context);
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
                                      _image,
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
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: DropdownButtonFormField(
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
                          hint: Text("Select Category"),
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 30,
                          isExpanded: true,
                          value: valueChoose,
                          onChanged: (newvalue) {
                            setState(() {
                              valueChoose = newvalue;
                            });
                          },
                          items: category.map((valueItem) {
                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(valueItem),
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
                        triggerAction: validatePostBook,
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
