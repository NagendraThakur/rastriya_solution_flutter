// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:rastriya_solution_flutter/model/purchase_model.dart';

class EditPurchaseOrder extends StatefulWidget {
  final PurchaseModel? purchaseInfo;
  const EditPurchaseOrder({
    Key? key,
    this.purchaseInfo,
  }) : super(key: key);

  @override
  State<EditPurchaseOrder> createState() => _EditPurchaseOrderState();
}

class _EditPurchaseOrderState extends State<EditPurchaseOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CupertinoNavigationBarBackButton(),
        title: Text(widget.purchaseInfo == null
            ? "Create Purchase Order"
            : "Edit Purchase Order"),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
