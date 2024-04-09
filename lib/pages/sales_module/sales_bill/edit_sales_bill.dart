// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rastriya_solution_flutter/model/bill_line_model.dart';

import 'package:rastriya_solution_flutter/model/bill_model.dart';
import 'package:rastriya_solution_flutter/model/sales_payment_mode.dart';
import 'package:rastriya_solution_flutter/pages/sales_module/sales_bill/cubit/sales_bill_cubit.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/border_container.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';
import 'package:rastriya_solution_flutter/widgets/container.dart';
import 'package:rastriya_solution_flutter/widgets/two_row_component.dart';

class EditSalesBill extends StatelessWidget {
  final BillModel bill;
  const EditSalesBill({
    Key? key,
    required this.bill,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<SalesBillCubit, SalesBillState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: const CupertinoNavigationBarBackButton(),
            title: const Text("Sales Bill"),
          ),
          body: SingleChildScrollView(
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
                          Text(
                            "Bill No:",
                            style: kSubtitleTextStyle,
                          ),
                          Text(
                            bill.billNo,
                            style: kSubtitleTextStyle,
                          )
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
                                  " Item Total (${bill.totalQuantity})",
                                  style: kSubtitleRegularTextStyle,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "Rs ${bill.grossAmount!.toStringAsFixed(2)}",
                            style: kSubtitleRegularTextStyle,
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "- Discount",
                            style: kSubtitleRegularTextStyle,
                          ),
                          Text(
                            "Rs ${bill.discountAmount!.toStringAsFixed(2)}",
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
                            "Rs ${bill.billAmount!.toStringAsFixed(2)}",
                            style: kSubtitleTextStyle,
                          )
                        ],
                      ),
                      verticalSpaceSmall,
                    ],
                  ),
                ),
                verticalSpaceRegular,
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
                        if (bill.payments != null)
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: bill.payments?.length,
                              itemBuilder: (BuildContext context, int index) {
                                SalesPaymentMode mode = bill.payments![index];

                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "- ${mode.payMode}",
                                      style: kSubtitleRegularTextStyle,
                                    ),
                                    Text(
                                      "Rs ${mode.amount.toStringAsFixed(2)}",
                                      style: kSubtitleRegularTextStyle,
                                    )
                                  ],
                                );
                              }),
                      ],
                    ),
                  ),
                ),
                verticalSpaceRegular,
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
                                text: "Products",
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
                        if (bill.billLines != null)
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: bill.billLines?.length,
                              itemBuilder: (BuildContext context, int index) {
                                BillLine product = bill.billLines![index];
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${product.productName}\n${product.quantity?.toStringAsFixed(2)}",
                                      style: kSubtitleRegularTextStyle,
                                    ),
                                    Text(
                                      "Rs ${product.amount?.toStringAsFixed(2)}",
                                      style: kSubtitleRegularTextStyle,
                                    ),
                                  ],
                                );
                              }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: TwoRowComponent(
              firstComponent: CustomButton(
                  secondaryButton: true, buttonText: "Print", onPressed: () {}),
              secondComponent:
                  CustomButton(buttonText: "Sales Return", onPressed: () {})),
        );
      },
    );
  }
}
