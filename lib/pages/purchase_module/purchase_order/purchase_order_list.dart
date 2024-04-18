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
import 'package:toastification/toastification.dart';

class PurchaseOrderListPage extends StatefulWidget {
  final bool? showSummary;
  const PurchaseOrderListPage({
    Key? key,
    this.showSummary = false,
  }) : super(key: key);

  @override
  State<PurchaseOrderListPage> createState() => _PurchaseOrderListPageState();
}

class _PurchaseOrderListPageState extends State<PurchaseOrderListPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero, () {
      BlocProvider.of<PurchaseCubit>(context).fetchPurchaseOrder();
      BlocProvider.of<PurchaseCubit>(context).fetchLedger();
      BlocProvider.of<PurchaseCubit>(context).fetchProduct();
      BlocProvider.of<PurchaseCubit>(context).message();
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
                    return BorderContainer(
                      outerPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              "/edit_purchase_order",
                              arguments: purchaseInfo);
                        },
                        leading: const CircleAvatar(child: Text("PO")),
                        title: Text(purchaseInfo.billNo ?? ""),
                        subtitle: Text(
                            "${purchaseInfo.vendorName}(${purchaseInfo.vendorCode})"),
                        trailing: Text(
                            "Rs ${purchaseInfo.amount!.toStringAsFixed(2)}\n${purchaseInfo.createdUserData?.username}"),
                      ),
                    );
                  }),
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).pushNamed("/edit_purchase_order");
              },
              icon: const Icon(CupertinoIcons.add),
              label: const Text("Add Purchase Order")),
        );
      },
    );
  }
}
