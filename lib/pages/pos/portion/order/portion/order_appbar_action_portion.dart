import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/helper/toastification.dart';
import 'package:rastriya_solution_flutter/model/ledger_model.dart';
import 'package:rastriya_solution_flutter/model/loyalty_member_model.dart';
import 'package:rastriya_solution_flutter/pages/pos/cubit/pos_cubit.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:toastification/toastification.dart';

class OrderAppBarActions extends StatelessWidget {
  final bool enableClear;
  final bool enableCancelOrder;

  const OrderAppBarActions(
      {Key? key, required this.enableClear, required this.enableCancelOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String choice) {
        switch (choice) {
          case "loyalty_member":
            Navigator.of(context).pushNamed("/loyalty_member").then((value) {
              if (value is LoyaltyMemberModel) {
                BlocProvider.of<PosCubit>(context)
                    .assignLoyaltyMember(loyaltyMember: value);
              }
            });
            break;
          case "registered_customer":
            Navigator.of(context)
                .pushNamed("/registered_customer")
                .then((value) {
              if (value is LedgerModel) {
                BlocProvider.of<PosCubit>(context)
                    .assignLedger(customer: value);
              }
            });
            break;
          case "local_customer":
            Navigator.of(context).pushNamed("/local_customer");
            break;
          case "invoice_discount":
            if (Config.permissionInfo?.isAdmin == "0") {
              showToastification(
                  message: "Permission denied",
                  context: context,
                  toastificationType: ToastificationType.warning);
              return;
            }
            // DialogUtils.discountDialog(
            //   context: context,
            //   title: "Invoice Discount",
            //   subtitle: "Discount Percentage",
            //   textAlign: TextAlign.end,
            //   suffixIcon: const Icon(Icons.percent),
            //   textInputType: TextInputType.number,
            //   doubleOnly: true,
            //   invalidMessage: "Invalid Percentage",
            //   maxLength: 2,
            //   onSave: (String? discountPercentage) {
            //     if (discountPercentage != null) {
            //       BlocProvider.of<PosCubit>(context).assignDiscountPercentage(
            //           discountPercentage:
            //               double.tryParse(discountPercentage) ?? 0);
            //     }
            //   },
            // );
            break;
          case "clear":
            BlocProvider.of<PosCubit>(context).clearOrder();
            break;
          case "cancel_order":
            Navigator.of(context).pushNamed("/cancel_order");
            // BlocProvider.of<PosCubit>(context)
            //     .salesOrder(requestType: "put", orderStatus: "closed")
            //     .then((value) => Navigator.of(context).pop());
            break;
        }
      },
      itemBuilder: (BuildContext context) {
        List<PopupMenuEntry<String>> menuItems = [
          PopupMenuItem<String>(
            value: "loyalty_member",
            child: Text(
              "Loyalty Member",
              style: kBodyTextStyle,
            ),
          ),
          PopupMenuItem<String>(
            value: "registered_customer",
            child: Text(
              "Registered Customer",
              style: kBodyTextStyle,
            ),
          ),
          PopupMenuItem<String>(
            value: "local_customer",
            child: Text(
              "Local Customer",
              style: kBodyTextStyle,
            ),
          ),
          PopupMenuItem<String>(
            value: "invoice_discount",
            child: Text(
              "Invoice Discount",
              style: kBodyTextStyle,
            ),
          ),
        ];

        if (enableClear) {
          menuItems.add(
            PopupMenuItem<String>(
              value: "clear",
              child: Text(
                "Clear",
                style: kBodyTextStyle,
              ),
            ),
          );
        }
        if (enableCancelOrder) {
          menuItems.add(
            PopupMenuItem<String>(
              value: "cancel_order",
              child: Text(
                "Cancel Order",
                style: kBodyTextStyle,
              ),
            ),
          );
        }

        return menuItems;
      },
    );
  }
}
