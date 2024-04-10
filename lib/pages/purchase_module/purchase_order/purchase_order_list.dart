// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rastriya_solution_flutter/model/purchase_model.dart';
import 'package:rastriya_solution_flutter/pages/purchase_module/cubit/purchase_cubit.dart';
import 'package:rastriya_solution_flutter/widgets/border_container.dart';

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
    Future.delayed(Duration.zero,
        () => BlocProvider.of<PurchaseCubit>(context).fetchPurchaseOrder());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PurchaseCubit, PurchaseState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Purchase Order"),
            leading: const CupertinoNavigationBarBackButton(),
          ),
          body: ListView.builder(
              itemCount: state.filteredPurchaseList.length,
              itemBuilder: (BuildContext context, int index) {
                PurchaseModel purchaseInfo = state.filteredPurchaseList[index];
                return BorderContainer(
                  outerPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: const CircleAvatar(child: Text("PO")),
                    title: Text(purchaseInfo.billNo ?? ""),
                    subtitle: Text(
                        "${purchaseInfo.vendorName}(${purchaseInfo.vendorCode})"),
                    trailing: Text(
                        "Rs ${purchaseInfo.amount!.toStringAsFixed(2)}\n${purchaseInfo.createdUserData?.username}"),
                  ),
                );
              }),
        );
      },
    );
  }
}
