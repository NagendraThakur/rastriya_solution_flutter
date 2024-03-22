import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';
import 'package:rastriya_solution_flutter/widgets/textfield.dart';
import 'package:rastriya_solution_flutter/widgets/two_row_component.dart';

class DialogUtils {
  static void showProcessingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Lottie.asset(
          'assets/json/loading.json',
          fit: BoxFit.contain,
          repeat: true,
          height: 10,
          width: 10,
        );
      },
    );
  }

  static void showPleaseWaitProcessingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Lottie.asset(
          'assets/json/please_wait_loading.json',
          fit: BoxFit.contain,
          repeat: true,
          height: 10,
          width: 10,
        );
      },
    );
  }

  static void singleInputDialog({
    required BuildContext context,
    required String title,
    required String subtitle,
    required Function(String?) onSave,
    TextAlign? textAlign,
    bool? doubleOnly,
    String? invalidMessage,
    Widget? suffixIcon,
    Widget? prefixIcon,
    TextInputType? textInputType,
    String? textControllerValue,
  }) {
    final formKey = GlobalKey<FormState>();
    TextEditingController textController =
        TextEditingController(text: textControllerValue);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 2,
            scrollable: true,
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formKey,
                  child: CustomTextField(
                    labelText: subtitle,
                    controller: textController,
                    textAlign: textAlign,
                    suffixIcon: suffixIcon,
                    prefixIcon: prefixIcon,
                    textInputType: textInputType,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a value';
                      }
                      if (doubleOnly == true) {
                        if (double.tryParse(value) == null) {
                          return invalidMessage ?? "Invalid Value";
                        }
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final enteredText = textController.text;
                      onSave(enteredText);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text("Save")),
            ],
          );
        });
  }

  static void discountDialog({
    required BuildContext context,
    required String title,
    required String subtitle,
    required Function(String?) onSave,
    TextAlign? textAlign,
    bool? doubleOnly,
    String? invalidMessage,
    Widget? suffixIcon,
    Widget? prefixIcon,
    TextInputType? textInputType,
    String? textControllerValue,
    int? maxLength,
  }) {
    final formKey = GlobalKey<FormState>();
    TextEditingController textController =
        TextEditingController(text: textControllerValue);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 2,
            scrollable: true,
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formKey,
                  child: TextFormField(
                    controller: textController,
                    maxLength: maxLength,
                    decoration: InputDecoration(
                      hintText: subtitle,
                      suffixIcon: suffixIcon,
                      prefixIcon: prefixIcon,
                    ),
                    textAlign: textAlign ?? TextAlign.end,
                    keyboardType: textInputType,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a value';
                      }
                      if (doubleOnly == true) {
                        if (double.tryParse(value) == null) {
                          return invalidMessage ?? "Invalid Value";
                        } else if (double.parse(value) > 100) {
                          return "Discount cannot be greater than 100%";
                        }
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final enteredText = textController.text;
                      onSave(enteredText);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text("Save")),
            ],
          );
        });
  }

  static void confirmationDialog({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String confirmationButtonText,
    required Function() sure,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 2,
            scrollable: true,
            title: Text(title),
            content: Text(subtitle),
            actions: [
              TwoRowComponent(
                horizontalPadding: 5,
                firstComponent: CustomButton(
                  verticalPadding: 5,
                  secondaryButton: true,
                  buttonText: "Cancel",
                  onPressed: () => Navigator.of(context).pop(),
                ),
                secondComponent: CustomButton(
                    verticalPadding: 5,
                    buttonText: confirmationButtonText,
                    onPressed: () {
                      sure();
                    }),
              )
            ],
          );
        });
  }
}
