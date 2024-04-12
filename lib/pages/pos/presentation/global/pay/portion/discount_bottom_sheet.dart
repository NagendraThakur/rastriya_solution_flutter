import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/model/product_model.dart';
import 'package:rastriya_solution_flutter/pages/pos/cubit/pos_cubit.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';
import 'package:rastriya_solution_flutter/widgets/textfield.dart';
import 'package:rastriya_solution_flutter/widgets/two_row_component.dart';

void discountBottomSheet(
    {required BuildContext context, required double width}) {
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
        TextEditingController review = TextEditingController();
        return BlocBuilder<PosCubit, PosState>(
          builder: (context, state) {
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
                        "Discount",
                        style: kHeading3TextStyle,
                      ),
                      const CloseButton()
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Item Total",
                        style: kHeading3TextStyle,
                      ),
                      Text(
                        state.totalAmount.toStringAsFixed(2),
                        style: kHeading3TextStyle,
                      ),
                    ],
                  ),
                  verticalSpaceSmall,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomTextField(
                        labelText: "Percentage",
                        width: width * 0.4,
                        onChanged: (String? discountPercentage) {
                          if (discountPercentage != null) {
                            BlocProvider.of<PosCubit>(context)
                                .assignDiscountPercentage(
                                    discountPercentage:
                                        double.tryParse(discountPercentage) ??
                                            0);
                          }
                        },
                      ),
                      const Icon(
                        CupertinoIcons.link_circle,
                        size: 45,
                      ),
                      CustomTextField(
                        enabled: false,
                        labelText: "Amount",
                        controller: TextEditingController(
                            text: state.discountAmount.toStringAsFixed(2)),
                        width: width * 0.4,
                      ),
                    ],
                  ),
                  verticalSpaceRegular,
                  TwoRowComponent(
                      horizontalPadding: 0,
                      middleSpace: true,
                      firstComponent: CustomButton(
                          secondaryButton: true,
                          buttonText: "Clear",
                          onPressed: () {
                            BlocProvider.of<PosCubit>(context)
                                .assignDiscountPercentage(
                                    discountPercentage: 0);
                            Navigator.of(context).pop();
                          }),
                      secondComponent: CustomButton(
                          buttonText: "Save",
                          onPressed: () {
                            Navigator.of(context).pop();
                          }))
                ],
              ),
            );
          },
        );
      });
}
