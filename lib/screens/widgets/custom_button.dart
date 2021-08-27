import 'package:accord/constant/accord_colors.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/viewModel/provider/button_loading_provider.dart';
import 'package:accord/viewModel/provider/text_field_value_change_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomButton extends StatelessWidget {
  /// shape of the bottom
  final ButtonType buttonType;

  /// default set to 50
  final double height;

  /// if null, inherits it's parent's width
  final double width;

  /// text for button
  final String buttonLabel;

  /// button enabled by default
  final bool enable;

  /// textSize 12 by default
  final double textSize;

  /// background color of button
  final Color buttonColor;

  /// background color of button while loading
  final Color buttonColorWhileLoading;

  /// color for the child in button
  final Color childColor;

  /// action that is triggered on button click
  final VoidCallback triggerAction;

  const CustomButton({
    this.height = 50,
    this.width,
    this.buttonType = ButtonType.ROUNDED_EDGE,
    @required this.buttonLabel,
    this.enable = true,
    this.textSize = 20,
    this.buttonColor,
    this.buttonColorWhileLoading,
    this.childColor,
    @required this.triggerAction,
  });

  @override
  Widget build(BuildContext context) {
    // loading button for non-form buttons
    if (buttonType == ButtonType.LOADING_BUTTON) {
      // [ButtonLoadingProvider] instance
      var buttonLoadingProvider = context.watch<ButtonLoadingProvider>();

      return TextButton(
        key: key,
        onPressed:
            // click event does nothing while [isLoading] is true.
            buttonLoadingProvider.isLoading ? () {} : () => triggerAction(),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            // color variation according to [isLoading].
            buttonLoadingProvider.isLoading
                ? buttonColorWhileLoading ?? Colors.red[300]
                : buttonColor ?? Colors.red,
          ),
          padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 0),
          ),
          splashFactory:
              buttonLoadingProvider.isLoading ? NoSplash.splashFactory : null,
        ),
        child: Consumer<ButtonLoadingProvider>(
          builder: (context, buttonLoadingProvider, child) {
            return buttonLoadingProvider.isLoading
                ? SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Colors.grey[200],
                    ),
                  )
                : CustomText(
                    textToShow: buttonLabel,
                    textColor: Colors.white,
                    fontSize: 16,
                  );
          },
        ),
      );
    }

    // loading button for form buttons
    if (buttonType == ButtonType.LOADING_FORM_BUTTON) {
      // [ButtonLoadingProvider] instance
      var buttonLoadingProvider = context.watch<ButtonLoadingProvider>();
      // [TextFieldValueChangeProvider] instance
      var textFieldValueChangeProvider =
          context.watch<TextFieldValueChangeProvider>();

      return TextButton(
        key: key,
        // click event does nothing while [isLoading] is true.
        onPressed: textFieldValueChangeProvider.Valuechanged
            ? buttonLoadingProvider.isLoading
                ? () {}
                : () => triggerAction()
            : () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            // color variation according to [valueChanged] & [isLoading] values
            textFieldValueChangeProvider.Valuechanged
                ? buttonLoadingProvider.isLoading
                    ? AccordColors.loading_button_color
                    : AccordColors.default_button_color
                : AccordColors.disabled_button_color,
          ),
          padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 20),
          ),
          splashFactory: !textFieldValueChangeProvider.Valuechanged
              ? NoSplash.splashFactory
              : null,
        ),
        child: Consumer<ButtonLoadingProvider>(
          builder: (context, buttonLoadingProvider, child) {
            return buttonLoadingProvider.isLoading
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Colors.grey[200],
                    ),
                  )
                : CustomText(
                    textToShow: buttonLabel,
                    textColor: textFieldValueChangeProvider.Valuechanged
                        ? Colors.white
                        : Colors.white54,
                  );
          },
        ),
      );
    }

    if (buttonType == ButtonType.OUTLINED) {
      return SizedBox(
        key: key,
        height: height,
        width: width,
        child: OutlinedButton(
          onPressed: () => triggerAction(),
          child: Text(
            buttonLabel,
            style: TextStyle(
              color: enable
                  ? AccordColors.default_outline_button_text_color
                  : AccordColors.disabled_outline_button_text_color,
              fontWeight: FontWeight.w600,
              fontSize: textSize,
            ),
          ),
          style: OutlinedButton.styleFrom(
              splashFactory: enable ? null : NoSplash.splashFactory,
              primary: AccordColors.default_button_color,
              side: BorderSide(
                color: enable
                    ? AccordColors.default_button_color
                    : AccordColors.disabled_outline_button_color,
                width: 1.5,
              )),
        ),
      );
    }

    return SizedBox(
      height: height,
      width: width ?? MediaQuery.of(context).size.width,
      child: TextButton(
        key: key,
        child: CustomText(
          textToShow: buttonLabel,
          textColor: Colors.white,
          fontSize: textSize,
        ),
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.all(5),
          ),
          splashFactory: InkRipple.splashFactory,
          overlayColor: MaterialStateProperty.all<Color>(Colors.white24),
          backgroundColor: MaterialStateProperty.all<Color>(
              buttonColor ?? AccordColors.default_button_color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                buttonType == ButtonType.ROUNDED_EDGE ? 5 : 40,
              ),
            ),
          ),
        ),
        onPressed: () => triggerAction(),
      ),
    );
  }
}

enum ButtonType {
  /// oval type
  OVAL,

  /// has rounded edge
  ROUNDED_EDGE,

  /// button with border and label
  OUTLINED,

  /// Button to display progress indicator within button.
  /// Applicable for [FormButton]
  LOADING_FORM_BUTTON,

  /// Button to display progress indicator within button.
  /// Applicable for non-form buttons.
  LOADING_BUTTON
}
