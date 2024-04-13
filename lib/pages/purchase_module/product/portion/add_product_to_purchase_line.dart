import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/helper/numerical_range_formatter.dart';
import 'package:rastriya_solution_flutter/model/product_model.dart';
import 'package:rastriya_solution_flutter/pages/purchase_module/cubit/purchase_cubit.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';
import 'package:rastriya_solution_flutter/widgets/textfield.dart';
import 'package:rastriya_solution_flutter/widgets/two_row_component.dart';

void addProuductToPurchaseLine({
  required BuildContext context,
  required ProductModel product,
}) {
  showModalBottomSheet(
    context: context,
    scrollControlDisabledMaxHeightRatio: 0.9,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(10.0),
      ),
    ),
    builder: (BuildContext context) {
      TextEditingController quantity = TextEditingController(text: "1");
      TextEditingController lastUnitCost =
          TextEditingController(text: product.lastUnitCost?.toStringAsFixed(2));
      TextEditingController discountPercentage =
          TextEditingController(text: "0");
      TextEditingController discountAmount = TextEditingController(text: "0");

      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          double calculateNetAmount() {
            double quantityValue = double.tryParse(quantity.text) ?? 0;
            double lastUnitCostValue = double.tryParse(lastUnitCost.text) ?? 0;
            return quantityValue * lastUnitCostValue;
          }

          double netAmount = calculateNetAmount();
          void updateDiscountAmount() {
            double percentage = double.tryParse(discountPercentage.text) ?? 0;
            double discount = (percentage / 100) * netAmount;
            discountAmount.text = discount.toStringAsFixed(2);
          }

          void updateDiscountPercentage() {
            double amount = double.tryParse(discountAmount.text) ?? 0;
            double percentage = (amount / netAmount) * 100;
            discountPercentage.text = percentage.toStringAsFixed(2);
          }

          return Padding(
            padding: EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                verticalSpaceSmall,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.name,
                      style: kHeading3TextStyle,
                    ),
                    const CloseButton()
                  ],
                ),
                verticalSpaceSmall,
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Net Total : Rs ${netAmount.toStringAsFixed(2)}    ",
                    style: kSubtitleTextStyle,
                  ),
                ),
                TwoRowComponent(
                  firstComponent: CustomTextField(
                    hintText: "Enter Quantity",
                    labelText: "Quantity",
                    controller: quantity,
                    textInputType: const TextInputType.numberWithOptions(),
                    selectAll: true,
                    onChanged: (value) {
                      setState(() {
                        netAmount = calculateNetAmount();
                      });
                    },
                  ),
                  secondComponent: CustomTextField(
                    hintText: "Enter Rate",
                    labelText: "Rate",
                    controller: lastUnitCost,
                    textInputType: const TextInputType.numberWithOptions(),
                    selectAll: true,
                    onChanged: (value) {
                      setState(() {
                        netAmount = calculateNetAmount();
                      });
                    },
                  ),
                ),
                verticalSpaceSmall,
                TwoRowComponent(
                  firstComponent: CustomTextField(
                    hintText: "Enter Discount %",
                    labelText: "Discount %",
                    controller: discountPercentage,
                    selectAll: true,
                    textInputType: const TextInputType.numberWithOptions(),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(3),
                      NumericalRangeFormatter(min: 1, max: 100),
                    ],
                    onChanged: (value) {
                      setState(() {
                        updateDiscountAmount();
                      });
                    },
                  ),
                  secondComponent: CustomTextField(
                    hintText: "Enter Discount Amt",
                    labelText: "Discount Amt",
                    controller: discountAmount,
                    selectAll: true,
                    textInputType: const TextInputType.numberWithOptions(),
                    inputFormatters: [
                      NumericalRangeFormatter(min: 0, max: netAmount.toInt()),
                    ],
                    onChanged: (value) {
                      setState(() {
                        updateDiscountPercentage();
                      });
                    },
                  ),
                ),
                verticalSpaceRegular,
                TwoRowComponent(
                  horizontalPadding: 0,
                  middleSpace: true,
                  firstComponent: CustomButton(
                    secondaryButton: true,
                    buttonText: "Cancel",
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  secondComponent: CustomButton(
                    buttonText: "Save",
                    onPressed: () {
                      BlocProvider.of<PurchaseCubit>(context)
                          .assignProductToPurchaseLine(product: product);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
