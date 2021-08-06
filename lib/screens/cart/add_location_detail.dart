import 'package:accord/screens/widgets/back_button.dart';
import 'package:accord/screens/widgets/custom_button.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/screens/widgets/custom_radio_button.dart';
import 'package:accord/screens/widgets/custom_text_field.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class AddLocationDetail extends StatefulWidget {
  const AddLocationDetail({Key key}) : super(key: key);

  @override
  _AddLocationDetailState createState() => _AddLocationDetailState();
}

class _AddLocationDetailState extends State<AddLocationDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shipping Address",
          style: TextStyle(color: Color(0xff13293d)),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.grey[800], //change your color here
        ),
        centerTitle: true,
        elevation: 0,
        bottom: PreferredSize(
          child: Container(
            color: Colors.blue,
            height: 1.0,
          ),
          preferredSize: Size.fromHeight(0.0),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Form(
                  // key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      CustomTextField(
                        hintText: "Full Name",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        hintText: "Phone Number",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        hintText: "Region",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        hintText: "City",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        hintText: "Area",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        hintText: "Address",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        hintText: "Co-ordinates (optional)",
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: CustomText(
                          textToShow: "Payment Method",
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomRadioButton<String>(
                            value: "Online Payment",
                            // groupValue: _conditionValue,
                            // onChanged: _conditionValueChangedHandler(),
                            text: "Online Payment",
                          ),
                          CustomRadioButton<String>(
                            value: "Cash on Delivery",
                            // groupValue: _conditionValue,
                            // onChanged: _conditionValueChangedHandler(),
                            text: "Cash on Delivery",
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        buttonKey: "btnAddAddress",
                        buttonText: "Submit",
                        // triggerAction: _validatePostBook,
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
