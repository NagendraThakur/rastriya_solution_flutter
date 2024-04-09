import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rastriya_solution_flutter/model/payment_mode_model.dart';
import 'package:rastriya_solution_flutter/pages/pos/cubit/pos_cubit.dart';
import 'package:rastriya_solution_flutter/pages/pos/presentation/global/pay/portion/multi_payment_dialog.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/border_container.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';
import 'package:rastriya_solution_flutter/widgets/container.dart';
import 'package:rastriya_solution_flutter/widgets/two_row_component.dart';

class PayPage extends StatefulWidget {
  const PayPage({super.key});

  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  String? selectedPaymentMode;
  bool multiPayment = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<PosCubit, PosState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              leading: const CupertinoNavigationBarBackButton(),
              title: Text("${state.selectedTable?.tableName ?? ""} Pay"),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    BorderContainer(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Bill Summary",
                                style: kHeading3TextStyle,
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(CupertinoIcons.eye))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 150,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/svg/bowl.svg",
                                      width: 25,
                                    ),
                                    Text(
                                      " Item Total (${state.orderQuantity})",
                                      style: kSubtitleRegularTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "Rs ${state.totalAmount.toStringAsFixed(2)}",
                                style: kSubtitleRegularTextStyle,
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "- Discount (${state.discountPercentage.toStringAsFixed(1) == "0.0" ? "0" : state.discountPercentage.toStringAsFixed(1)} %)",
                                    style: kSubtitleRegularTextStyle,
                                  ),
                                  InkWell(
                                    child: CustomContainer(
                                        innerHorizontalPadding: 2,
                                        innerVerticalPadding: 2,
                                        color: Colors.grey.shade200,
                                        child: Text(
                                          "Edit",
                                          style: kSmallRegularTextStyle,
                                        )),
                                  )
                                ],
                              ),
                              Text(
                                "Rs ${state.discountAmount.toStringAsFixed(2)}",
                                style: kSubtitleRegularTextStyle,
                              )
                            ],
                          ),
                          verticalSpaceRegular,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Grand Total",
                                style: kSubtitleTextStyle,
                              ),
                              Text(
                                "Rs ${state.totalAmount.toStringAsFixed(2)}",
                                style: kSubtitleTextStyle,
                              )
                            ],
                          ),
                          verticalSpaceSmall,
                          // TwoRowComponent(
                          //   horizontalPadding: 0,
                          //   middleSpace: true,
                          //   firstComponent: BorderContainer(
                          //       padding:
                          //           const EdgeInsets.symmetric(vertical: 10),
                          //       child: Row(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: [
                          //           const Icon(
                          //             Icons.add_box_outlined,
                          //             size: 20,
                          //           ),
                          //           Text(
                          //             "Add Customer",
                          //             style: kBodyRegularTextStyle.copyWith(
                          //                 fontSize: 14),
                          //           ),
                          //         ],
                          //       )),
                          //   secondComponent: BorderContainer(
                          //       padding:
                          //           const EdgeInsets.symmetric(vertical: 10),
                          //       child: Row(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: [
                          //           const Icon(
                          //             Icons.add_box_outlined,
                          //             size: 20,
                          //           ),
                          //           Text(
                          //             "Add Loyalty Member",
                          //             style: kBodyRegularTextStyle.copyWith(
                          //                 fontSize: 14),
                          //           ),
                          //         ],
                          //       )),
                          // ),
                          // verticalSpaceSmall,
                        ],
                      ),
                    ),
                    verticalSpaceSmall,
                    SizedBox(
                      width: width,
                      child: BorderContainer(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: kSubtitleTextStyle,
                                children: [
                                  TextSpan(
                                    text: "Payment Method",
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      color: Colors.grey.shade900,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "*",
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      color: Colors.red.shade800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TwoRowComponent(
                                horizontalPadding: 0,
                                middleSpace: true,
                                firstComponent: CustomButton(
                                    buttonText: "Paid", onPressed: () {}),
                                secondComponent: CustomButton(
                                    secondaryButton: true,
                                    enable: false,
                                    buttonText: "UnPaid/Due",
                                    onPressed: () {})),
                            Visibility(
                              visible: !multiPayment,
                              child: Wrap(
                                spacing: 8.0,
                                runSpacing: 8.0,
                                children:
                                    state.paymentModeList!.map((paymentMode) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedPaymentMode = paymentMode.name;
                                      });
                                      BlocProvider.of<PosCubit>(context)
                                          .clearpaidPaymentModeList();
                                      BlocProvider.of<PosCubit>(context)
                                          .addpaidPaymentMode(
                                              paidPaymentMode:
                                                  paymentMode.copyWith(
                                                      amount:
                                                          state.totalAmount));
                                    },
                                    child: BorderContainer(
                                      color: Colors.grey.shade200,
                                      borderColor: selectedPaymentMode ==
                                              paymentMode.name
                                          ? Colors.blue
                                          : Colors.grey.shade200,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 45),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(paymentMode.name,
                                                style:
                                                    kSubtitleRegularTextStyle),
                                            horizontalSpaceSmall,
                                            if (selectedPaymentMode ==
                                                paymentMode.name)
                                              const Icon(
                                                CupertinoIcons.checkmark_circle,
                                                color: Colors.blue,
                                              )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            verticalSpaceSmall,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(
                                  children: [
                                    Text("Multiple Payment"),
                                    Icon(CupertinoIcons.question_circle),
                                  ],
                                ),
                                CupertinoSwitch(
                                    value: multiPayment,
                                    onChanged: (value) {
                                      setState(() {
                                        multiPayment = value;
                                        selectedPaymentMode = null;
                                        BlocProvider.of<PosCubit>(context)
                                            .clearpaidPaymentModeList();
                                      });
                                    })
                              ],
                            ),
                            Visibility(
                              visible: multiPayment,
                              child: Wrap(
                                spacing: 8.0,
                                runSpacing: 8.0,
                                children:
                                    state.paymentModeList!.map((paymentMode) {
                                  return GestureDetector(
                                    onTap: () {
                                      double paidAmount = 0;
                                      state.paidPaymentModeList?.forEach(
                                        (element) {
                                          paidAmount =
                                              element.amount! + paidAmount;
                                        },
                                      );
                                      double remainingAmount =
                                          state.totalAmount - paidAmount;
                                      if (remainingAmount > 0) {
                                        payDialogWithPaymentMode(
                                            context: context,
                                            paymentMode: paymentMode,
                                            amount:
                                                (state.totalAmount - paidAmount)
                                                    .toStringAsFixed(2));
                                      }
                                    },
                                    child: BorderContainer(
                                      color: Colors.grey.shade200,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 45),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(paymentMode.name,
                                                style:
                                                    kSubtitleRegularTextStyle),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            verticalSpaceSmall,
                            if (state.paidPaymentModeList != null)
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: state.paidPaymentModeList?.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    PaymentModeModel mode =
                                        state.paidPaymentModeList![index];

                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "- ${mode.name}",
                                          style: kSubtitleRegularTextStyle,
                                        ),
                                        Text(
                                          "Rs ${mode.amount!.toStringAsFixed(2)}",
                                          style: kSubtitleRegularTextStyle,
                                        )
                                      ],
                                    );
                                  }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "- Total Amount",
                                  style: kSubtitleRegularTextStyle,
                                ),
                                Text(
                                  "Rs ${state.paidAmount?.toStringAsFixed(2)}",
                                  style: kSubtitleRegularTextStyle,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "- Remaining Amount",
                                  style: kSubtitleRegularTextStyle,
                                ),
                                Text(
                                  "Rs ${(state.totalAmount - (state.paidAmount ?? 0)).toStringAsFixed(2)}",
                                  style: kSubtitleRegularTextStyle,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            bottomNavigationBar: TwoRowComponent(
              horizontalPadding: 10,
              firstComponent: CustomButton(
                secondaryButton: true,
                buttonText: "Cear",
                onPressed: () {
                  setState(() {
                    selectedPaymentMode = null;
                    BlocProvider.of<PosCubit>(context)
                        .clearpaidPaymentModeList();
                  });
                },
              ),
              secondComponent: CustomButton(
                buttonText: "Pay",
                onPressed: () {
                  BlocProvider.of<PosCubit>(context).createSalesBill();
                },
              ),
            ));
      },
    );
  }
}
