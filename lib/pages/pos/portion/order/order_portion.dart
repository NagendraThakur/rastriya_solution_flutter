import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/model/product_model.dart';
import 'package:rastriya_solution_flutter/pages/pos/cubit/pos_cubit.dart';
import 'package:rastriya_solution_flutter/pages/pos/portion/order/portion/bottom_sheet_widget.dart';
import 'package:rastriya_solution_flutter/pages/pos/portion/order/portion/order_widget.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';
import 'package:rastriya_solution_flutter/widgets/container.dart';

class OrderPortion extends StatefulWidget {
  final bool enableEditProduct;
  final bool enbaleButtons;
  final bool? leading;
  final Widget? bottomNavigationBar;
  final bool? enableCancelOrder;
  OrderPortion({
    super.key,
    required this.enableEditProduct,
    required this.enbaleButtons,
    this.leading = false,
    this.bottomNavigationBar,
    this.enableCancelOrder = false,
  });

  @override
  State<OrderPortion> createState() => _OrderPortionState();
}

class _OrderPortionState extends State<OrderPortion> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return BlocBuilder<PosCubit, PosState>(
      builder: (context, state) {
        return CustomContainer(
          rightBorder: true,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(state.selectedTable?.tableName ?? "Orders"),
              leading: widget.leading == true
                  ? const CupertinoNavigationBarBackButton()
                  : null,
              automaticallyImplyLeading: widget.leading!,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.orderList?.length ?? 0,
                      itemBuilder: ((context, index) {
                        ProductModel product = state.orderList![index];

                        return InkWell(
                            onTap: () {
                              BlocProvider.of<PosCubit>(context)
                                  .selectProduct(product: product);
                              if (widget.enableEditProduct) {
                                editProductBottomSheet(
                                    context: context,
                                    product: product,
                                    width: width);
                              } else if (widget.enableCancelOrder == true) {
                                Navigator.of(context).pushNamed("/void_order");
                              }
                            },
                            child: orderWidget(
                                product: product,
                                width: width,
                                showNotePortion: true));
                      }),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: kBodyRegularTextStyle1,
                      ),
                      Text(
                        "x  ${state.orderQuantity.toStringAsFixed(0)}",
                        style: kBodyRegularTextStyle1,
                      ),
                      Text(
                        "Rs ${state.subtotal.toStringAsFixed(2)}",
                        style: kBodyRegularTextStyle1,
                        textAlign: TextAlign.end,
                      ),
                    ],
                  )
                ],
              ),
            ),
            bottomNavigationBar: widget.bottomNavigationBar ??
                (widget.enbaleButtons
                    ? CustomButton(
                        verticalPadding: 5,
                        buttonText: "Pay",
                        enable: Config.permissionInfo?.documentPostingLevel ==
                                "posting" &&
                            state.orderList != null &&
                            state.orderList!.isNotEmpty,
                        onPressed: () {
                          // if (state.loyaltyMember != null) {
                          //   await BlocProvider.of<PosCubit>(context)
                          //       .fetchLoyaltyMemberDiscount();
                          //   Navigator.of(context).pop();
                          // } else {
                          //   BlocProvider.of<PosCubit>(context)
                          //       .assignDiscountForOrder();
                          // }
                          Navigator.of(context).pushNamed("/pay");
                        })
                    : null),
          ),
        );
      },
    );
  }
}
