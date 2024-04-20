// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/helper/dialog_utility.dart';
import 'package:rastriya_solution_flutter/helper/toastification.dart';

import 'package:rastriya_solution_flutter/model/purchase_model.dart';
import 'package:rastriya_solution_flutter/pages/purchase_module/cubit/purchase_cubit.dart';
import 'package:rastriya_solution_flutter/widgets/border_container.dart';
import 'package:rastriya_solution_flutter/widgets/mini_bottom_sheet.dart';
import 'package:toastification/toastification.dart';

class PurchaseBillListPage extends StatefulWidget {
  final bool? showSummary;
  const PurchaseBillListPage({
    Key? key,
    this.showSummary = false,
  }) : super(key: key);

  @override
  State<PurchaseBillListPage> createState() => _PurchaseBillListPageState();
}

class _PurchaseBillListPageState extends State<PurchaseBillListPage> {
  String? status;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      BlocProvider.of<PurchaseCubit>(context).fetchPurchaseBill();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PurchaseCubit, PurchaseState>(
      listener: (context, state) {
        if (state.isLoading == true) {
          return DialogUtils.showProcessingDialog(context);
        } else if (state.isLoading == false) {
          Navigator.of(context).pop();
        } else if (state.message != null) {
          showToastification(
              context: context,
              message: state.message!,
              toastificationType: state.message!.contains("Failed")
                  ? ToastificationType.error
                  : ToastificationType.success);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Purchase Order"),
            leading: const CupertinoNavigationBarBackButton(),
            actions: [
              MiniBottomSheet(
                  avatarInitials: "S",
                  hintText: "",
                  label: "Status",
                  value: status,
                  onChanged: (String? value) {
                    setState(() {
                      status = value;
                    });
                  },
                  items: const [
                    DropdownMenuItem(value: null, child: Text("All")),
                    DropdownMenuItem(value: "OPEN", child: Text("Open")),
                    DropdownMenuItem(value: "CLOSED", child: Text("Close")),
                  ]),
            ],
          ),
          body: state.isFetching == true
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: state.filteredPurchaseList.length,
                  itemBuilder: (BuildContext context, int index) {
                    PurchaseModel purchaseInfo =
                        state.filteredPurchaseList[index];
                    if (status == null || status == purchaseInfo.status) {
                      return BorderContainer(
                        outerPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                "/edit_purchase_bill",
                                arguments: purchaseInfo);
                          },
                          leading: const CircleAvatar(child: Text("PB")),
                          title: Text(purchaseInfo.billNo ?? ""),
                          subtitle: Text(
                              "${purchaseInfo.vendorName}(${purchaseInfo.vendorCode})"),
                          trailing: Text(
                              "Rs ${purchaseInfo.amount!.toStringAsFixed(2)}\n${purchaseInfo.createdUserData?.username}"),
                        ),
                      );
                    }
                  }),
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).pushNamed("/edit_purchase_bill");
              },
              icon: const Icon(CupertinoIcons.add),
              label: const Text("Add Purchase Bill")),
        );
      },
    );
  }
}
