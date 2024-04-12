// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rastriya_solution_flutter/model/purchase_model.dart';
import 'package:rastriya_solution_flutter/pages/purchase_module/cubit/purchase_cubit.dart';
import 'package:rastriya_solution_flutter/widgets/drop_down_button.dart';

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
  String? vendorId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PurchaseCubit, PurchaseState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: const CupertinoNavigationBarBackButton(),
            title: Text(widget.purchaseInfo == null
                ? "Create Purchase Order"
                : "Edit Purchase Order"),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                CustomDropDownButton(
                  avatarInitials: "C",
                  hintText: "Choose Vendor",
                  label: "Vendor",
                  value: vendorId,
                  padding: const EdgeInsets.only(top: 20),
                  onChanged: (String value) {
                    setState(() {
                      vendorId = value;
                    });
                  },
                  items: state.venderList.map((vendor) {
                    return DropdownMenuItem<String>(
                      value: vendor.id,
                      child: Text(vendor.name),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
