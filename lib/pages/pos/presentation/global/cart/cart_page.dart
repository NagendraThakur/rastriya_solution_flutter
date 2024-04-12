import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/helper/dialog_utility.dart';
import 'package:rastriya_solution_flutter/helper/toastification.dart';
import 'package:rastriya_solution_flutter/pages/pos/cubit/pos_cubit.dart';
import 'package:rastriya_solution_flutter/pages/pos/portion/order/order_portion.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';
import 'package:rastriya_solution_flutter/widgets/two_row_component.dart';
import 'package:toastification/toastification.dart';

class CartPage extends StatefulWidget {
  final bool? payButton;
  CartPage({super.key, this.payButton});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool enable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrderPortion(
        leading: true,
        enableEditProduct: true,
        enbaleButtons: false,
      ),
      bottomNavigationBar: TwoRowComponent(
          firstComponent: CustomButton(
              secondaryButton: true,
              buttonText: "Clear",
              onPressed: () {
                BlocProvider.of<PosCubit>(context).clearOrder();
                Navigator.of(context).pop();
              }),
          secondComponent: CustomButton(
              buttonText: widget.payButton == true ? "Pay" : "Save",
              enable: enable,
              onPressed: () async {
                if (widget.payButton == true) {
                  Navigator.of(context).popAndPushNamed("/pay");
                  return;
                }

                enable = false;
                setState(() {});

                final cubit = BlocProvider.of<PosCubit>(context);
                final salesOrder =
                    await cubit.getSalesOrderByTable(tableId: null);

                if (salesOrder != null) {
                  await cubit.assignSalesLineToOrderList(
                      billLineList: salesOrder.orderBillLine);
                }

                final requestType = salesOrder == null ? "post" : "put";

                Future.delayed(Duration.zero,
                    () => DialogUtils.showProcessingDialog(context));
                final orderBill = await cubit.salesOrder(
                  requestType: requestType,
                  orderStatus: "open",
                );

                Future.delayed(
                    Duration.zero, () => Navigator.of(context).pop());

                if (orderBill == null) {
                  Future.delayed(
                      Duration.zero,
                      () => showToastification(
                          message: "something went wrong",
                          context: context,
                          toastificationType: ToastificationType.warning));
                  enable = true;
                } else {
                  Future.delayed(Duration.zero, () {
                    Navigator.of(context).pop();
                    Navigator.of(context)
                        .popAndPushNamed("/kot", arguments: orderBill);
                  });
                }
              })),
    );
  }
}
