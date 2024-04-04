import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/model/product_model.dart';
import 'package:rastriya_solution_flutter/pages/pos/cubit/pos_cubit.dart';
import 'package:rastriya_solution_flutter/pages/pos/portion/order/portion/order_widget.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';
import 'package:rastriya_solution_flutter/widgets/textfield.dart';
import 'package:rastriya_solution_flutter/widgets/two_row_component.dart';

void editProductBottomSheet(
    {required BuildContext context,
    required ProductModel product,
    required double width}) {
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
        TextEditingController review =
            TextEditingController(text: product.review);
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
                    "Edit Product",
                    style: kHeading3TextStyle,
                  ),
                  const CloseButton()
                ],
              ),
              verticalSpaceSmall,
              orderWidget(
                  product: product, width: width, showNotePortion: false),
              CustomTextField(
                controller: review,
                maxLine: 4,
                hintText:
                    "Do you want to add anything as remarks for future reference?",
              ),
              verticalSpaceRegular,
              TwoRowComponent(
                  firstComponent: CustomButton(
                      secondaryButton: true,
                      buttonText: "Delete",
                      onPressed: () {}),
                  secondComponent: CustomButton(
                      buttonText: "Save",
                      onPressed: () {
                        BlocProvider.of<PosCubit>(context)
                            .editQuantity(review: review.text);
                        Navigator.of(context).pop();
                      }))
            ],
          ),
        );
      });
}
