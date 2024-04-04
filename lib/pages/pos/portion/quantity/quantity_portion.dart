import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/pages/pos/cubit/pos_cubit.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';

class QuantityPortion extends StatelessWidget {
  const QuantityPortion({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<PosCubit, PosState>(
      builder: (context, state) {
        return SizedBox(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                horizontalSpaceTiny,
                Text(
                  "QTY",
                  style: kBodyRegularTextStyle1,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      double quantity = index + 1;
                      return InkWell(
                        onTap: () {
                          context.read<PosCubit>().assignQuantity(quantity);
                        },
                        child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: state.quantity == quantity
                                      ? Colors.blue
                                      : Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(5)),
                              alignment: Alignment.center,
                              width: 50,
                              child: Text((quantity.toStringAsFixed(0))),
                            )),
                      );
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}
