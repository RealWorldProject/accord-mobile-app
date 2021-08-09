import 'dart:convert';

import 'package:accord/models/order.dart';
import 'package:accord/screens/widgets/custom_button.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/screens/widgets/custom_radio_button.dart';
import 'package:accord/screens/widgets/custom_snackbar.dart';
import 'package:accord/screens/widgets/custom_text_field.dart';
import 'package:accord/screens/widgets/loading_indicator.dart';
import 'package:accord/services/handlers/exposer.dart';
import 'package:accord/viewModel/order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class AddLocationDetail extends StatefulWidget {
  const AddLocationDetail({Key key}) : super(key: key);

  @override
  _AddLocationDetailState createState() => _AddLocationDetailState();
}

class _AddLocationDetailState extends State<AddLocationDetail> {
  final _formKey = GlobalKey<FormState>();

  final String _onlinePaymentOption = "Online Payment";
  final String _cashOnDeliveryOption = "Cash on Delivery";

  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _statecontroller = TextEditingController();
  final _cityController = TextEditingController();
  final _areaController = TextEditingController();
  final _addressController = TextEditingController();
  final _coordinatesController = TextEditingController();
  String _paymentGatewayValue;

  // screen initializer
  @override
  void initState() {
    initializeFieldValues();
    super.initState();
  }

  // function holding initial values
  void initializeFieldValues() {
    _paymentGatewayValue = _onlinePaymentOption;
  }

  // field validators
  final _acquireFullname = MultiValidator(
      [RequiredValidator(errorText: "Please state your full name!")]);

  final _acquirePhoneNumber = MultiValidator(
      [RequiredValidator(errorText: "Please insert your phone number!")]);

  final _acquireState = MultiValidator(
      [RequiredValidator(errorText: "Your state/province is essential!")]);

  final _acquireCity = MultiValidator(
      [RequiredValidator(errorText: "Your city info is essential!")]);

  final _acquireArea = MultiValidator(
      [RequiredValidator(errorText: "Your area info is essential!")]);

  final _acquireAddress = MultiValidator(
      [RequiredValidator(errorText: "Your physical address is essential!")]);

  // active radio button change handlers.
  ValueChanged<String> _paymentGatewayValueChangeHandler() {
    return (value) => setState(() => _paymentGatewayValue = value);
  }

  Future<void> _validateOrderCheckout() async {
    // removes focus from textfeilds
    FocusScope.of(context).unfocus();

    OrderViewModel _orderViewModel = new OrderViewModel();

    if (_formKey.currentState.validate()) {
      // displays loading screen
      loadingIndicator(context);

      Order order = Order(
        fullName: _fullNameController.text,
        phoneNumber: _phoneNumberController.text,
        state: _statecontroller.text,
        city: _cityController.text,
        area: _areaController.text,
        address: _addressController.text,
        coordinates: _coordinatesController.text,
        paymentGateway:
            _paymentGatewayValue == _onlinePaymentOption ? "OP" : "COD",
      );

      // converting order object into json file
      String _orderJson = jsonEncode(order);

      await _orderViewModel.checkoutOrder(_orderJson);

      // action in reference to the response status
      if (_orderViewModel.data.status == Status.COMPLETE) {
        ScaffoldMessenger.of(context).showSnackBar(MessageHolder()
            .popSnackbar(_orderViewModel.data.message, "Okay", this.context));
      } else if (_orderViewModel.data.status == Status.ERROR) {
        ScaffoldMessenger.of(context).showSnackBar(MessageHolder().popSnackbar(
            _orderViewModel.data.message, "Try Again", this.context));
      }

      // closes loading screen when the api request to post book is over.
      Navigator.of(context).pop();
    }
  }

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
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        hintText: "Full Name",
                        fieldController: _fullNameController,
                        fieldValidator: _acquireFullname,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        hintText: "Phone Number",
                        fieldController: _phoneNumberController,
                        fieldValidator: _acquirePhoneNumber,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        hintText: "State",
                        fieldController: _statecontroller,
                        fieldValidator: _acquireState,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        hintText: "City",
                        fieldController: _cityController,
                        fieldValidator: _acquireCity,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        hintText: "Area",
                        fieldController: _areaController,
                        fieldValidator: _acquireArea,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        hintText: "Address",
                        fieldController: _addressController,
                        fieldValidator: _acquireAddress,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        hintText: "Co-ordinates (optional)",
                        fieldController: _coordinatesController,
                        fieldValidator: null,
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
                            groupValue: _paymentGatewayValue,
                            onChanged: _paymentGatewayValueChangeHandler(),
                            text: "Online Payment",
                          ),
                          CustomRadioButton<String>(
                            value: "Cash on Delivery",
                            groupValue: _paymentGatewayValue,
                            onChanged: _paymentGatewayValueChangeHandler(),
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
                        triggerAction: _validateOrderCheckout,
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
