import 'dart:convert';

import 'package:accord/constant/accord_labels.dart';
import 'package:accord/models/order.dart';
import 'package:accord/screens/widgets/custom_app_bar.dart';
import 'package:accord/screens/widgets/custom_button.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/screens/widgets/custom_radio_button.dart';
import 'package:accord/screens/widgets/custom_snackbar.dart';
import 'package:accord/screens/widgets/custom_text_field.dart';
import 'package:accord/screens/widgets/information_dialog_box.dart';
import 'package:accord/screens/widgets/loading_indicator.dart';
import 'package:accord/utils/exposer.dart';
import 'package:accord/viewModel/cart_view_model.dart';
import 'package:accord/viewModel/order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key key}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final _formKey = GlobalKey<FormState>();

  final String _onlinePaymentOption = AccordLabels.onlinePaymentText;
  final String _cashOnDeliveryOption = AccordLabels.cashOnDeliveryText;

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
      [RequiredValidator(errorText: AccordLabels.requireFullNameMessage)]);

  final _acquirePhoneNumber = MultiValidator(
      [RequiredValidator(errorText: AccordLabels.requirePhoneNumberMessage)]);

  final _acquireState = MultiValidator([
    RequiredValidator(
        errorText: AccordLabels.fieldEssentialMessage(AccordLabels.province))
  ]);

  final _acquireCity = MultiValidator([
    RequiredValidator(
        errorText: AccordLabels.fieldEssentialMessage(AccordLabels.city))
  ]);

  final _acquireArea = MultiValidator([
    RequiredValidator(
        errorText: AccordLabels.fieldEssentialMessage(AccordLabels.area))
  ]);

  final _acquireAddress = MultiValidator([
    RequiredValidator(
        errorText:
            AccordLabels.fieldEssentialMessage(AccordLabels.physicalAddress))
  ]);

  // active radio button change handlers.
  ValueChanged<String> _paymentGatewayValueChangeHandler() {
    return (value) => setState(() => _paymentGatewayValue = value);
  }

  Future<void> _validateOrderCheckout() async {
    // removes focus from textfeilds
    FocusScope.of(context).unfocus();

    OrderViewModel orderViewModel = context.read<OrderViewModel>();

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

      await orderViewModel.checkoutOrder(_orderJson);

      // action in reference to the response status
      if (orderViewModel.data.status == Status.COMPLETE) {
        context.read<CartviewModel>().resetCartItems();

        // closes loading screen when the api request to post order is over.
        // enabling rootNavigator makes this pop the dialog screen,
        // else the screen itself is popped from the navigation tree.
        Navigator.of(context, rootNavigator: true).pop();

        Navigator.pop(context);

        showDialog(
            context: context,
            builder: (context) => InformationDialogBox(
                  contentType: ContentType.INFORMATION,
                  content: orderViewModel.data.message,
                  actionText: AccordLabels.okay,
                ));
        // ScaffoldMessenger.of(context).showSnackBar(MessageHolder()
        //     .popSnackbar(orderViewModel.data.message, "Okay", this.context));
      } else if (orderViewModel.data.status == Status.ERROR) {
        // closes loading screen when the api request to post order is over.
        // enabling rootNavigator makes this pop the dialog screen,
        // else the screen itself is popped from the navigation tree.
        Navigator.of(context, rootNavigator: true).pop();

        ScaffoldMessenger.of(context).showSnackBar(customSnackbar(
          content: orderViewModel.data.message,
          context: context,
          actionLabel: AccordLabels.tryAgain,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          title: AccordLabels.orderScreenTitle,
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
                        designType: DesignType.UNDERLINE,
                        hintText: AccordLabels.fullName,
                        fieldController: _fullNameController,
                        fieldValidator: _acquireFullname,
                        fieldType: FieldType.TEXT_SPACE,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                          designType: DesignType.UNDERLINE,
                          hintText: AccordLabels.phoneNumber,
                          fieldController: _phoneNumberController,
                          fieldValidator: _acquirePhoneNumber,
                          fieldType: FieldType.NUMBER_ONLY),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        designType: DesignType.UNDERLINE,
                        hintText: AccordLabels.province,
                        fieldController: _statecontroller,
                        fieldValidator: _acquireState,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        designType: DesignType.UNDERLINE,
                        hintText: AccordLabels.city,
                        fieldController: _cityController,
                        fieldValidator: _acquireCity,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        designType: DesignType.UNDERLINE,
                        hintText: AccordLabels.area,
                        fieldController: _areaController,
                        fieldValidator: _acquireArea,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        designType: DesignType.UNDERLINE,
                        hintText: AccordLabels.physicalAddress,
                        fieldController: _addressController,
                        fieldValidator: _acquireAddress,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        designType: DesignType.UNDERLINE,
                        hintText: AccordLabels.coordinates,
                        fieldController: _coordinatesController,
                        fieldType: FieldType.NUMBER,
                        fieldValidator: null,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: CustomText(
                          textToShow: AccordLabels.paymentMethod,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomRadioButton<String>(
                            value: AccordLabels.onlinePaymentText,
                            groupValue: _paymentGatewayValue,
                            onChanged: _paymentGatewayValueChangeHandler(),
                            text: AccordLabels.onlinePaymentText,
                          ),
                          CustomRadioButton<String>(
                            value: AccordLabels.cashOnDeliveryText,
                            groupValue: _paymentGatewayValue,
                            onChanged: _paymentGatewayValueChangeHandler(),
                            text: AccordLabels.cashOnDeliveryText,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        buttonType: ButtonType.ROUNDED_EDGE,
                        buttonLabel: AccordLabels.submitButton,
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
