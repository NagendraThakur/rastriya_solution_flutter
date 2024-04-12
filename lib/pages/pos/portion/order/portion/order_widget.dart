import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/model/product_model.dart';
import 'package:rastriya_solution_flutter/pages/pos/cubit/pos_cubit.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/border_container.dart';
import 'package:rastriya_solution_flutter/widgets/textfield.dart';

Widget orderWidget({
  required ProductModel product,
  required double width,
  required bool showNotePortion,
}) {
  return BlocBuilder<PosCubit, PosState>(
    builder: (context, state) {
      double quantity = state.quantity;

      return BorderContainer(
        outerPadding: const EdgeInsets.only(top: 5),
        // decoration: BoxDecoration(border: Border.all()),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(product.name),
              subtitle: Text(
                "${product.batch?.batchName ?? ""} @ ${product.lastUnitPrice!.toStringAsFixed(2)}",
                style: kBodyRegularTextStyle,
              ),
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    (product.quantity! * product.lastUnitPrice!)
                        .toStringAsFixed(2),
                    style: kSubtitleRegularTextStyle,
                  ),
                  if (!showNotePortion)
                    Container(
                      alignment: Alignment.center,
                      width: 120,
                      height: 32,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                if (quantity > 1) {
                                  BlocProvider.of<PosCubit>(context)
                                      .assignQuantity(state.quantity - 1);
                                }
                              },
                              icon: const Icon(
                                CupertinoIcons.minus_circle_fill,
                                size: 35,
                                color: Colors.blue,
                              )),
                          Text(quantity.toStringAsFixed(0),
                              style: kBodyRegularTextStyle1),
                          IconButton(
                              onPressed: () {
                                BlocProvider.of<PosCubit>(context)
                                    .assignQuantity(state.quantity + 1);
                              },
                              icon: const Icon(
                                CupertinoIcons.add_circled_solid,
                                size: 35,
                                color: Colors.blue,
                              )),
                        ],
                      ),
                    )
                ],
              ),
            ),
            showNotePortion
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextField(
                          enabled: false,
                          filled: false,
                          width: width * 0.6,
                          topPadding: 0,
                          prefixIcon: const Icon(CupertinoIcons.doc_text),
                          hintText: "Enter Remarks to Product",
                          controller:
                              TextEditingController(text: product.review),
                        ),
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.blue.shade800,
                              borderRadius: BorderRadius.circular(5)),
                          width: 50,
                          height: 50,
                          child: Text(
                            product.quantity!.toStringAsFixed(0),
                            style: kHeading3TextStyle.copyWith(
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(
              height: 15,
            )
          ],
        ),
      );
    },
  );
}
