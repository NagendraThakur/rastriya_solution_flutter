import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rastriya_solution_flutter/model/sales_order_model.dart';

Widget kotWidget({
  required OrderBillLineModel orderBillLine,
  required bool selected,
  required bool printed,
}) {
  return Container(
    decoration: BoxDecoration(border: Border.all()),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (printed)
                const Icon(
                  CupertinoIcons.checkmark_seal_fill,
                  color: Colors.green,
                ),
              Icon(
                CupertinoIcons.checkmark_seal_fill,
                color: selected ? Colors.blue : null,
              ),
            ],
          ),
          title: Text(orderBillLine.productInfo?.name ?? ""),
          trailing: Text(orderBillLine.quantity!.toStringAsFixed(0)),
        ),
      ],
    ),
  );
}
