import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rastriya_solution_flutter/model/payment_mode_model.dart';
import 'package:rastriya_solution_flutter/pages/pos/cubit/pos_cubit.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';
import 'package:rastriya_solution_flutter/widgets/textfield.dart';

payDialogWithPaymentMode({
  required PaymentModeModel paymentMode,
  required String amount,
  required BuildContext context,
}) {
  final formKey = GlobalKey<FormState>();

  TextEditingController textController = TextEditingController(text: amount);

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 1,
          scrollable: true,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                child: SvgPicture.asset(
                  "assets/svg/money.svg",
                  width: 45,
                ),
              ),
              Form(
                key: formKey,
                child: CustomTextField(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(top: 12, left: 15),
                    child: Text(
                      "Rs",
                      style: kSubtitleRegularTextStyle,
                    ),
                  ),
                  labelText: "${paymentMode.name} AMOUNT",
                  controller: textController,
                  textAlign: TextAlign.end,
                  textInputType: TextInputType.number,
                  selectAll: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter a amount';
                    } else if (double.tryParse(value) == null) {
                      return "Enter valid amount";
                    } else if (double.parse(value) > double.parse(amount)) {
                      return "Amount is too high";
                    }
                    return null;
                  },
                ),
              ),
              CustomButton(
                  buttonText: "Save",
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      PaymentModeModel paidPaymentMode = PaymentModeModel(
                          id: paymentMode.id,
                          name: paymentMode.name,
                          status: paymentMode.status,
                          ledgerCode: paymentMode.ledgerCode,
                          type: paymentMode.type,
                          image: paymentMode.image,
                          imagePath: paymentMode.imagePath,
                          amount: double.parse(textController.text));
                      BlocProvider.of<PosCubit>(context)
                          .addpaidPaymentMode(paidPaymentMode: paidPaymentMode);
                      Navigator.of(context).pop();
                    }
                  }),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Cancel"))
            ],
          ),
        );
      });
}
